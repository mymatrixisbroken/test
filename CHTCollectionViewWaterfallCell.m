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
        _steviaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 10, 10)];
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
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.bounds.size.width, 40)];
        _label.tag = 200;
        /*important--------- */_label.textColor = [UIColor blackColor];
        _label.backgroundColor=[UIColor clearColor];
        _label.shadowColor=[UIColor blackColor];
        _label.textColor=[UIColor whiteColor];
        _label.userInteractionEnabled=NO;
    }
    return _label;
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
      [self.contentView addSubview:self.imageView];
      [self.contentView addSubview:self.steviaImageView];
      [self.contentView addSubview:self.indicaImageView];
      [self.contentView addSubview:self.label];
  }
  return self;
}

@end
