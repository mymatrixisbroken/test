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
    [self loadLabels];
    [self loadImageView];
    [self loadRatingScore];

    if ([user.strainsTried indexOfObject:strain.strainKey] != NSNotFound) {
        self.smokedButton.selected = YES;
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadImageView {
    imageClass *image = [[imageClass alloc] init];
    
    if ([strain.imagesArray objectAtIndex:0] != [NSNull null]) {
        image = [strain.imagesArray objectAtIndex:0];

    }

    _strainImage.image = [UIImage imageWithData: image.data];

}
- (IBAction)tappedStrainImage:(UITapGestureRecognizer *)sender {
    [user goToPopoverImageViewController:self];
}
- (IBAction)tappedMenuButton:(UIButton *)sender {
    [user presentStrainEditAlert:self];
}

- (void)loadLabels {
    _strainNameLabel.adjustsFontSizeToFitWidth = YES;
    [self setLabelValues];
}

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

- (void) setLabelValues {
    _strainNameLabel.text = strain.strainName;
    _strainTHCLabel.text =  [@"THC: "stringByAppendingString: strain.thc];
    _strainCBDLabel.text =  [@"CBD: " stringByAppendingString:strain.cbd];
    _strainSpeciesLabel.text = strain.species;
    _strainGrowerLabel.text = [@"By: " stringByAppendingString:strain.grower];
    _strainFlavorLabel.text = strain.flavor;
    _strainAromaLabel.text = strain.aroma;
    if (!(strain.availableAt.count == 0)) {
//        _availableAtLabel.text = [strain.availableAt objectAtIndex:0];
    }
    [self loadRatingCount];
    
    
//    NSArray *array = [NSArray arrayWithObjects:_happinessView, _upliftedView, _energeticView,_euphoricView,_relaxedView,nil];
//    NSArray *array1 = @[@(strain.happiness), @(strain.uplifting), @(strain.energetic), @(strain.euphoric), @(strain.relaxed)];
    
//    for (int i = 0; i < 5; i++) {
//        YLProgressBar *str = [array objectAtIndex:i];
//        int x = [[array1 objectAtIndex:i] intValue];
//        str.progressTintColor        = [UIColor colorWithRed:19.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1];
//        [str setProgress: x*.01];
//        str.indicatorTextLabel.text = [NSString stringWithFormat:@"%@", [array1 objectAtIndex:i]];
//        str.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
//        str.hideStripes = YES;
//        str.trackTintColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1];
//        
//    }
}


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

@end
