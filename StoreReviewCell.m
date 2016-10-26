//
//  StoreReviewCell.m
//  myProject
//
//  Created by Guy on 10/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StoreReviewCell.h"

@implementation StoreReviewCell

-(void) uploadCellWithReview:(reviewClass *)tempReview{
    self.userImageView.image = [UIImage imageWithData:tempReview.objectData];
    self.usernameLabel.text = tempReview.username;
    self.reviewStarRating.value = [tempReview.rating integerValue];;
    self.reviewMessageLabel.text = tempReview.message;
    
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
