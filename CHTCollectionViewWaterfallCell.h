//
//  UICollectionViewWaterfallCell.h
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
@import HCSStarRatingView;


@interface CHTCollectionViewWaterfallCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *steviaImageView;
@property (nonatomic, strong) UIImageView *indicaImageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *reviewCountLabel;
@property (nonatomic, strong) UILabel *distanceToMeLabel;
@property (nonatomic, strong) HCSStarRatingView *starRatingView;

@end
