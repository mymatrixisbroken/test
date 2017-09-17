//
//  UserProfileTableViewCell.m
//  myProject
//
//  Created by Guy on 9/11/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "UserProfileReviewsCell.h"

@implementation UserProfileReviewsCell

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
