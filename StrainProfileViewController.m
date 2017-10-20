//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StrainProfileViewController.h"

@interface StrainProfileViewController ()

@end

@implementation StrainProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getStrainKey];
    
    _spinner = [[UIActivityIndicatorView alloc]
                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.hidesWhenStopped = YES;
    _spinner.center = self.view.center;
    [self.view addSubview:_spinner];
    [_spinner startAnimating];

    
    _passedStringSegueFromStore = @"didNotNavigateFromStore";
    
//    if ([_passedString isEqualToString:@"didNotNavigateFromStore"]) {
//        [_priceView setHidden:YES];
//        CGRect newFrame = _reviewsTableView.frame;
//        newFrame.origin.y -= 75;
//        _reviewsTableView.frame = newFrame;
//        [self.view setNeedsLayout];
//    }

    //    [self loadLabels];
    //    [self loadImageView];
    //    [self loadRatingScore];

//    if ([user.strainsTried indexOfObject:strain.strainKey] != NSNotFound) {
//        self.smokedButton.selected = YES;
//    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) getStrainKey{
    [strain init];
    
    NSLog(@"other user name is %@",_passedString);
    strain.strainName = _passedString;
    
    NSString *lowerString = [strain.strainName lowercaseString];
    
    FIRDatabaseQuery *queryLowerUserName = [[[firebaseRef.ref child:@"strainNames"] queryOrderedByChild:@"lowerName"] queryEqualToValue:lowerString];
    
    [queryLowerUserName observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSLog(@"strain snapshot is %@", snapshot.value);
            if ([[snapshot.value allKeys] count]== 1) {                         //check one email found
                strain.strainKey = [[snapshot.value allKeys] objectAtIndex:0];
                NSLog(@"strain key is %@", strain.strainKey);
                [self getStrainInformation];
            }
        }
    }];
    
}

- (void) getStrainInformation{
//    [self editButtonHiddenOrNot];
    [self getImagesStrain];
    [self getStrainName];
    [self getFamily];
    [self getCBD];
    [self getTHC];
    [self getCBN];
//    [self getStoreHours];
//    [self getStoreURL];
//    [self getPhoneNumber];
//    [self getGooglePlaceID];
    [self getRatingScore];
    [self getTotalCount];
    [self getMontlyCount];
    [self getDailyCount];
//    [self getPromoKeys];
//    [self getReviewKeys];
}

- (void) getImagesStrain {
    [[[[firebaseRef.ref child:@"images"] child:@"strains"] child:strain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            
            NSArray *imageKeys = [[NSArray alloc] init];
            imageKeys = [snapshot.value allKeys];
            
            for(int j=0; j<imageKeys.count ; j++){
                NSLog(@"image snapshot  is %@", snapshot.value);
                
                
                imageClass *image = [[imageClass alloc] init];
                image.imageKey = [imageKeys objectAtIndex:j];
                image.imageURL = [snapshot.value valueForKey:image.imageKey];
                [strain.imagesArray addObject:image];
            }
            
            NSLog(@"object image count is %lu", (unsigned long)[strain.imagesArray count]);
            
            [self loadImageView];
            [self getDownVotes];
            [self getUpVotes];
            [self sortStrainImagesByVotes];
            
        }
    }];
}

- (void) getStrainName {
    [[[firebaseRef.ref child:@"strainNames"] child:strain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            strain.strainName = [snapshot.value valueForKey:@"name"];
            NSLog(@"object name is %@", strain.strainName);
            _strainNameLabel.text = strain.strainName;
        }
    }];
}

- (void) getDownVotes {
    NSLog(@"image key  is %lu", strain.imagesArray.count);
    
    for (int j = 0; j < strain.imagesArray.count; j++){
        imageClass *image = [[imageClass alloc] init];
        image = [strain.imagesArray objectAtIndex:j];
        NSLog(@"image key  is %@", image.imageKey);
        
        
        [[[firebaseRef.ref child:@"thumbsDown"] child:image.imageKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                
                image.imageThumbsDown = [NSMutableArray arrayWithArray:[snapshot.value allKeys]];
                
                [strain.imagesArray replaceObjectAtIndex:j withObject:image];
            }
        }];
    }
}

- (void) getUpVotes {
    for (int j = 0; j < strain.imagesArray.count; j++){
        imageClass *image = [[imageClass alloc] init];
        image = [strain.imagesArray objectAtIndex:j];
        NSLog(@"image key  is %@", image.imageKey);
        
        
        [[[firebaseRef.ref child:@"thumbsUp"] child:image.imageKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                
                image.imageThumbsUp = [NSMutableArray arrayWithArray:[snapshot.value allKeys]];
                image.voteScore = image.imageThumbsUp.count - image.imageThumbsDown.count;
                
                [strain.imagesArray replaceObjectAtIndex:j withObject:image];
            }
            
        }];
    }
}

- (void) sortStrainImagesByVotes{
    [strain.imagesArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"voteScore" ascending:NO selector:@selector(compare:)]]];
}

- (void) getRatingScore {
    [[[[firebaseRef.ref child:@"starRating"] child:@"strains"] child:strain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSArray *scores = [[NSArray alloc] init];
            scores = [snapshot.value allValues];
            strain.ratingCount = [scores count];
            
            if ([scores count] > 0) {
                for (id i in scores){
                    strain.ratingScore = strain.ratingScore + [i floatValue];
                }
                _starRating.value = strain.ratingScore;
                _ratingCount.text = [[NSString stringWithFormat:@"%lu", strain.ratingCount] stringByAppendingString:@" Reviews"];
            }
        }
    }];
}

- (void) getTotalCount {
    
    [[[[firebaseRef.ref child:@"metrics"] child:@"strains"] child:strain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            strain.totalViews = [[snapshot.value valueForKey:@"totalViews"] integerValue];
            
            NSLog(@"object total views is %ld", (long)strain.totalViews);
        }
    }];
}
- (void) getMontlyCount {
    
    [[[[[firebaseRef.ref child:@"metrics"] child:@"strains"] child:strain.strainKey] child:@"monthlyViews"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            strain.monthlyViews = [[snapshot.value valueForKey:@"February 2017"]integerValue];
            
            NSLog(@"object montly views is %ld", (long)strain.monthlyViews);
        }
    }];
}
- (void) getDailyCount {
    
    [[[[[firebaseRef.ref child:@"metrics"] child:@"strains"] child:strain.strainKey] child:@"dailyViews"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            strain.dailyViews = [[snapshot.value valueForKey:@"01-Jan-2017"]integerValue];
            
            NSLog(@"object daily views is %ld", (long)strain.dailyViews);
        }
        [_spinner stopAnimating];
    }];
}

- (void) getFamily {
    [[[firebaseRef.ref child:@"strainFamily"] child:strain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            strain.family = [snapshot.value valueForKey:@"family"];
            _strainSpeciesLabel.text = strain.family;
            NSLog(@"object montly views is %@",strain.family);
        }
    }];
}

- (void) getCBD {
    [[[firebaseRef.ref child:@"CBD"] child:strain.strainKey]  observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            strain.cbd = [snapshot.value valueForKey:@"CBD"];
            _strainCBDLabel.text = [[NSString stringWithFormat:@"%@", strain.cbd] stringByAppendingString:@"%"];
        }
    }];
}

- (void) getTHC {
    [[[firebaseRef.ref child:@"THC"] child:strain.strainKey]  observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            strain.thc = [snapshot.value valueForKey:@"THC"];
            _strainTHCLabel.text = [[NSString stringWithFormat:@"%@", strain.thc] stringByAppendingString:@"%"];

        }
    }];
}

- (void) getCBN {
    [[[firebaseRef.ref child:@"CBN"] child:strain.strainKey]  observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            strain.cbn = [snapshot.value valueForKey:@"CBN"];
            _strainCBNLabel.text = [[NSString stringWithFormat:@"%@", strain.cbn] stringByAppendingString:@"%"];
        }
    }];
}


- (void)loadImageView {
    NSLog(@"strain images array count %lu", strain.imagesArray.count);
    
    if ([strain.imagesArray count] > 0) {
        FIRStorage *storage = [FIRStorage storage];
        FIRStorageReference *storageRef = [storage reference];
        
        imageClass *image = [[imageClass alloc] init];
        image = [strain.imagesArray objectAtIndex:0];
        
        NSLog(@"image link is %@", image.imageURL);
        FIRStorageReference *spaceRef = [[[storageRef child:@"strains"] child:strain.strainKey] child:image.imageURL];
        NSLog(@"ref is %@", spaceRef);
        
        UIImage *placeHolder = [[UIImage alloc] init];
        [_strainImage sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
    }
}

//- (void)loadImageView {
//    imageClass *image = [[imageClass alloc] init];
//    
////    if ([strain.imagesArray objectAtIndex:0] != [NSNull null]) {
////        image = [strain.imagesArray objectAtIndex:0];
//
////    }
//
////    _strainImage.image = [UIImage imageWithData: image.data];
//
//}

- (IBAction)tappedStrainImage:(UITapGestureRecognizer *)sender {
    [user goToPopoverImageViewController:self];
}
- (IBAction)tappedMenuButton:(UIButton *)sender {
    [user presentStrainEditAlert:self];
}

//- (void)loadLabels {
//    _strainNameLabel.adjustsFontSizeToFitWidth = YES;
//    [self setLabelValues];
//}

- (void)loadRatingScore {
    NSLog(@"rating is %f", strain.ratingScore);
    if( !(isnan(strain.ratingScore))){
        NSLog(@"1 rating is %f", strain.ratingScore);
        _starRating.value = strain.ratingScore;
    }
}

- (void)loadRatingCount{
    if( !(isnan(strain.ratingScore)))
        _ratingCount.text = [[NSString stringWithFormat:@"%lu", (unsigned long)strain.ratingCount] stringByAppendingString:@" reviews"];
}

- (IBAction)tappedBackButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"strainProfileToListSegue" sender:self];
}

//- (void) setLabelValues {
//    _strainNameLabel.text = strain.strainName;
////    _strainTHCLabel.text =  [@"THC: "stringByAppendingString: strain.thc];
////    _strainCBDLabel.text =  [@"CBD: " stringByAppendingString:strain.cbd];
//    _strainSpeciesLabel.text = strain.species;
////    _strainGrowerLabel.text = [@"By: " stringByAppendingString:strain.grower];
//    _strainFlavorLabel.text = strain.flavor;
//    _strainAromaLabel.text = strain.aroma;
//    if (!(strain.availableAt.count == 0)) {
////        _availableAtLabel.text = [strain.availableAt objectAtIndex:0];
//    }
//    [self loadRatingCount];
//
//
////    NSArray *array = [NSArray arrayWithObjects:_happinessView, _upliftedView, _energeticView,_euphoricView,_relaxedView,nil];
////    NSArray *array1 = @[@(strain.happiness), @(strain.uplifting), @(strain.energetic), @(strain.euphoric), @(strain.relaxed)];
//
////    for (int i = 0; i < 5; i++) {
////        YLProgressBar *str = [array objectAtIndex:i];
////        int x = [[array1 objectAtIndex:i] intValue];
////        str.progressTintColor        = [UIColor colorWithRed:19.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1];
////        [str setProgress: x*.01];
////        str.indicatorTextLabel.text = [NSString stringWithFormat:@"%@", [array1 objectAtIndex:i]];
////        str.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
////        str.hideStripes = YES;
////        str.trackTintColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1];
////
////    }
//}


- (IBAction)writeReviewButtonTapped:(UIButton *)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if (youser.email == nil) {
        [user goToUserNotSignedInViewController:self];
    } else {
        [user goToWriteReviewViewController:self];
    }
}
- (IBAction)tappedSmokedButton:(UIButton *)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if (youser.email == nil) {
        [user goToUserNotSignedInViewController:self];
    } else {
        _smokedButton.selected = !_smokedButton.selected;
        NSString *eventKey;
        
        if(_smokedButton.selected){
            eventKey = [firebaseRef.eventsRef childByAutoId].key;
            [[[[firebaseRef.usersRef child:user.userKey] child:@"strainsTried"] child:strain.strainKey] setValue:@"test"];
            [user.strainsTried addObject:strain.strainKey];

            NSString *messageString = @"Smoked a new strain";
            [[[firebaseRef.eventsRef child:eventKey] child:@"userAvatarData"] setValue:user.avatarDataString];
            [[[firebaseRef.eventsRef child:eventKey] child:@"message"] setValue:messageString];
            [[[firebaseRef.eventsRef child:eventKey] child:@"userID"] setValue:user.userKey];
            [[[firebaseRef.eventsRef child:eventKey] child:@"username"] setValue:user.username];
            [[[firebaseRef.eventsRef child:eventKey] child:@"eventType"] setValue:@"smokedNew"];
            imageClass *image = [[imageClass alloc] init];
            image = [strain.imagesArray objectAtIndex:0];

            [[[firebaseRef.eventsRef child:eventKey] child:@"objectData"] setValue:image.dataString];
            [[[firebaseRef.eventsRef child:eventKey] child:@"objectName"] setValue:strain.strainName];
            [[[firebaseRef.eventsRef child:eventKey] child:@"objectRating"] setValue:[NSString stringWithFormat:@"%f",strain.ratingScore]];
        }
        else{
            [[[[firebaseRef.usersRef child:user.userKey] child:@"strainsTried"]  child:strain.strainKey] removeValue];
            [user.strainsTried removeObject:strain.strainKey];
//            [[firebaseRef.eventsRef child:eventKey] removeValue];
        }
    }
}

- (CALayer *) customUITextField{
    CALayer *border = [CALayer layer];
    UIColor *selectedColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1];
    CGFloat borderWidth = 2;
    border.borderColor = selectedColor.CGColor;
    border.frame = CGRectMake(0, 200 - borderWidth, 600, 200);
    border.borderWidth = borderWidth;
    return border;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)familySegment:(UISegmentedControl *)sender {
}
@end
