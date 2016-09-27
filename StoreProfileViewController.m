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
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)tappedImage:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"storeImageViewSegue" sender:self];
}
- (IBAction)tapped_back_button:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"storeProfileToListSegue" sender:self];
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
            
            NSString *messageString = [@"Checked in to " stringByAppendingString:store.storeName];
            [[[firebaseRef.eventsRef child:eventKey] child:@"userAvatarURL"] setValue:user.avatarURL];
            [[[firebaseRef.eventsRef child:eventKey] child:@"message"] setValue:messageString];
            [[[firebaseRef.eventsRef child:eventKey] child:@"userID"] setValue:user.userKey];
            [[[firebaseRef.eventsRef child:eventKey] child:@"username"] setValue:user.username];
        }
        else{
            [[[[firebaseRef.usersRef child:user.userKey] child:@"storesVisit"]  child:store.storeKey] removeValue];
            [user.storesVisited removeObject:store.storeKey];
            [[firebaseRef.eventsRef child:eventKey] removeValue];
        }
    }
}

- (void)loadImageView {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[store.imageNames objectAtIndex:0]]];
        if( data == nil ){
            NSLog(@"image is nil");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            _store_image_view.image = [UIImage imageWithData: data];
        });
    });
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"EditStoreSegue"]){
        //EditStoreViewController *controller = (EditStoreViewController *)segue.destinationViewController;
        //controller.store = _store;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
