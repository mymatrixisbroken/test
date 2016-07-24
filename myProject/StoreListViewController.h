//
//  SecondViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddVenueViewController.h"
@import Firebase;

@interface VenueListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *AddVenueButton;
@property(strong, nonatomic) FIRDatabaseReference *ref;
@property(copy, nonatomic) NSString *key;


@end

