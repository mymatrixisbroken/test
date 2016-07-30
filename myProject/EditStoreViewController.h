//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storeClass.h"
#import "FirebaseReferenceClass.h"
@import JVFloatLabeledTextField;
@import Firebase;
@import GooglePlaces;

@interface EditStoreViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
}

@property (strong, nonatomic) IBOutlet UIButton *back_button;
@property (strong, nonatomic) IBOutlet UIButton *submit_button;
@property (strong, nonatomic) IBOutlet UIImageView *image_view;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *store_name_label;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *address_label;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *city_label;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *state_label;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *phone_number_label;
@property BOOL imageSelected;

@end

