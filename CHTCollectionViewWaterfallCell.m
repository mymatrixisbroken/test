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
      _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height*0.7)];
//    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
  }
  return _imageView;
}

- (UIImageView *)steviaImageView {
    if (!_steviaImageView) {
        _steviaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.825, self.bounds.size.height*0.55, 20, 20)];
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
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20, (self.contentView.bounds.size.height*0.69), self.bounds.size.width, 40)];
        _label.tag = 200;
        _label.textColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
        _label.font = [UIFont fontWithName:@"CERVO-THIN" size:23.0];
        _label.userInteractionEnabled=NO;
    }
    return _label;
}

- (UILabel *)locationLabel{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (self.contentView.bounds.size.height*0.775), self.bounds.size.width, 40)];
        _locationLabel.textColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
        _locationLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:12.0];
        _locationLabel.userInteractionEnabled=NO;
    }
    return _locationLabel;
}

- (UILabel *)distanceToMeLabel{
    if (!_distanceToMeLabel) {
        _distanceToMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.88, self.bounds.size.height*0.475, 50, 50)];
        _distanceToMeLabel.tag = 201;
        _distanceToMeLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0];
        _distanceToMeLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:12.0];
        _distanceToMeLabel.userInteractionEnabled=NO;
    }
    return _distanceToMeLabel;
}

- (UILabel *)reviewCountLabel{
    if (!_reviewCountLabel) {
        _reviewCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.8, (self.contentView.bounds.size.height*0.71), 80, 50)];
        _reviewCountLabel.textColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
        _reviewCountLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:12.0];
        _reviewCountLabel.userInteractionEnabled=NO;
    }
    return _reviewCountLabel;
}

- (HCSStarRatingView *)starRatingView{
    if (!_starRatingView) {
        _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.575, (self.contentView.bounds.size.height*0.7), 80, 50)];
        _starRatingView.backgroundColor = [UIColor clearColor];
        _starRatingView.tintColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
        _starRatingView.spacing = 0.0;
        _starRatingView.value = 0.0;
        _starRatingView.allowsHalfStars = YES;
        _starRatingView.filledStarImage = [UIImage imageNamed:@"starGreenIcon"];
        _starRatingView.emptyStarImage = [UIImage imageNamed:@"starGrayIcon"];
        _starRatingView.userInteractionEnabled=NO;
    }
    return _starRatingView;
}

- (UILabel *)cbdLabel{
    if (!_cbdLabel) {
        _cbdLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.7, self.bounds.size.height*0.4, 50, 50)];
        _cbdLabel.tag = 201;
        _cbdLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0];
        _cbdLabel.text = @"CBD:";
        _cbdLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:10.0];
        _cbdLabel.textColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
        _cbdLabel.userInteractionEnabled=NO;
        _cbdLabel.hidden = YES;
    }
    return _cbdLabel;
}

- (UILabel *)cbdPercentLabel{
    if (!_cbdPercentLabel) {
        _cbdPercentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.7, self.bounds.size.height*0.475, 50, 50)];
        _cbdPercentLabel.tag = 201;
        _cbdPercentLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0];
        _cbdPercentLabel.font = [UIFont fontWithName:@"NEXA LIGHT" size:14.0];
        _cbdPercentLabel.text = @"15%";
        _cbdPercentLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        _cbdPercentLabel.userInteractionEnabled=NO;
        _cbdPercentLabel.hidden = YES;
    }
    return _cbdPercentLabel;
}

- (UILabel *)thcLabel{
    if (!_thcLabel) {
        _thcLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.8, self.bounds.size.height*0.4, 50, 50)];
        _thcLabel.tag = 201;
        _thcLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:10.0];
        _thcLabel.textColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
        _thcLabel.userInteractionEnabled=NO;
        _thcLabel.text = @"THC:";
        _thcLabel.hidden = YES;
    }
    return _thcLabel;
}

- (UILabel *)thcPercentLabel{
    if (!_thcPercentLabel) {
        _thcPercentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.8, self.bounds.size.height*0.475, 50, 50)];
        _thcPercentLabel.tag = 201;
        _thcPercentLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0];
        _thcPercentLabel.font = [UIFont fontWithName:@"NEXA LIGHT" size:14.0];
        _thcPercentLabel.text = @"16%";
        _thcPercentLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        _thcPercentLabel.userInteractionEnabled=NO;
        _thcPercentLabel.hidden = YES;
    }
    return _thcPercentLabel;
}


- (UILabel *)cbnLabel{
    if (!_cbnLabel) {
        _cbnLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.9, self.bounds.size.height*0.4, 50, 50)];
        _cbnLabel.tag = 201;
        _cbnLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:10.0];
        _cbnLabel.textColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
        _cbnLabel.userInteractionEnabled=NO;
        _cbnLabel.text = @"CBN:";
        _cbnLabel.hidden = YES;
    }
    return _cbnLabel;
}

- (UILabel *)cbnPercentLabel{
    if (!_cbnPercentLabel) {
        _cbnPercentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.9, self.bounds.size.height*0.475, 50, 50)];
        _cbnPercentLabel.tag = 201;
        _cbnPercentLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0];
        _cbnPercentLabel.font = [UIFont fontWithName:@"NEXA LIGHT" size:14.0];
        _cbnPercentLabel.text = @"17%";
        _cbnPercentLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        _cbnPercentLabel.userInteractionEnabled=NO;
        _cbnPercentLabel.hidden = YES;
    }
    return _cbnPercentLabel;
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
      [self.contentView addSubview:self.cbdLabel];
      [self.contentView addSubview:self.cbdPercentLabel];
      [self.contentView addSubview:self.thcLabel];
      [self.contentView addSubview:self.thcPercentLabel];
      [self.contentView addSubview:self.cbnLabel];
      [self.contentView addSubview:self.cbnPercentLabel];
  }
  return self;
}

@end
