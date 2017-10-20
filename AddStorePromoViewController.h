//
//  AddStorePromoUIViewController.h
//  myProject
//
//  Created by Guy on 9/19/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirebaseReferenceClass.h"
#import "storeClass.h"
@import Firebase;

@interface AddStorePromoViewController : UIViewController <UIPopoverPresentationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UITextView *promoTextField;

@end
