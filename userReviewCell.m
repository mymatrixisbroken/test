//
//  userReviewCell.m
//  myProject
//
//  Created by Guy on 10/18/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "userReviewCell.h"

@implementation userReviewCell

-(void) uploadCellWithReview:(reviewClass *)tempReview{
    self.objectImageView.image = [UIImage imageWithData:tempReview.data];
    self.objectNameLabel.text = tempReview.objectName;
    self.reviewRatingView.value = [tempReview.rating integerValue];;
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
