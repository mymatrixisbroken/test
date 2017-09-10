//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "strainClass.h"
#import "objectsArrayClass.h"
#import "storeClass.h"
#import "userClass.h"
#import "imageClass.h"
#import "FirebaseReferenceClass.h"

@interface popOverImageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *indexLabel;
@property (strong, nonatomic) IBOutlet UIButton *thumbsUpButton;
@property (strong, nonatomic) IBOutlet UIButton *thumbsDownButton;
@property (strong, nonatomic) IBOutlet UILabel *voteCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *voteThumbsUpLabel;
@end

