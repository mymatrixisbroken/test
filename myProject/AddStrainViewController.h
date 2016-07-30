//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "strainClass.h"
#import "FirebaseReferenceClass.h"
@import JVFloatLabeledTextField;
@import Firebase;

@interface AddStrainViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
}
@property (weak, nonatomic) IBOutlet UIImageView *strainImageView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *speciesType;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *strainNameField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *thcField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *cbdField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *speciesField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *growerField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *flavorField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *aromaField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *highTypeField;
@property BOOL imageSelected;
@end

