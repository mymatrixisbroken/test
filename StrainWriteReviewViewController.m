//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StrainWriteReviewViewController.h"

@interface StrainWriteReviewViewController ()

@end

@implementation StrainWriteReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStarRating];
    NSLog(@"0 user description is %@ ",user.user_key);
    NSLog(@"1 strain description is %@ ",strain.strain_key);
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tappedPostReview:(UIBarButtonItem *)sender {
    NSLog(@"2 submit button tapped is %@ ",user.user_key);
    NSString *review_key = [firebaseRef.reviewsRef childByAutoId].key;
    [self updateFirebaseVaslues:review_key];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)tappedCancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void) loadStarRating{
    [_star_rating.layer addSublayer:[self customUITextField]];
    _star_rating.layer.masksToBounds = YES;
}

- (void) updateFirebaseVaslues:review_key {
    NSLog(@"3 entered update firebase is %@ ",user.user_key);
    
    [[[[firebaseRef.reviewsRef child:@"strains"] child:review_key] child:@"message"] setValue:_review_text.text];
    [[[[firebaseRef.reviewsRef child:@"strains"] child:review_key] child:@"strain_key"] setValue:strain.strain_key];
    [[[[firebaseRef.reviewsRef child:@"strains"] child:review_key]  child:@"user_key"] setValue:user.user_key];
    
   /* [[[firebaseRef.strainsRef child:strain.strain_key] child:@"rating_count" ] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSString *current_count = snapshot.value;
        NSLog(@"current count is %@",current_count);
        NSInteger x = [current_count integerValue];
        x = x+1;
        NSLog(@"x count is %ld",(long)x);
        
        NSString *string = [NSString stringWithFormat:@"%ld", (long)x];
        NSLog(@"string count is %@",string);
        
    }];*/
    
    NSString *rating = [NSString stringWithFormat:@"%d", (int)_star_rating.rating];
    
    [[[[firebaseRef.strainsRef child:strain.strain_key] child:@"rating_count"] child:user.user_key] setValue:rating];

    
    [[[[firebaseRef.strainsRef child:strain.strain_key] child:@"reviews"] child:review_key] setValue:@"review_key"];
    
    [[[[firebaseRef.usersRef child:user.user_key] child:@"reviews"] child:review_key] setValue:@"review_key"];
    [[[[firebaseRef.usersRef child:user.user_key] child:@"strains_tried"] child:strain.strain_key] setValue:strain.strain_name];
}


- (CALayer *) customUITextField{
    CALayer *border = [CALayer layer];
    UIColor *selectedColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1];
    CGFloat borderWidth = 2;
    border.borderColor = selectedColor.CGColor;
    border.frame = CGRectMake(0, 75 - borderWidth, 560, 75);
    border.borderWidth = borderWidth;
    return border;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
