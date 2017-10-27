//
//  userPhotosTableViewCell.h
//  myProject
//
//  Created by Guy on 10/25/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userPhotosTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *imageTitle;
@property (strong, nonatomic) IBOutlet UILabel *imageLikeCountLabel;

@end
