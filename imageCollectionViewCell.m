//
//  imageCollectionViewCell.m
//  myProject
//
//  Created by Guy on 9/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "imageCollectionViewCell.h"

@implementation imageCollectionViewCell
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
