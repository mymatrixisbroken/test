//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "AddVenueViewController.h"
@import Firebase;

@interface AddVenueViewController ()

@end

@implementation AddVenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)AddVenueBackButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"AddVenueBackButton" sender:self];

}
- (IBAction)SubmitVenueButton:(UIButton *)sender {
    self.ref = [[FIRDatabase database] reference];
    NSString *venueName = _VenueNameField.text;
    NSString *address = _AddressField.text;
    NSString *city = _CityField.text;
    NSString *state = _StateField.text;
    NSString *phoneNumber = _PhoneNumberField.text;
    

    
    [[[[self.ref child:@"venue"] child:_key] child:@"venue_name"] setValue:venueName];
    [[[[[self.ref child:@"venue"] child:_key] child:@"location"] child:@"address" ] setValue:address];
    [[[[[self.ref child:@"venue"] child:_key] child:@"location"] child:@"city" ] setValue:city];
    [[[[[self.ref child:@"venue"] child:_key] child:@"location"] child:@"state" ] setValue:state];
    [[[[self.ref child:@"venue"] child:_key] child:@"phone_number"] setValue:phoneNumber];
    NSLog(@"Submit Button is tapped");
    [self performSegueWithIdentifier:@"SubmitStrainSegue" sender:self];

}

@end
