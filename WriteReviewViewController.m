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
    
    _storeStarRating.value = store.ratingScore;
    _storeRatingLabel.text = [NSString stringWithFormat:@"%.1f",store.ratingScore];
    _storeReviewCount.text = [[NSString stringWithFormat:@"%ld",(long)store.ratingCount] stringByAppendingString:@" Reviews"];
    _storeNameLabel.text = store.storeName;
    
    [_submitButton addTarget:self
                    action:@selector(tappedSubmitButton:)
          forControlEvents:UIControlEventTouchUpInside];
    
//    [self loadStarRating];
}

-(void)tappedSubmitButton:(UIButton *)button{
    if ([_reviewTextField.text length] < 5000) {
        //submit review
        
        NSString *rating = [NSString stringWithFormat:@"%ld",(long)_reviewStarRating.value];
        NSString *reviewKey = [[[[firebaseRef.ref child:@"reviewKeys"] child:@"stores"] child:store.storeKey] childByAutoId].key;
        [[[[[firebaseRef.ref child:@"reviewKeys"] child:@"stores"] child:store.storeKey] child:reviewKey] setValue:@"true"];
        [[[[firebaseRef.ref child:@"reviewAddedByUser"] child:reviewKey] child:user.userKey] setValue:@"true"];
//        [[[[firebaseRef.ref child:@"reviewAboutStore"] child:reviewKey] child:store.storeKey] setValue:@"true"];
        [[[[firebaseRef.ref child:@"reviewAboutObject"] child:reviewKey] child:store.storeKey] setValue:@"store"];
        [[[[firebaseRef.ref child:@"reviewUserWroteReview"] child:user.userKey] child:reviewKey] setValue:@"true"];
        [[[[firebaseRef.ref child:@"reviewRating"] child:reviewKey] child:@"rating"] setValue:rating];
        [[[[firebaseRef.ref child:@"reviewMessage"] child:reviewKey] child:@"message"] setValue:_reviewTextField.text];
        [[[[[firebaseRef.ref child:@"starRating"] child:@"stores"] child:store.storeKey] child:user.userKey] setValue:rating];
        
        NSString *activityKey = [[firebaseRef.ref  child:@"activityType"] childByAutoId].key;
        [[[[firebaseRef.ref  child:@"activityType"]  child:activityKey] child:@"type"] setValue:@"wroteReviewForStore"];
        [[[[firebaseRef.ref  child:@"activityKey"]  child:user.userKey] child:activityKey] setValue:@"true"];
        [[[[firebaseRef.ref  child:@"activityObject"]  child:activityKey] child:store.storeKey] setValue:@"true"];
        [[[[firebaseRef.ref  child:@"activityInstantiationKey"]  child:activityKey] child:reviewKey] setValue:@"true"];

        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Congratulations!"
                                     message:@"Thank you for contributing to the community. Keep on Vibin'"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self dismissViewControllerAnimated:YES completion:^{}];
                                   }];
        
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    else{
        NSLog(@"length is %ld", [_reviewTextField.text length]);

        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Hey Shakespeare!"
                                     message:@"Don't write a biography keep it under 5,000 characters."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//- (IBAction)tappedPostReview:(UIBarButtonItem *)sender {
//    NSString *reviewKey = [firebaseRef.reviewsRef childByAutoId].key;
//    [self updateFirebaseValues:reviewKey];
//    [self dismissViewControllerAnimated:YES completion:^{}];
//}
//
//- (IBAction)tappedCancel:(UIBarButtonItem *)sender {
//    [self dismissViewControllerAnimated:YES completion:^{}];
//}
//
//- (void) loadStarRating{
////    [_star_rating.layer addSublayer:[self customUITextField]];
////    _star_rating.layer.masksToBounds = YES;
//}

//- (void) updateFirebaseValues:reviewKey {
//    if(objectsArray.strainOrStore == 0){
////        [[[[firebaseRef.reviewsRef child:@"strains"] child:reviewKey] child:@"message"] setValue:_review_text.text];
////        [[[[firebaseRef.reviewsRef child:@"strains"] child:reviewKey] child:@"strainKey"] setValue:strain.strainKey];
////        [[[[firebaseRef.reviewsRef child:@"strains"] child:reviewKey]  child:@"userKey"] setValue:user.userKey];
////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"message"] setValue:_review_text.text];
////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"objectKey"] setValue:strain.strainKey];
////        [[[firebaseRef.reviewsRef child:reviewKey]  child:@"userKey"] setValue:user.userKey];
////        [[[firebaseRef.reviewsRef child:reviewKey]  child:@"username"] setValue:user.username];
////        [[[firebaseRef.reviewsRef child:reviewKey]  child:@"objectType"] setValue:@"strain"];
////        imageClass *image = [[imageClass alloc] init];
////        image = [strain.imagesArray objectAtIndex:0];
////
//////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"objectImage"] setValue:image.imageURL];
////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"objectData"] setValue:image.dataString];
////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"objectName"] setValue:strain.strainName];
////
////        
//////        NSString *rating = [NSString stringWithFormat:@"%d", (int)_star_rating.value];
//////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"rating"] setValue:rating];
////
////        
//////        [[[[firebaseRef.strainsRef child:strain.strainKey] child:@"ratingCount"] child:user.userKey] setValue:rating];
////        [[[[[firebaseRef.strainsRef child:strain.strainKey] child:@"reviews"] child:reviewKey] child:@"reviewedBy"] setValue:user.userKey];
////        [[[[firebaseRef.usersRef child:user.userKey] child:@"reviews"] child:reviewKey] setValue:@"strainReview"];
////        
////        NSString *eventKey = [firebaseRef.eventsRef childByAutoId].key;
////        NSString *messageString = @"Wrote a review";
//////        [[[firebaseRef.eventsRef child:eventKey] child:@"userAvatarURL"] setValue:user.avatarURL];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"userAvatarData"] setValue:user.avatarDataString];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"message"] setValue:messageString];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"userID"] setValue:user.userKey];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"username"] setValue:user.username];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"eventType"] setValue:@"wroteReviewStrain"];
//////        [[[firebaseRef.eventsRef child:eventKey] child:@"objectURL"] setValue:image.imageURL];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"objectData"] setValue:image.dataString];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"objectName"] setValue:strain.strainName];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"objectRating"] setValue:[NSString stringWithFormat:@"%f",strain.ratingScore]];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"reviewMessage"] setValue:_review_text.text];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"reviewRating"]setValue:rating];
//
//    }
//    else{
////        [[[[firebaseRef.reviewsRef child:@"stores"] child:reviewKey] child:@"message"] setValue:_review_text.text];
////        [[[[firebaseRef.reviewsRef child:@"stores"] child:reviewKey] child:@"storeKey"] setValue:store.storeKey];
////        [[[[firebaseRef.reviewsRef child:@"stores"] child:reviewKey]  child:@"userKey"] setValue:user.userKey];
//        
////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"message"] setValue:_review_text.text];
////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"objectKey"] setValue:store.storeKey];
////        [[[firebaseRef.reviewsRef child:reviewKey]  child:@"userKey"] setValue:user.userKey];
////        [[[firebaseRef.reviewsRef child:reviewKey]  child:@"username"] setValue:user.username];
////        [[[firebaseRef.reviewsRef child:reviewKey]  child:@"objectType"] setValue:@"store"];
////        
////        imageClass *image = [[imageClass alloc] init];
////        image = [store.imagesArray objectAtIndex:0];
////
////        
//////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"objectImage"] setValue:image.imageURL];
////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"objectData"] setValue:image.dataString];
////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"objectName"] setValue:store.storeName];
////
////        
////        NSString *rating = [NSString stringWithFormat:@"%d", (int)_star_rating.value];
////        [[[firebaseRef.reviewsRef child:reviewKey] child:@"rating"] setValue:rating];
////
////        
////        [[[[firebaseRef.storesRef child:store.storeKey] child:@"ratingCount"] child:user.userKey] setValue:rating];
////        [[[[[firebaseRef.storesRef child:store.storeKey] child:@"reviews"] child:reviewKey] child:@"reviewedBy"] setValue:user.userKey];
////        [[[[firebaseRef.usersRef child:user.userKey] child:@"reviews"] child:reviewKey] setValue:@"storeReview"];
////        
////        NSString *eventKey = [firebaseRef.eventsRef childByAutoId].key;
////        NSString *messageString = @"Wrote a review";
//////        [[[firebaseRef.eventsRef child:eventKey] child:@"userAvatarURL"] setValue:user.avatarURL];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"userAvatarData"] setValue:user.avatarDataString];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"message"] setValue:messageString];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"userID"] setValue:user.userKey];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"username"] setValue:user.username];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"eventType"] setValue:@"wroteReviewStore"];
//////        [[[firebaseRef.eventsRef child:eventKey] child:@"objectURL"] setValue:image.imageURL];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"objectData"] setValue:image.dataString];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"objectName"] setValue:store.storeName];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"objectRating"] setValue:[NSString stringWithFormat:@"%f",store.ratingScore]];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"reviewMessage"] setValue:_review_text.text];
////        [[[firebaseRef.eventsRef child:eventKey] child:@"reviewRating"]setValue:rating];
//
//
//        
//
//    }
//}


//- (CALayer *) customUITextField{
//    CALayer *border = [CALayer layer];
//    UIColor *selectedColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1];
//    CGFloat borderWidth = 2;
//    border.borderColor = selectedColor.CGColor;
//    border.frame = CGRectMake(0, 75 - borderWidth, 560, 75);
//    border.borderWidth = borderWidth;
//    return border;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
