//
//  UICollectionViewWaterfallCell.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallCell.h"

@implementation CHTCollectionViewWaterfallCell

#pragma mark - Accessors
- (UIImageView *)imageView {
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
  }
  return _imageView;
}

- (UIImageView *)steviaImageView {
    if (!_steviaImageView) {
        _steviaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-75, self.bounds.size.height-40, 20, 20)];
        _steviaImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _steviaImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _steviaImageView;
}

- (UIImageView *)indicaImageView {
    if (!_indicaImageView) {
        _indicaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 10, 10)];
        _indicaImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _indicaImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _indicaImageView;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 125, self.bounds.size.width, 40)];
        _label.tag = 200;
        /*important--------- */
        _label.textColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
        _label.font = [UIFont fontWithName:@"CERVO-THIN" size:14.0];
//        _label.textColor = [UIColor blackColor];
//        _label.backgroundColor=[UIColor clearColor];
//        _label.shadowColor=[UIColor blackColor];
//        _label.textColor=[UIColor whiteColor];
        _label.userInteractionEnabled=NO;
    }
    return _label;
}

- (UILabel *)locationLabel{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 134, self.bounds.size.width, 40)];
//        _locationLabel.tag = 200;
        /*important--------- */
        _locationLabel.textColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
        _locationLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:6.0];
        //        _label.textColor = [UIColor blackColor];
        //        _label.backgroundColor=[UIColor clearColor];
        //        _label.shadowColor=[UIColor blackColor];
        //        _label.textColor=[UIColor whiteColor];
        _locationLabel.userInteractionEnabled=NO;
    }
    return _locationLabel;
}

- (UILabel *)distanceToMeLabel{
    if (!_distanceToMeLabel) {
        _distanceToMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-50, self.bounds.size.height-55, 50, 50)];
        _distanceToMeLabel.tag = 201;
        /*_distanceToMeLabel--------- */
        _distanceToMeLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0];
        _distanceToMeLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:8.0];
        //        _distanceToMeLabel.backgroundColor=[UIColor clearColor];
        //        _distanceToMeLabel.shadowColor=[UIColor blackColor];
        //        _distanceToMeLabel.textColor=[UIColor whiteColor];
        _distanceToMeLabel.userInteractionEnabled=NO;
    }
    return _distanceToMeLabel;
}

- (UILabel *)reviewCountLabel{
    if (!_reviewCountLabel) {
        _reviewCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-65, self.bounds.size.height-10, 40, 25)];
//        _reviewCountLabel.tag = 201;
        /*_distanceToMeLabel--------- */
//        _reviewCountLabel.textColor = [UIColor whiteColor];
        _reviewCountLabel.textColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
        _reviewCountLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:8.0];
        //        _distanceToMeLabel.backgroundColor=[UIColor clearColor];
        //        _distanceToMeLabel.shadowColor=[UIColor blackColor];
        //        _distanceToMeLabel.textColor=[UIColor whiteColor];
        _reviewCountLabel.userInteractionEnabled=NO;
    }
    return _reviewCountLabel;
}

- (HCSStarRatingView *)starRatingView{
    if (!_starRatingView) {
        _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(self.bounds.size.width-110, self.bounds.size.height-11, 40, 25)];
        _starRatingView.backgroundColor = [UIColor clearColor];
        _starRatingView.tintColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
        _starRatingView.value = 3.0;
        //        _label.textColor = [UIColor blackColor];
        //        _label.backgroundColor=[UIColor clearColor];
        //        _label.shadowColor=[UIColor blackColor];
        //        _label.textColor=[UIColor whiteColor];
        _starRatingView.userInteractionEnabled=NO;
    }
    return _starRatingView;
}


- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
      [self.contentView addSubview:self.imageView];
      [self.contentView addSubview:self.steviaImageView];
      [self.contentView addSubview:self.indicaImageView];
      [self.contentView addSubview:self.label];
      [self.contentView addSubview:self.locationLabel];
      [self.contentView addSubview:self.distanceToMeLabel];
      [self.contentView addSubview:self.reviewCountLabel];
      [self.contentView addSubview:self.starRatingView];
  }
  return self;
}

@end
