//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "AddStrainController.h"

@interface AddStrainController ()

@end

@implementation AddStrainController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", _key);
    [_StrainNameField becomeFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"CreateStrainBackSegue" sender:self];
}

- (IBAction)AddStrainButton:(UIButton *)sender {
    self.ref = [[FIRDatabase database] reference];
    NSString *strainName = _StrainNameField.text;
    NSString *thcName = _thcField.text;
    NSString *speciesName = _SpeciesField.text;
    NSString *growerName = _GrowerField.text;
    NSString *descriptionName = _DescriptionField.text;

    
    [[[[self.ref child:@"strain"] child:_key] child:@"strain_name"] setValue:strainName];
    [[[[self.ref child:@"strain"] child:_key] child:@"THC"] setValue:thcName];
    [[[[self.ref child:@"strain"] child:_key] child:@"species"] setValue:speciesName];
    [[[[self.ref child:@"strain"] child:_key] child:@"description"] setValue:descriptionName];
    [[[[self.ref child:@"strain"] child:_key] child:@"grower"] setValue:growerName];
    NSLog(@"Submit Button is tapped");
    [self performSegueWithIdentifier:@"SubmitStrainSegue" sender:self];
}

@end
