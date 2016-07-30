//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "EditStoreViewController.h"

@interface EditStoreViewController ()

@end

@implementation EditStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImage];
    [self loadLabels];
    _imageSelected = false;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) loadImage {
    [_image_view setImage:store .medium_image];
}

- (void) loadLabels {
    _store_name_label.text = store .store_name;
    _address_label.text = store .address;
    _city_label.text = store .city;
    _state_label.text = store .state;
    _phone_number_label.text = store .phone_number;
}

- (void) updateStoreProfile {
    [self updateFirebaseDatabase];
    [self updateClassObjectValues];
    if(_imageSelected){
        [self updateFirebaseStorage];
    }
}

- (void) updateFirebaseDatabase{
    [[[firebaseRef.storesRef child:store.store_key] child:@"store_name"]setValue:_store_name_label.text];
    [[[firebaseRef.storesRef child:store.store_key] child:@"image_name"]setValue:store.store_key];
    [[[[firebaseRef.storesRef child:store.store_key] child:@"location"] child:@"address"] setValue:_address_label.text];
    [[[[firebaseRef.storesRef child:store.store_key] child:@"location"] child:@"city"]setValue:_city_label.text];
    [[[[firebaseRef.storesRef child:store.store_key] child:@"location"] child:@"state"]setValue:_state_label.text];
    [[[firebaseRef.storesRef child:store.store_key] child:@"phone_number"]setValue:_phone_number_label.text];
}

- (void) updateClassObjectValues {
    store .store_name = _store_name_label.text;
    store .address = _address_label.text;
    store .city = _city_label.text;
    store .state = _state_label.text;
    store .phone_number = _phone_number_label.text;
}

- (void) updateFirebaseStorage {
    FIRStorageReference *medium_image_ref = [firebaseRef.stores_medium_images_ref child:store.store_key];
    NSData *medium_data = UIImagePNGRepresentation(store .medium_image); //Converts UIImage to Data for Storage upload
    FIRStorageUploadTask *uploadTask = [self uploadImage:medium_data ToRef:medium_image_ref];
    [uploadTask observeStatus:FIRStorageTaskStatusSuccess handler:^(FIRStorageTaskSnapshot *snapshot) {
        // Upload completed successfully
    }];
}

- (FIRStorageUploadTask *) uploadImage:(NSData *)data ToRef:(FIRStorageReference *)ref {
    FIRStorageUploadTask *uploadTask = [ref putData:data metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
        if (error != nil) {
            // Uh-oh, an error occurred!
        } else {
            // Metadata contains file metadata such as size, content-type, and download URL.
            //NSURL *downloadURL = metadata.downloadURL;
        }
    }];
    return uploadTask;
}

- (void) gecodeAddress:(NSString *)address{
    NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/geocode/json?";
    NSString *url = [NSString stringWithFormat:@"%@address=%@&sensor=false", geocodingBaseURL, address];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *queryURL = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:queryURL];
    [self fetchedData:data];
}

- (void) fetchedData:(NSData *)data{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    NSArray *results = [json objectForKey:@"results"];
    NSDictionary *result = [results objectAtIndex:0];
    NSDictionary *geometry = [result objectForKey:@"geometry"];
    NSDictionary *location = [geometry objectForKey:@"location"];
    store .latitude = [location objectForKey:@"lat"];
    store .longitude = [location objectForKey:@"lng"];
    store .google_place_id = [result objectForKey:@"place_id"];
}

- (void)loadFirstPhotoForPlace:(NSString *)placeID {
    GMSPlacesClient *place_client = [GMSPlacesClient sharedClient];
    [place_client lookUpPhotosForPlaceID:placeID callback:^(GMSPlacePhotoMetadataList *_Nullable photos, NSError *_Nullable error) {
        if (error) {
            // TODO: handle the error.
            NSLog(@"loadFirstPhotoForPlace Error: %@", [error description]);
        } else {
            if (photos.results.count > 0) {
                GMSPlacePhotoMetadata *firstPhoto = photos.results.firstObject;
                [self loadImageForMetadata:firstPhoto];
            }
        }
    }];
}

- (void)loadImageForMetadata:(GMSPlacePhotoMetadata *)photoMetadata {
    GMSPlacesClient *place_client = [GMSPlacesClient sharedClient];
    [place_client loadPlacePhoto:photoMetadata constrainedToSize:self.image_view.bounds.size scale:self.image_view.window.screen.scale callback:^(UIImage *_Nullable photo, NSError *_Nullable error) {
        if (error) {
            NSLog(@"Error: %@", [error description]);
        } else {
            _imageSelected = true;
            [self.image_view setImage: photo];
        }
    }];
}

- (IBAction)tappedImageView:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSString *addressFormatted = [NSString stringWithFormat:@"%@%@%@", store .address, store .city, store .state];
    [self gecodeAddress:addressFormatted];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Check Google Place Photos" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self loadFirstPhotoForPlace:store .google_place_id];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        picker2 = [[UIImagePickerController alloc] init];
        self->picker2.delegate = self;
        [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:picker2 animated:YES completion:NULL];
        // Distructive button tapped.[self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        picker = [[UIImagePickerController alloc] init];
        self->picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:picker animated:YES completion:NULL];
        // OK button tapped. [self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.image_view.contentMode  = UIViewContentModeScaleAspectFit;
    [self.image_view setImage:image];
    _imageSelected = true;
    [self loadImagesToClassObject];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) loadImagesToClassObject{
    store .medium_image = [[self class] imageWithImage:image scaledToWidth:150];
}

+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (IBAction)tappedDoneButton:(UIBarButtonItem *)sender {
    [self updateStoreProfile];
    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
