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
#import "userClass.h"
#import "FirebaseReferenceClass.h"
#import "objectsArrayClass.h"
@import Firebase;
@import GooglePlaces;
@import GoogleMaps;
@import JVFloatLabeledTextField;

@interface AddStoreViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
}

@property (strong, nonatomic) IBOutlet UITextField *storeName;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *cityStateZip;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *storeHours;
@property (strong, nonatomic) IBOutlet UIView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) IBOutlet UIView *contentVIew;
@property BOOL imageSelected;
@property double storeLat;
@property double storeLng;

@end

