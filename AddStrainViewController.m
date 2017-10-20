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
//    [self loadSliders];
//    [_strainNameField becomeFirstResponder];
//    _imageSelected = false;
    
    _confirmButton.enabled = NO;
    
    UIFont *font = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [_familyType setTitleTextAttributes:attributes
                               forState:UIControlStateNormal];
    
    [_familyType addTarget:self
                       action:@selector(tappedSegment:)
             forControlEvents:UIControlEventValueChanged];

    [_confirmButton addTarget:self
                       action:@selector(tappedConfirmButton:)
             forControlEvents:UIControlEventTouchUpInside];

    _cbdField.tag = 3;
    _thcField.tag = 3;
    _cbnField.tag = 3;
    
    _strainNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Strain Name" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    _cbdField.attributedText = [[NSAttributedString alloc] initWithString:@"--%" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0]}];
    _thcField.attributedText = [[NSAttributedString alloc] initWithString:@"--%" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0]}];
    _cbnField.attributedText = [[NSAttributedString alloc] initWithString:@"--%" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0]}];
    
    [_strainNameField addTarget:self
                   action:@selector(strainNameDidChange:)
         forControlEvents:UIControlEventEditingDidBegin];
    
    [_cbdField addTarget:self
                 action:@selector(attributeDidChange:)
       forControlEvents:UIControlEventEditingDidBegin];
    
    [_thcField addTarget:self
                      action:@selector(attributeDidChange:)
            forControlEvents:UIControlEventEditingDidBegin];
    
    [_cbnField addTarget:self
                     action:@selector(attributeDidChange:)
           forControlEvents:UIControlEventEditingDidBegin];
    
//********************************************************************************
    
    [_strainNameField addTarget:self
                   action:@selector(strainNameDidEndEditing:)
         forControlEvents:UIControlEventEditingDidEnd];
    
    [_cbdField addTarget:self
                 action:@selector(cbdDidEndEditing:)
       forControlEvents:UIControlEventEditingDidEnd];
    
    [_thcField addTarget:self
                      action:@selector(thcDidEndEditing:)
            forControlEvents:UIControlEventEditingDidEnd];
    
    [_cbnField addTarget:self
                     action:@selector(cbnDidEndEditing:)
           forControlEvents:UIControlEventEditingDidEnd];
}

-(void) strainNameDidChange:(UITextField *) textField{
    _strainNameField.font = [UIFont fontWithName:@"CERVO-THIN" size:33.0];
    _strainNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"e.g. Laughing Buddha" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

-(void) attributeDidChange:(UITextField *) textField{
    if ([textField.text isEqualToString:@"--%"]) {
        textField.font = [UIFont fontWithName:@"NEXA LIGHT" size:15.0];
        textField.attributedText = [[NSAttributedString alloc] initWithString:@"%" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0]}];
        
        UITextPosition *beginning = [textField beginningOfDocument];
        [textField setSelectedTextRange:[textField textRangeFromPosition:beginning
                                                              toPosition:beginning]];
    }
    else{
        NSInteger i = -1;
        UITextPosition *end =  [textField endOfDocument];
        UITextPosition *newPosition = [textField positionFromPosition:end offset:i];
        [textField setSelectedTextRange:[textField textRangeFromPosition:newPosition
                                                              toPosition:newPosition]];
    }
}

-(void) strainNameDidEndEditing:(UITextField *) textField{
    _strainNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Strain Name" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

-(void) cbdDidEndEditing:(UITextField *) textField{
    if ([textField.text isEqualToString:@"%"]) {
        textField.attributedText = [[NSAttributedString alloc] initWithString:@"--%" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0]}];
    }
}

-(void) thcDidEndEditing:(UITextField *) textField{
    if ([textField.text isEqualToString:@"%"]) {
        textField.attributedText = [[NSAttributedString alloc] initWithString:@"--%" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0]}];
    }
}

-(void) cbnDidEndEditing:(UITextField *) textField{
    if ([textField.text isEqualToString:@"%"]) {
        textField.attributedText = [[NSAttributedString alloc] initWithString:@"--%" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0]}];
    }
}

-(void) tappedSegment:(UISegmentedControl *) segmentControl{
    [self checkAllTextFieldLength];
}

-(void) checkAllTextFieldLength{
    NSMutableArray* emptyTextFieldArray = [[NSMutableArray alloc] init];
    
    for(UIView *view in _contentView.subviews){
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            if (textField.text.length == 0) {
                if (textField.tag != 3) {
                    [emptyTextFieldArray addObject:textField];
                }
            }
        }
    }
    if (emptyTextFieldArray.count == 0 && _familyType.selectedSegmentIndex >= 0) {
        _confirmButton.enabled = YES;
    }
    else
        _confirmButton.enabled = NO;
}

- (IBAction)tappedConfirmButton:(id)sender {
    NSString *lowerString = [_strainNameField.text lowercaseString];
    NSString *family;
    
    if (_familyType.selectedSegmentIndex == 0) {
        family = @"Indica";
    } else if(_familyType.selectedSegmentIndex == 1) {
        family = @"Sativa";
    } else if(_familyType.selectedSegmentIndex == 2) {
        family = @"Hybrid";
    }

    
    
    NSString *strainKey = [[firebaseRef.ref child:@"toBeReviewedStrainKeys"]  childByAutoId].key;
    [[[[firebaseRef.ref  child:@"toBeReviewedStrainNames"]  child:strainKey] child:@"lowerName"] setValue:lowerString];
    [[[[firebaseRef.ref  child:@"toBeReviewedStrainNames"]  child:strainKey] child:@"name"] setValue:_strainNameField.text];
    [[[[firebaseRef.ref  child:@"toBeReviewedStrainFamily"]  child:strainKey] child:@"family"] setValue:family];
    [[[[firebaseRef.ref  child:@"toBeReviewedStrainAddedByUser"]  child:strainKey] child:user.userKey] setValue:@"true"];
    [[[[firebaseRef.ref  child:@"toBeReviewedCBD"]  child:strainKey] child:@"cbd"] setValue:_cbdField.text];
    [[[[firebaseRef.ref  child:@"toBeReviewedTHC"]  child:strainKey] child:@"thc"] setValue:_thcField.text];
    [[[[firebaseRef.ref  child:@"toBeReviewedCBN"]  child:strainKey] child:@"cbn"] setValue:_cbnField.text];
    [[[[firebaseRef.ref  child:@"toBeReviewedStrainAddedByUser"]  child:strainKey] child:user.userKey] setValue:@"true"];

    
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Store submitted"
                                 message:@"Thank you for helping the Cheeba community grow. Your store will be reviewed by our moderators for duplicate or make available in search."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                               }];
    
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


//- (IBAction)tappedSubmitButton:(UIButton *)sender {
//    if(_imageSelected){
//        NSDictionary *dict2 = [self highType];
//        NSDictionary *dict3 = [self strainStats];
//        NSDictionary *dict4 = [self consumptionForm];
//
//        strain.strainKey = [firebaseRef.strainsRef childByAutoId].key;
//
//        [[[firebaseRef.strainsRef child:strain.strainKey] child:@"highType" ]setValue:dict2];
//        [[[firebaseRef.strainsRef child:strain.strainKey] child:@"stats" ]setValue:dict3];
//        [[[firebaseRef.strainsRef child:strain.strainKey] child:@"consumptionForm" ]setValue:dict4];
//        strain.ratingCount = 0;
//
//        [self updateClassValues];
//        [self updateFirDatabase];
//
//        CGSize size = CGSizeMake(500, 500);
//        UIImage *sizedImage = [[self class] imageWithImage:self.strainImageView.image scaledToSize:size];
//        //NSString *encodedString = [UIImagePNGRepresentation(self.strainImageView.image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        NSData *encodedString = UIImagePNGRepresentation(self.strainImageView.image);
//        NSLog(@"image encoded= %@", encodedString);
//
//        NSURL *theURL = [NSURL URLWithString:@"https://api.imgur.com/3/image"];
//        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
//
//        //Specify method of request(Get or Post)
//        [theRequest setHTTPMethod:@"POST"];
//
//        //Pass some default parameter(like content-type etc.)
//        [theRequest setValue:@"Client-ID bceb6364428afba" forHTTPHeaderField:@"Authorization"];
//
//        //[theRequest setValue:encodedString forHTTPHeaderField:@"image"];
//        [theRequest setHTTPBody:encodedString];
//        NSURLResponse *theResponse = NULL;
//        NSError *theError = NULL;
//        NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
//
//        NSDictionary *dataDictionaryResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:0 error:&theError];
//        NSLog(@"url to send request= %@",theURL);
//        NSLog(@"%@",dataDictionaryResponse);
//
//        NSDictionary *output = [dataDictionaryResponse valueForKey:@"data"];
//        NSString *imageURL = [output valueForKey:@"link"];
//        NSLog(@"url is %@", imageURL);
//
////        [strain.imageNames removeAllObjects];
////        [strain.imageNames addObject:imageURL];
//        [[[[firebaseRef.strainsRef child:strain.strainKey] child:@"images"] child:@"1" ] setValue:imageURL];
//
//
//        [self performSegueWithIdentifier:@"SubmitStrainSegue" sender:self];
//    }
//    else if (!_imageSelected){
//        [user presentImageNotSelectedAlert:self];
//    }
//
//}
//
//- (void) loadSliders{
//    NSArray *array = [NSArray arrayWithObjects:_happinessSlider, _upliftingSlider, _euphoricSlider,_energeticSlider,_relaxedSlider,nil];
//
//    for (int i = 0; i < 5; i++) {
//        ASValueTrackingSlider *str = [array objectAtIndex:i];
//        str.maximumValue = 100.0;
//        str.popUpViewCornerRadius = 12.0;
//        [str setMaxFractionDigitsDisplayed:0];
//        str.popUpViewColor = [UIColor colorWithRed:19.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1];
//        str.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
//        str.textColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1];
//
//    }
//}
//
//- (IBAction)speciesTypeController:(UISegmentedControl *)sender {
//    if (_speciesType.selectedSegmentIndex == 0){
//        strain.species = @"stevia";
//    }
//    else{
//        strain.species = @"indica";
//    }
//    NSLog(@"Add Strain Species %@",strain.species);
//}
//
//- (IBAction)tappedImageView:(id)sender {
//    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        // Cancel button tappped.
//    }]];
//
//    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        picker2 = [[UIImagePickerController alloc] init];
//        self->picker2.delegate = self;
//        [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        [self presentViewController:picker2 animated:YES completion:NULL];
//        // Distructive button tapped.[self dismissViewControllerAnimated:YES completion:^{}];
//    }]];
//
//    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        picker = [[UIImagePickerController alloc] init];
//        self->picker.delegate = self;
//        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
//        [self presentViewController:picker animated:YES completion:NULL];
//        // OK button tapped. [self dismissViewControllerAnimated:YES completion:^{}];
//    }]];
//
//    // Present action sheet.
//    [self presentViewController:actionSheet animated:YES completion:nil];
//}
//
//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    _strainImageView.contentMode  = UIViewContentModeScaleAspectFit;
//    [_strainImageView setImage:image];
//    _imageSelected = true;
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}
//
//
//- (void) updateClassValues {
//    strain.strainName = _strainNameField.text;
//    strain.thc = _thcField.text;
//    strain.cbd = _cbdField.text;
//    strain.grower = _growerField.text;
//    strain.flavor = _flavorField.text;
//    strain.aroma = _aromaField.text;
//    strain.happiness = (int)_happinessSlider.value;
//    strain.uplifting = (int)_upliftingSlider.value;
//    strain.euphoric = (int)_euphoricSlider.value;
//    strain.energetic =(int)_energeticSlider.value;
//    strain.relaxed = (int)_relaxedSlider.value;
//
//
//}
//
//- (void) updateFirDatabase {
//    NSString *happiness = [NSString stringWithFormat:@"%lu", strain.happiness];
//    NSString *uplifting = [NSString stringWithFormat:@"%lu", strain.uplifting];
//    NSString *euphoric = [NSString stringWithFormat:@"%lu", strain.euphoric];
//    NSString *energetic = [NSString stringWithFormat:@"%lu", strain.energetic];
//    NSString *relaxed = [NSString stringWithFormat:@"%lu", strain.relaxed];
//
//    [[[firebaseRef.strainsRef child:strain.strainKey] child:@"strainName"] setValue:strain.strainName];
//    [[[firebaseRef.strainsRef child:strain.strainKey] child:@"thc"] setValue:strain.thc];
//    [[[firebaseRef.strainsRef child:strain.strainKey] child:@"cbd"] setValue:strain.cbd];
//    [[[firebaseRef.strainsRef child:strain.strainKey] child:@"species"] setValue:strain.species];
//    [[[firebaseRef.strainsRef child:strain.strainKey] child:@"grower"] setValue:strain.grower];
//    [[[firebaseRef.strainsRef child:strain.strainKey] child:@"flavor"] setValue:strain.flavor];
//    [[[firebaseRef.strainsRef child:strain.strainKey] child:@"aroma"] setValue:strain.aroma];
//    [[[[firebaseRef.strainsRef child:strain.strainKey] child:@"highType"] child:@"happiness"] setValue:happiness];
//    [[[[firebaseRef.strainsRef child:strain.strainKey] child:@"highType"] child:@"uplifting"] setValue:uplifting];
//    [[[[firebaseRef.strainsRef child:strain.strainKey] child:@"highType"] child:@"euphoric"] setValue:euphoric];
//    [[[[firebaseRef.strainsRef child:strain.strainKey] child:@"highType"] child:@"energetic"] setValue:energetic];
//    [[[[firebaseRef.strainsRef child:strain.strainKey] child:@"highType"] child:@"relaxed"] setValue:relaxed];
//}
//
//- (NSDictionary *)createEmptyStrain{
//    NSDictionary *dictionaryStrainCreate= @{@"strainName": @"",
//                                            @"thc":@"",
//                                            @"cbd":@"",
//                                            @"species":@"",
//                                            @"grower":@"",
//                                            @"flavor":@"",
//                                            @"aroma":@"",
//                                            @"ratings":@"0",
//                                            @"ratingScore":@"",
//                                            @"stats":@"",
//                                            @"consumptionForm":@"",
//                                            @"availableAt":@""};
//    return dictionaryStrainCreate;
//}
//
//- (NSDictionary *)highType{
//    NSDictionary *highType= @{@"happiness":@"",
//                              @"uplifting":@"",
//                              @"euphoric":@"",
//                              @"energetic":@"",
//                                 @"relaxed":@""};
//    return highType;
//}
//
//
//- (NSDictionary *)strainStats{
//    NSDictionary *strainStats= @{@"totalCount":@"",
//                                 @"monthlyCount":@"",
//                                 @"totalUserCount":@""};
//    return strainStats;
//}
//
//- (NSDictionary *)consumptionForm{
//    NSDictionary *consumptionForm= @{@"bud":@"",
//                                     @"concentrate":@"",
//                                     @"topical":@"",
//                                     @"edible":@""};
//    return consumptionForm;
//}
//
//- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
//    [self dismissViewControllerAnimated:YES completion:^{}];
//}
//
//+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
//    //UIGraphicsBeginImageContext(newSize);
//    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
//    // Pass 1.0 to force exact pixel size.
//    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
