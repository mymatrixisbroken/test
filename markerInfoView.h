//
//  mapInfoView.h
//  myProject
//
//  Created by Guy on 10/12/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import HCSStarRatingView;

@interface markerInfoView : UIView
@property (strong, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *starRatingView;
@property (strong, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *storeImageView;

@end
