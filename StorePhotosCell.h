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

@interface StorePhotosCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *photoLikesLabel;

-(void)uploadCellWithPhoto;

@end
