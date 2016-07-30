//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import "storeClass.h"
#import "FirebaseReferenceClass.h"
@import Firebase;
@import GooglePlaces;
@import JVFloatLabeledTextField;

@interface AddStoreViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
}

@property (weak, nonatomic) IBOutlet UIButton *back_button;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *store_name_field;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *address_field;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *city_field;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *state_field;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phone_number_field;
@property (weak, nonatomic) IBOutlet UIButton *submit_store_button;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property BOOL imageSelected;

@end

