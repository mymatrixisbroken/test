//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "EditStrainViewController.h"
@import Firebase;

@interface EditStrainViewController ()

@end

@implementation EditStrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadImage];
    [self loadLabels];
    [self loadSpeciesTypeControl];
    _imageSelected = false;
}

- (void) loadImage {
}

- (void) loadLabels {
    _strain_name_label.text = strain.strain_name;
    _thc_label.text = strain.thc;
    _cbd_label.text = strain.cbd;
    _grower_label.text = strain.grower;
    _flavor_label.text = strain.flavor;
    _aroma_label.text = strain.aroma;
    //_high_type_label.text = strain.high_type;
}

- (void) loadSpeciesTypeControl {
    if ([strain.species isEqual:@"stevia"]){
        _species_type_control.selectedSegmentIndex = 0;
    }
    else{
        _species_type_control.selectedSegmentIndex = 1;
    }
}

- (IBAction)speciesTypeControl:(UISegmentedControl *)sender {
    if (_species_type_control.selectedSegmentIndex == 0){
        strain.species = @"stevia";
    }
    else{
        strain.species = @"indica";
    }
}

- (IBAction)tappedImageView:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped.
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
    _image_view.contentMode  = UIViewContentModeScaleAspectFit;
    [_image_view setImage:image];
    _imageSelected = true;
    [self dismissViewControllerAnimated:YES completion:NULL];
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

- (void) updateStrainProfile {
    [self updateFirebaseDatabase];
    [self updateClassObjectValues];
    if(_imageSelected){
    }
    [self dismissViewControllerAnimated:YES completion:^{}];

}

- (void) updateFirebaseDatabase{
    FIRDatabaseReference *strainRef= [firebaseRef.strainsRef child:strain.strain_key];
    [[strainRef child:@"strain_name"]setValue:_strain_name_label.text];
    [[strainRef child:@"image_name"]setValue:strain.strain_key];
    [[strainRef child:@"THC"]setValue:_thc_label.text];
    [[strainRef child:@"CBD"]setValue:_cbd_label.text];
    [[strainRef child:@"grower"]setValue:_grower_label.text];
    [[strainRef child:@"flavor"]setValue:_flavor_label.text];
    [[strainRef child:@"aroma"]setValue:_aroma_label.text];
    [[strainRef child:@"high_type"]setValue:_high_type_label.text];
    [[strainRef child:@"species"]setValue:strain.species];
}

- (void) updateClassObjectValues {
    strain.strain_name = _strain_name_label.text;
    strain.thc = _thc_label.text;
    strain.cbd = _cbd_label.text;
    strain.grower = _grower_label.text;
    strain.flavor = _flavor_label.text;
    strain.aroma = _aroma_label.text;
    //strain.high_type = _high_type_label.text;
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
- (IBAction)tappedSubmitButton:(UIButton *)sender {
    [self updateStrainProfile];
}

- (IBAction)cancel_button_tapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
