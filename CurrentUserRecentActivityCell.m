//
//  CurrentUserReviewsCell.m
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "CurrentUserRecentActivityCell.h"

@implementation CurrentUserRecentActivityCell

-(void) uploadCellWithReview:(reviewClass *)tempReview{
    self.objectImageView.image = [UIImage imageWithData:tempReview.objectData];
    self.objectNameLabel.text = tempReview.objectName;
    self.reviewRating.value = [tempReview.rating integerValue];;
    self.reviewMessage.text = tempReview.message;
    
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
