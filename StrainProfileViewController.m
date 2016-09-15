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
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadImageView {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:strain.image_name]];
        if( data == nil ){
            NSLog(@"image is nil");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            _strainImage.image = [UIImage imageWithData: data];
        });
    });
}
- (IBAction)tapped_strainImage:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"popOverStrainImage" sender:self];
}
- (IBAction)tapped_menu_button:(UIButton *)sender {
    
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Menu" message:@"Select Option" preferredStyle:UIAlertControllerStyleActionSheet];
        
        /*[actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            // Cancel button tappped.
        }]];*/
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Edit Strain" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self performSegueWithIdentifier:@"EditStrainSegue" sender:self];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        
        // Present action sheet.
        [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)loadLabels {
    _strainNameLabel.adjustsFontSizeToFitWidth = YES;
    [self setLabelValues];
}

- (void)loadRatingScore {
    _starRating.rating = strain.rating_score;
}

- (void)loadRatingCount{
    if(strain.rating_count != nil)
    _ratingCount.text = [[NSString stringWithFormat:@"%lu", (unsigned long)strain.rating_count] stringByAppendingString:@" reviews"];
}
- (IBAction)tappedBackButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"strainProfileToListSegue" sender:self];
}

- (void) setLabelValues {
    _strainNameLabel.text = strain.strain_name;
    _strainTHCLabel.text =  [@"THC: "stringByAppendingString: strain.thc];
    _strainCBDLabel.text =  [@"CBD: " stringByAppendingString:strain.cbd];
    _strainSpeciesLabel.text = strain.species;
    _strainGrowerLabel.text = [@"By: " stringByAppendingString:strain.grower];
    _strainFlavorLabel.text = strain.flavor;
    _strainAromaLabel.text = strain.aroma;
    [self loadRatingCount];
    
    _happinessView.progress = [strain.happiness floatValue];
    //_happinessView.type               = YLProgressBarTypeFlat;
    _happinessView.progressTintColor  = [UIColor blueColor];
    //_happinessView.hideStripes        = YES;
    _upliftedView.progress = [strain.uplifting floatValue];
    //_happinessView.type               = YLProgressBarTypeFlat;
    _upliftedView.progressTintColor  = [UIColor blueColor];
    //_happinessView.hideStripes        = YES;
    _euphoricView.progress = [strain.euphoric floatValue];
    //_happinessView.type               = YLProgressBarTypeFlat;
    _euphoricView.progressTintColor  = [UIColor blueColor];
    //_happinessView.hideStripes        = YES;
    _energeticView.progress = [strain.energetic floatValue];
    //_happinessView.type               = YLProgressBarTypeFlat;
    _energeticView.progressTintColor  = [UIColor blueColor];
    //_happinessView.hideStripes        = YES;
    _relaxedView.progress = [strain.relaxed floatValue];
    //_happinessView.type               = YLProgressBarTypeFlat;
    _relaxedView.progressTintColor  = [UIColor blueColor];
    //_happinessView.hideStripes        = YES;

    
    
}


- (IBAction)write_review_button_tapped:(UIButton *)sender {
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user.email == nil) {
        [self performSegueWithIdentifier:@"userNotSignedinWriteReviewSegue" sender:self];
    } else {
        [self performSegueWithIdentifier:@"StrainWriteReviewSegue" sender:self];
    }
}

-(void) alertNoUserLoggedIn {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Uh-oh! You are not signed in." message:@"Please signin to write a review." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *login_action = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self performSegueWithIdentifier:@"strainReviewToLoginSegue" sender:self];
    }];
    UIAlertAction *signup_action = [UIAlertAction actionWithTitle:@"Signup" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self performSegueWithIdentifier:@"strainReviewToSignupSegue" sender:self];
    }];
    UIAlertAction *cancel_action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
     // Cancel button tappped.
    }];

    [alert addAction:login_action];
    [alert addAction:signup_action];
    [alert addAction:cancel_action];
    [self presentViewController:alert animated:YES completion:nil];
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
