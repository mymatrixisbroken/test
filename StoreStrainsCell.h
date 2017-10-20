//
//  StoreReviewCell.h
//  myProject
//
//  Created by Guy on 10/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storeClass.h"
@import HCSStarRatingView;

@interface StoreStrainsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *strainImageView;
@property (strong, nonatomic) IBOutlet UILabel *strainNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainFamilyLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *strainRatingView;
@property (strong, nonatomic) IBOutlet UILabel *strainReviewCount;

@end
