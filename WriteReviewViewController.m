//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "WriteReviewViewController.h"

@interface WriteReviewViewController ()

@end

@implementation WriteReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStarRating];
}

- (IBAction)tappedPostReview:(UIBarButtonItem *)sender {
    NSString *reviewKey = [firebaseRef.reviewsRef childByAutoId].key;
    [self updateFirebaseValues:reviewKey];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)tappedCancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void) loadStarRating{
    [_star_rating.layer addSublayer:[self customUITextField]];
    _star_rating.layer.masksToBounds = YES;
}

- (void) updateFirebaseValues:reviewKey {
    if(objectsArray.selection == 0){
        [[[[firebaseRef.reviewsRef child:@"strains"] child:reviewKey] child:@"message"] setValue:_review_text.text];
        [[[[firebaseRef.reviewsRef child:@"strains"] child:reviewKey] child:@"strainKey"] setValue:strain.strainKey];
        [[[[firebaseRef.reviewsRef child:@"strains"] child:reviewKey]  child:@"userKey"] setValue:user.userKey];
        
        NSString *rating = [NSString stringWithFormat:@"%d", (int)_star_rating.value];
        [[[[firebaseRef.strainsRef child:strain.strainKey] child:@"ratingCount"] child:user.userKey] setValue:rating];
        [[[[[firebaseRef.strainsRef child:strain.strainKey] child:@"reviews"] child:reviewKey] child:@"reviewedBy"] setValue:user.userKey];
        [[[[firebaseRef.usersRef child:user.userKey] child:@"reviews"] child:reviewKey] setValue:@"strainReview"];
        
        NSString *eventKey = [firebaseRef.eventsRef childByAutoId].key;
        NSString *messageString = [@"Wrote a review for strain " stringByAppendingString:strain.strainName];
        [[[firebaseRef.eventsRef child:eventKey] child:@"userAvatarURL"] setValue:user.avatarURL];
        [[[firebaseRef.eventsRef child:eventKey] child:@"message"] setValue:messageString];
        [[[firebaseRef.eventsRef child:eventKey] child:@"userID"] setValue:user.userKey];
        [[[firebaseRef.eventsRef child:eventKey] child:@"username"] setValue:user.username];
    }
    else{
        [[[[firebaseRef.reviewsRef child:@"stores"] child:reviewKey] child:@"message"] setValue:_review_text.text];
        [[[[firebaseRef.reviewsRef child:@"stores"] child:reviewKey] child:@"storeKey"] setValue:store.storeKey];
        [[[[firebaseRef.reviewsRef child:@"stores"] child:reviewKey]  child:@"userKey"] setValue:user.userKey];
        
        NSString *rating = [NSString stringWithFormat:@"%d", (int)_star_rating.value];
        [[[[firebaseRef.storesRef child:store.storeKey] child:@"ratingCount"] child:user.userKey] setValue:rating];
        [[[[[firebaseRef.storesRef child:store.storeKey] child:@"reviews"] child:reviewKey] child:@"reviewedBy"] setValue:user.userKey];
        [[[[firebaseRef.usersRef child:user.userKey] child:@"reviews"] child:reviewKey] setValue:@"storeReview"];
        
        NSString *eventKey = [firebaseRef.eventsRef childByAutoId].key;
        NSString *messageString = [@"Wrote a review for store " stringByAppendingString:store.storeName];
        [[[firebaseRef.eventsRef child:eventKey] child:@"userAvatarURL"] setValue:user.avatarURL];
        [[[firebaseRef.eventsRef child:eventKey] child:@"message"] setValue:messageString];
        [[[firebaseRef.eventsRef child:eventKey] child:@"userID"] setValue:user.userKey];
        [[[firebaseRef.eventsRef child:eventKey] child:@"username"] setValue:user.username];
    }
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
