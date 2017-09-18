//
//  photoCollectionViewCell.h
//  myProject
//
//  Created by Guy on 9/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "objectsArrayClass.h"

@interface photoCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *selectButton;
@property (copy, nonatomic) NSURL *imageURL;

@end
