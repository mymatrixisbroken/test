//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "AddStrainViewController.h"

@interface AddStrainViewController ()

@end

@implementation AddStrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_strainNameField becomeFirstResponder];
    _imageSelected = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)speciesTypeController:(UISegmentedControl *)sender {
    if (_speciesType.selectedSegmentIndex == 0){
        strain.species = @"stevia";}
    else{
        strain.species = @"indica";}
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
    _strainImageView.contentMode  = UIViewContentModeScaleAspectFit;
    [_strainImageView setImage:image];
    _imageSelected = true;
    [self loadImagesToClassObject];
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

- (void) updateClassValues {
    strain.strain_name = _strainNameField.text;
    strain.thc = _thcField.text;
    strain.cbd = _cbdField.text;
    strain.grower = _growerField.text;
    strain.flavor = _flavorField.text;
    strain.aroma = _aromaField.text;
    strain.high_type = _highTypeField.text;
}

- (void) updateFirDatabase {
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"strain_name"] setValue:strain.strain_name];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"THC"] setValue:strain.thc];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"CBD"] setValue:strain.cbd];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"species"] setValue:strain.species];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"grower"] setValue:strain.grower];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"flavor"] setValue:strain.flavor];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"aroma"] setValue:strain.aroma];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"high_type"] setValue:strain.high_type];
}

- (void) loadImagesToClassObject{
    strain.medium_image = [[self class] imageWithImage:image scaledToWidth:1500];
    strain.small_image = [[self class] imageWithImage:image scaledToWidth:100];
}

- (FIRStorageUploadTask *) uploadImage:(NSData *)data ToRef:(FIRStorageReference *)ref {
    FIRStorageUploadTask *uploadTask = [ref putData:data metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
        if (error != nil) {
            // Uh-oh, an error occurred!
        } else {
            strain.medium_image = [UIImage imageWithData:data]; //*downloadTask observeStatus:FIRStorageTaskStatusSuccess
        }
    }];
    return uploadTask;
}


- (NSDictionary *)createEmptyStrain{
    NSDictionary *dictionaryStrainCreate= @{@"strain_name": @"",
                                            @"THC":@"",
                                            @"CBD":@"",
                                            @"species":@"",
                                            @"grower":@"",
                                            @"flavor":@"",
                                            @"aroma":@"",
                                            @"high_type":@"",
                                            @"rating_count":@"0",
                                            @"rating_score":@"",
                                            @"stats":@"",
                                            @"consumption_form":@"",
                                            @"image_name":@"",
                                            @"available_at_venue":@""};
    return dictionaryStrainCreate;
}

- (NSDictionary *)strainStats{
    NSDictionary *strainStats= @{@"total_count":@"",
                                 @"monthly_count":@"",
                                 @"total_user_count":@""};
    return strainStats;
}

- (NSDictionary *)consumptionForm{
    NSDictionary *consumptionForm= @{@"bud":@"",
                                     @"concentrate":@"",
                                     @"topical":@"",
                                     @"edible":@""};
    return consumptionForm;
}

- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)tappedSubmitButton:(UIButton *)sender {
    if(_imageSelected){
        FIRStorageReference *medium_image_ref = [firebaseRef.strains_medium_images_ref child:strain.strain_key] ;
        FIRStorageReference *small_image_ref = [firebaseRef.strains_small_images_ref child:strain.strain_key];
        
        NSData *medium_data = UIImagePNGRepresentation(strain.medium_image); //Converts UIImage to Data for Storage upload
        NSData *small_data = UIImagePNGRepresentation(strain.small_image); //Converts UIImage to Data for Storage upload
        
        FIRStorageUploadTask *uploadTask = [self uploadImage:medium_data ToRef:medium_image_ref];
        [self uploadImage:small_data ToRef:small_image_ref];
        
        
        
        NSDictionary *dict1 = [self createEmptyStrain];
        NSDictionary *dict2 = [self strainStats];
        NSDictionary *dict3 = [self consumptionForm];
        strain.strain_key = [firebaseRef.strainsRef childByAutoId].key;
        
        [strain createEmptyStrainObject];
        [[[firebaseRef.strainsRef child:strain.strain_key] child:@"strain_key" ]setValue:strain.strain_key];
        [[firebaseRef.strainsRef child:strain.strain_key] setValue:dict1];
        [[[firebaseRef.strainsRef child:strain.strain_key] child:@"stats" ]setValue:dict2];
        [[[firebaseRef.strainsRef child:strain.strain_key] child:@"consumption_form" ]setValue:dict3];
        strain.rating_count = 0;
        
        
        [self updateClassValues];
        [self updateFirDatabase];
        
        [uploadTask observeStatus:FIRStorageTaskStatusSuccess handler:^(FIRStorageTaskSnapshot *snapshot) {
            [self performSegueWithIdentifier:@"SubmitStrainSegue" sender:self];
        }];}
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
@end
