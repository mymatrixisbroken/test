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
    [self loadSliders];
    
    [_strainNameField becomeFirstResponder];
    _imageSelected = false;
}

- (IBAction)tappedSubmitButton:(UIButton *)sender {
    if(_imageSelected){
        NSDictionary *dict2 = [self highType];
        NSDictionary *dict3 = [self strainStats];
        NSDictionary *dict4 = [self consumptionForm];
        
        strain.strain_key = [firebaseRef.strainsRef childByAutoId].key;
        
        [[[firebaseRef.strainsRef child:strain.strain_key] child:@"strain_key" ]setValue:strain.strain_key];
        [[[firebaseRef.strainsRef child:strain.strain_key] child:@"high_type" ]setValue:dict2];
        [[[firebaseRef.strainsRef child:strain.strain_key] child:@"stats" ]setValue:dict3];
        [[[firebaseRef.strainsRef child:strain.strain_key] child:@"consumption_form" ]setValue:dict4];
        strain.rating_count = 0;
        
        [self updateClassValues];
        [self updateFirDatabase];
        
        CGSize size = CGSizeMake(500, 500);
        UIImage *sizedImage = [[self class] imageWithImage:self.strainImageView.image scaledToSize:size];
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
        
        [strain.imageNames removeAllObjects];
        [strain.imageNames addObject:imageURL];
        [[[[firebaseRef.strainsRef child:strain.strain_key] child:@"images"] child:@"1" ] setValue:imageURL];
        

        [self performSegueWithIdentifier:@"SubmitStrainSegue" sender:self];
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

- (void) loadSliders{
    NSArray *array = [NSArray arrayWithObjects:_happinessSlider, _upliftingSlider, _euphoricSlider,_energeticSlider,_relaxedSlider,nil];

    for (int i = 0; i < 5; i++) {
        ASValueTrackingSlider *str = [array objectAtIndex:i];
        str.maximumValue = 100.0;
        str.popUpViewCornerRadius = 12.0;
        [str setMaxFractionDigitsDisplayed:0];
        str.popUpViewColor = [UIColor colorWithRed:19.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1];
        str.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
        str.textColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1];

    }
}

- (IBAction)speciesTypeController:(UISegmentedControl *)sender {
    if (_speciesType.selectedSegmentIndex == 0){
        strain.species = @"stevia";
    }
    else{
        strain.species = @"indica";
    }
    NSLog(@"Add Strain Species %@",strain.species);
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
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void) updateClassValues {
    strain.strain_name = _strainNameField.text;
    strain.thc = _thcField.text;
    strain.cbd = _cbdField.text;
    strain.grower = _growerField.text;
    strain.flavor = _flavorField.text;
    strain.aroma = _aromaField.text;
    strain.happiness = (int)_happinessSlider.value;
    strain.uplifting = (int)_upliftingSlider.value;
    strain.euphoric = (int)_euphoricSlider.value;
    strain.energetic =(int)_energeticSlider.value;
    strain.relaxed = (int)_relaxedSlider.value;
    

}

- (void) updateFirDatabase {
    NSString *happiness = [NSString stringWithFormat:@"%d", strain.happiness];
    NSString *uplifting = [NSString stringWithFormat:@"%d", strain.uplifting];
    NSString *euphoric = [NSString stringWithFormat:@"%d", strain.euphoric];
    NSString *energetic = [NSString stringWithFormat:@"%d", strain.energetic];
    NSString *relaxed = [NSString stringWithFormat:@"%d", strain.relaxed];

    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"strain_name"] setValue:strain.strain_name];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"THC"] setValue:strain.thc];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"CBD"] setValue:strain.cbd];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"species"] setValue:strain.species];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"grower"] setValue:strain.grower];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"flavor"] setValue:strain.flavor];
    [[[firebaseRef.strainsRef child:strain.strain_key] child:@"aroma"] setValue:strain.aroma];
    [[[[firebaseRef.strainsRef child:strain.strain_key] child:@"high_type"] child:@"happiness"] setValue:happiness];
    [[[[firebaseRef.strainsRef child:strain.strain_key] child:@"high_type"] child:@"uplifting"] setValue:uplifting];
    [[[[firebaseRef.strainsRef child:strain.strain_key] child:@"high_type"] child:@"euphoric"] setValue:euphoric];
    [[[[firebaseRef.strainsRef child:strain.strain_key] child:@"high_type"] child:@"energetic"] setValue:energetic];
    [[[[firebaseRef.strainsRef child:strain.strain_key] child:@"high_type"] child:@"relaxed"] setValue:relaxed];
}

- (NSDictionary *)createEmptyStrain{
    NSDictionary *dictionaryStrainCreate= @{@"strain_name": @"",
                                            @"THC":@"",
                                            @"CBD":@"",
                                            @"species":@"",
                                            @"grower":@"",
                                            @"flavor":@"",
                                            @"aroma":@"",
                                            @"image_name":@"",
                                            @"rating_count":@"0",
                                            @"rating_score":@"",
                                            @"stats":@"",
                                            @"consumption_form":@"",
                                            @"image_name":@"",
                                            @"available_at":@""};
    return dictionaryStrainCreate;
}

- (NSDictionary *)highType{
    NSDictionary *highType= @{@"happiness":@"",
                              @"uplifting":@"",
                              @"euphoric":@"",
                              @"energetic":@"",
                                 @"relaxed":@""};
    return highType;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
