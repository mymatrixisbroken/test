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
@import Cosmos;
@import Firebase;

@interface StoreProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *back_button;
@property (strong, nonatomic) IBOutlet UIButton *edit_button;
@property (strong, nonatomic) IBOutlet UIImageView *store_image_view;
@property (strong, nonatomic) IBOutlet CosmosView *store_rating_score;
@property (strong, nonatomic) IBOutlet UILabel *store_rating_count;
@property (strong, nonatomic) IBOutlet UILabel *store_name_label;
@property (strong, nonatomic) IBOutlet UILabel *store_address_label;
@property (strong, nonatomic) IBOutlet UILabel *store_city_label;
@property (strong, nonatomic) IBOutlet UILabel *store_state_label;
@property (strong, nonatomic) IBOutlet UILabel *store_url_label;
@property (strong, nonatomic) IBOutlet UILabel *store_phone_number_label;


@end

