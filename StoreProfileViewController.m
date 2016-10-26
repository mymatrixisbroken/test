//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StoreProfileViewController.h"

@interface StoreProfileViewController ()

@end

@implementation StoreProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLabels];
    [self loadImageView];
    [self loadRatingScore];
    [self loadReviewsFromFirebase];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loadReviewsFromFirebase{
    FIRDatabaseQuery *reviewQuery = [[firebaseRef.reviewsRef queryOrderedByChild:@"objectKey"] queryEqualToValue:store.storeKey];
    
    UITableViewController *tv = [[UITableViewController alloc] init];
    tv = self.childViewControllers[0];

    [reviewQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if (snapshot.value == [NSNull null]) {}
        else{
            for (NSInteger i = 0; i < [snapshot.value allKeys].count; i++) {
                reviewClass *tempReview = [[reviewClass alloc] init];
                tempReview.reviewKey = [[snapshot.value allKeys] objectAtIndex:i];
                NSLog(@"key is %@", tempReview.reviewKey);
                
                NSDictionary *dictionary = [[NSDictionary alloc] init];
                dictionary = [snapshot.value valueForKey:tempReview.reviewKey];
                tempReview.message = [dictionary valueForKey:@"message"];
                tempReview.objectImageURL = [dictionary valueForKey:@"objectImage"];
                tempReview.objectKey = [dictionary valueForKey:@"objectKey"];
                tempReview.objectName = [dictionary valueForKey:@"objectName"];
                tempReview.objectType = [dictionary valueForKey:@"objectType"];
                tempReview.userKey = [dictionary valueForKey:@"userKey"];
                tempReview.username = [dictionary valueForKey:@"username"];
                tempReview.rating = [dictionary valueForKey:@"rating"];
                tempReview.objectDataString = [dictionary valueForKey:@"objectData"];
                tempReview.objectData = [[NSData alloc] initWithBase64EncodedString:tempReview.objectDataString options:0];
                
                [store.reviews addObject:tempReview];
            }
    }
        [tv.tableView reloadData];
    }];
}

- (IBAction)tappedImage:(UITapGestureRecognizer *)sender {
    [user goToPopoverImageViewController:self];
}

- (IBAction)tappedWriteReviewButton:(UIButton *)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if (youser.email == nil) {
        [user goToUserNotSignedInViewController:self];
    } else {
        [user goToWriteReviewViewController:self];
    }
}
- (IBAction)tappedCheckInButton:(UIButton *)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if (youser.email == nil) {
        [user goToUserNotSignedInViewController:self];
    } else {
        _checkInButton.selected = !_checkInButton.selected;
        NSString *eventKey;
        NSString *checkInKey;
        if(_checkInButton.selected){
            
            NSDate *today = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd/MM/yyyy"];
            NSString *todaysDate = [dateFormat stringFromDate:today];

            eventKey = [firebaseRef.eventsRef childByAutoId].key;
            checkInKey = [[[firebaseRef.usersRef child:user.userKey] child:@"checkIns"] childByAutoId].key;

            [[[[firebaseRef.usersRef child:user.userKey] child:@"storesVisited"] child:store.storeKey] setValue:store.storeName];
            [user.storesVisited addObject:store.storeKey];
            
            [[[[[firebaseRef.usersRef child:user.userKey] child:@"checkIns"] child:checkInKey] child:@"storeName"] setValue:store.storeName];
            [[[[[firebaseRef.usersRef child:user.userKey] child:@"checkIns"] child:checkInKey] child:@"date"] setValue:todaysDate];
            [user.checkIns addObject:checkInKey];
            
            NSString *messageString = @"Checked in";
            [[[firebaseRef.eventsRef child:eventKey] child:@"userAvatarData"] setValue:user.avatarDataString];
            [[[firebaseRef.eventsRef child:eventKey] child:@"message"] setValue:messageString];
            [[[firebaseRef.eventsRef child:eventKey] child:@"userID"] setValue:user.userKey];
            [[[firebaseRef.eventsRef child:eventKey] child:@"username"] setValue:user.username];
            [[[firebaseRef.eventsRef child:eventKey] child:@"eventType"] setValue:@"checkIn"];

            imageClass *image = [[imageClass alloc] init];
            image = [store.imagesArray objectAtIndex:0];

            [[[firebaseRef.eventsRef child:eventKey] child:@"objectData"] setValue:image.dataString];
            [[[firebaseRef.eventsRef child:eventKey] child:@"objectName"] setValue:store.storeName];
            [[[firebaseRef.eventsRef child:eventKey] child:@"objectRating"] setValue:[NSString stringWithFormat:@"%f",store.ratingScore]];

        }
        else{
            [[[[firebaseRef.usersRef child:user.userKey] child:@"storesVisit"]  child:store.storeKey] removeValue];
            [user.storesVisited removeObject:store.storeKey];
            [[firebaseRef.eventsRef child:eventKey] removeValue];
        }
    }
}

- (void)loadImageView {
    imageClass *image = [[imageClass alloc] init];
    NSLog(@"store images array count %lu", store.imagesArray.count);
    image = [store.imagesArray objectAtIndex:0];
    _store_image_view.image = [UIImage imageWithData: image.data];

}

- (void)loadLabels {
    _store_name_label.adjustsFontSizeToFitWidth = YES;
    _store_address_label.adjustsFontSizeToFitWidth = YES;
    _store_city_label.adjustsFontSizeToFitWidth = YES;
    [self setLabelValues];
}

- (void) setLabelValues {
    _store_name_label.text = store .storeName;
    _store_address_label.text =  [@"Address: "stringByAppendingString: store .address];
    _store_city_label.text =  [@"City: " stringByAppendingString:store .city];
    _store_state_label.text = [@"State: " stringByAppendingString:store .state];
    _store_url_label.text = [@"Webstie: " stringByAppendingString:store .url];
    _store_phone_number_label.text = store .phone_number;
    [self loadRatingCount];
}

- (void)loadRatingScore {
    _store_rating_score.value = store.ratingScore;
}

- (void)loadRatingCount{
    _store_rating_count.text = [[NSString stringWithFormat:@"%lu", (unsigned long)store .ratingCount] stringByAppendingString:@" reviews"];
}

- (IBAction)tappedEditButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"EditStoreSegue" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
