//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "AddStoreViewController.h"

@interface AddStoreViewController ()

@end

@implementation AddStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_store_name_field becomeFirstResponder];
    _imageSelected = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)address_field_changed:(id)sender {
    store.address = _address_field.text;
}

- (IBAction)city_field_changed:(id)sender {
    store.city = _city_field.text;
}

- (IBAction)state_field_changed:(id)sender {
    store.state = _state_field.text;
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
    store.latitude = [location objectForKey:@"lat"];
    store.longitude = [location objectForKey:@"lng"];
    store.google_place_id = [result objectForKey:@"place_id"];
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
    [place_client loadPlacePhoto:photoMetadata constrainedToSize:self.imageView.bounds.size scale:self.imageView.window.screen.scale callback:^(UIImage *_Nullable photo, NSError *_Nullable error) {
        if (error) {
            NSLog(@"Error: %@", [error description]);
        } else {
            [self.imageView setImage: photo];
            _imageSelected = true;
            [self loadImagesToClassObject:photo];
        }
    }];
}
- (IBAction)tappedImageView:(UITapGestureRecognizer *)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSString *addressFormatted = [NSString stringWithFormat:@"%@%@%@", store.address, store.city, store.state];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Check Google Place Photos" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self gecodeAddress:addressFormatted];
        [self loadFirstPhotoForPlace:store.google_place_id];
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
    self.imageView.contentMode  = UIViewContentModeScaleAspectFit;
    [self.imageView setImage:image];
    _imageSelected = true;
    [self loadImagesToClassObject:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) loadImagesToClassObject:(UIImage *)Image{
    store.medium_image = [[self class] imageWithImage:Image scaledToWidth:1500];
    store.small_image = [[self class] imageWithImage:Image scaledToWidth:100];
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

- (void) updateClassObjectValues {
    store.store_name = _store_name_field.text;
    store.address = _address_field.text;
    store.city = _city_field.text;
    store.state = _state_field.text;
    store.phone_number = _phone_number_field.text;
}

- (void) updateFirebaseValues{
    [[[firebaseRef.storesRef child:store.store_key] child:@"store_name"] setValue:store.store_name];
    [[[[firebaseRef.storesRef child:store.store_key] child:@"location"] child:@"address" ] setValue:store.address];
    [[[[firebaseRef.storesRef child:store.store_key] child:@"location"] child:@"city" ] setValue:store.city];
    [[[[firebaseRef.storesRef child:store.store_key] child:@"location"] child:@"state" ] setValue:store.state];
    [[[[firebaseRef.storesRef child:store.store_key] child:@"location"] child:@"latitude" ] setValue:store.latitude];
    [[[[firebaseRef.storesRef child:store.store_key] child:@"location"] child:@"longitude" ] setValue:store.longitude];
    [[[firebaseRef.storesRef child:store.store_key] child:@"phone_number"] setValue:store.phone_number];
    [[[firebaseRef.storesRef child:store.store_key] child:@"google_place_id"] setValue:store.google_place_id];
    [[[firebaseRef.storesRef child:store.store_key] child:@"url"]  setValue:store.url];
    [[[firebaseRef.storesRef child:store.store_key] child:@"phone_number"] setValue:store.phone_number];
    [[[firebaseRef.storesRef child:store.store_key] child:@"rating_count"] setValue:@""];
    [[[firebaseRef.storesRef child:store.store_key] child:@"rating_score"] setValue:@""];
    [[[firebaseRef.storesRef child:store.store_key] child:@"sells"] setValue:@""];
}

- (NSDictionary *)storeLocation{
    NSDictionary *dictionaryLocation= @{@"address": @"",
                                        @"city":@"",
                                        @"state":@"",
                                        @"latitude":@"",
                                        @"longitude":@"",};
    return dictionaryLocation;
}

- (NSDictionary *)storeStats{
    NSDictionary *strainStats= @{@"total_count":@"",
                                 @"monthly_count":@"",
                                 @"total_user_count":@""};
    return strainStats;
}
- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];

}
- (IBAction)tapped_submit_button:(UIButton *)sender {
    if(_imageSelected){
        NSDictionary *dict2 = [self storeLocation];
        NSDictionary *dict3 = [self storeStats];
        store.store_key = [firebaseRef.storesRef childByAutoId].key;
  
        [[[firebaseRef.storesRef child:store.store_key] child:@"location"]setValue:dict2];
        [[[firebaseRef.storesRef child:store.store_key] child:@"stats"]setValue:dict3];
        
        [self updateClassObjectValues];
        [self updateFirebaseValues];
        
        CGSize size = CGSizeMake(500, 500);
        UIImage *sizedImage = [[self class] imageWithImage:self.imageView.image scaledToSize:size];
        //NSString *encodedString = [UIImagePNGRepresentation(self.strainImageView.image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSData *encodedString = UIImagePNGRepresentation(sizedImage);
        NSLog(@"image encoded= %@", encodedString);
        
        NSURL *theURL = [NSURL URLWithString:@"https://api.imgur.com/3/image"];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
        
        //Specify method of request(Get or Post)
        [theRequest setHTTPMethod:@"POST"];
        
        //Pass some default parameter(like content-type etc.)
        [theRequest setValue:@"Client-ID bceb6364428afba" forHTTPHeaderField:@"Authorization"];
        
        //[theRequest setValue:encodedString forHTTPHeaderField:@"image"];
        [theRequest setHTTPBody:encodedString];
        NSURLResponse *theResponse = NULL;
        NSError *theError = NULL;
        NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
        
        NSDictionary *dataDictionaryResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:0 error:&theError];
        NSLog(@"url to send request= %@",theURL);
        NSLog(@"%@",dataDictionaryResponse);
        
        NSDictionary *output = [dataDictionaryResponse valueForKey:@"data"];
        NSString *imageURL = [output valueForKey:@"link"];
        NSLog(@"url is %@", imageURL);
        
        [store.imageNames removeAllObjects];
        [store.imageNames addObject:imageURL];
        [[[[firebaseRef.storesRef child:store.store_key] child:@"images"] child:@"1" ] setValue:imageURL];

        [self performSegueWithIdentifier:@"createdStoreSegue" sender:self];

        /*[uploadTask observeStatus:FIRStorageTaskStatusSuccess handler:^(FIRStorageTaskSnapshot *snapshot) {
            [self performSegueWithIdentifier:@"createdStoreSegue" sender:self];
        }];*/

    }
    else if (!_imageSelected){
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Uh-oh!"
                                              message:@"Image not selected."
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {}];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
