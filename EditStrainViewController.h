//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "strainClass.h"
#import "userClass.h"
#import "FirebaseReferenceClass.h"
@import JVFloatLabeledTextField;
@import Firebase;

@interface EditStrainViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *species_type_control;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *strain_name_label;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *thc_label;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *cbd_label;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *grower_label;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *flavor_label;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *aroma_label;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *high_type_label;
@property (strong, nonatomic) IBOutlet UIImageView *image_view;
@property BOOL imageSelected;
@end

