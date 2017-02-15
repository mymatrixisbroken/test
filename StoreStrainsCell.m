//
//  StoreReviewCell.m
//  myProject
//
//  Created by Guy on 10/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StoreStrainsCell.h"

@implementation StoreStrainsCell

-(void) uploadCellWithPhoto{
    //    self.userImageView.image = [UIImage imageWithData:tempReview.objectData];
    //    self.usernameLabel.text = tempReview.username;
    //    self.reviewStarRating.value = [tempReview.rating integerValue];;
    //    self.reviewStarRating.tintColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
    //    self.reviewStarRating.backgroundColor = [UIColor clearColor];
    //    self.reviewMessageLabel.text = tempReview.message;
    
    //    self.usernameLabel.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0];
    //    self.usernameLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
    
    //    _label.textColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
    //    _label.font = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
    
    //    self.reviewMessageLabel.textColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
    //    self.reviewMessageLabel.font = [UIFont fontWithName:@"NEXA LIGHT" size:14.0];
    //
    //
    //    self.reviewLikesLabel.text = @"4";
    //    self.reviewLikesLabel.textColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
    //    self.reviewLikesLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:7.0];
    
    self.photoLikesLabel.text = @"4";
    self.photoLikesLabel.textColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
    self.photoLikesLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:7.0];
    
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
