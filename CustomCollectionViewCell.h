//
//  CustomCollectionViewCell.h
//  myProject
//
//  Created by Guy on 8/1/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CustomCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end
