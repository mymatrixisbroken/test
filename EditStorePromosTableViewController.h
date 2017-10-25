//
//  EditStorePromosTableViewController.h
//  myProject
//
//  Created by Guy on 9/19/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddStorePromoViewController.h"
#import "EditStoresPromosCellTableViewCell.h"
#import "promoClass.h"
#import "FirebaseReferenceClass.h"
@import Firebase;

@interface EditStorePromosTableViewController : UITableViewController <UIPopoverPresentationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *addButton;

@end
