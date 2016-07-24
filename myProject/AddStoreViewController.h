//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface AddVenueViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *AddVenueBackButton;
@property (weak, nonatomic) IBOutlet UITextField *VenueNameField;
@property (weak, nonatomic) IBOutlet UITextField *AddressField;
@property (weak, nonatomic) IBOutlet UITextField *CityField;
@property (weak, nonatomic) IBOutlet UITextField *StateField;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumberField;
@property(copy, nonatomic) NSString *key;
@property(strong, nonatomic) FIRDatabaseReference *ref;



@end

