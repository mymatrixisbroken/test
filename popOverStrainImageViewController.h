//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "strainClass.h"

@interface popOverStrainImageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) NSInteger i;
@property (strong, nonatomic) IBOutlet NSString *count;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

