//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import JVFloatLabeledTextField;
@import Firebase;

@interface AddStrainController : UIViewController
@property(copy, nonatomic) NSString *key;
@property (weak, nonatomic) IBOutlet UITextField *thcField;
@property (weak, nonatomic) IBOutlet UITextField *StrainNameField;
@property (weak, nonatomic) IBOutlet UITextField *SpeciesField;
@property (weak, nonatomic) IBOutlet UITextField *GrowerField;
@property (weak, nonatomic) IBOutlet UITextField *DescriptionField;
@property (weak, nonatomic) IBOutlet UIButton *SubmitStrainButton;
@property(strong, nonatomic) FIRDatabaseReference *ref;
@property (weak, nonatomic) IBOutlet UIButton *BackButton;


@end

