//
//  userBookmarkTableViewCell.h
//  myProject
//
//  Created by Guy on 10/23/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import HCSStarRatingView;

@interface userBookmarkTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bookmarkImageView;
@property (strong, nonatomic) IBOutlet UILabel *bookmarkNameLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *bookmarkRatingView;
@property (strong, nonatomic) IBOutlet UILabel *bookmarkReviewCountLabel;

@end
