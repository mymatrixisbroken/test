//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "CurrentUserProfileViewController.h"

@interface CurrentUserProfileViewController ()

@end

@implementation CurrentUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _usernameLabel.text = user.username;
    [self loadProfilePicture];
    self.scrollView.contentSize = self.view.bounds.size;
    self.shyNavBarManager.scrollView = self.scrollView;
    [self loadExtView];
    
    _myFriendsNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)user.friendsKeys.count];
    _myReviewsNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)user.reviews.count];
    _strainsTriedNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)user.friendRequestsIncomingKeys.count];
    _storesVisitedNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)user.storesVisited.count];
    
    [[firebaseRef.usersRef child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        if (!([[snapshot.value valueForKey:@"badges"]  isEqual: @""])) {
            NSDictionary *dictionary = [snapshot.value valueForKey:@"badges"];
            [user.badges removeAllObjects];
            
            for (id key in dictionary) {
                NSString *value = [dictionary valueForKey:key];
                if ([value isEqualToString:@"true"]) {
                    [user.badges addObject:key];
                }
            }
            _badgesNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)user.badges.count];
        }
        
        if (!([[snapshot.value valueForKey:@"friends"]  isEqual: @""])) {
            [user.friendsKeys removeAllObjects];
            user.friendsKeys = [NSMutableArray arrayWithArray:[[snapshot.value valueForKey:@"friends"] allKeys]];
        }

        
        if (!([[snapshot.value valueForKey:@"friendRequestsIncoming"]  isEqual: @""])) {
            [user.friendRequestsIncomingKeys removeAllObjects];
            user.friendRequestsIncomingKeys = [NSMutableArray arrayWithArray:[[snapshot.value valueForKey:@"friendRequestsIncoming"] allKeys]];
        }

    }];
}

- (void) loadExtView{
    extensionViewClass *extView = [[extensionViewClass alloc] init];
    [extView setView:CGRectGetWidth(self.view.bounds)];
    [extView addButtons:CGRectGetWidth(self.view.bounds)];
    [extView.storeButton addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.strainButton addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.newsFeedButton addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.userProfileButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.shyNavBarManager setExtensionView:extView];
    [self.shyNavBarManager setStickyExtensionView:YES];
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    objectsArray.selection = 1;
    [user goToStrainsStoresViewController:self];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    objectsArray.selection = 0;
    [user goToStrainsStoresViewController:self];
}

-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    [user goToNewsFeedViewController:self];
}

-(IBAction)userProfileButtonPressed:(UIButton*)btn {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToUserNotSignedInViewController:self];
    }
    else{
        [user goToCurrentUserProfileViewController:self];
    }
}


-(void) loadProfilePicture{
    self.imageView.image = [UIImage imageWithData:user.data];
}

- (IBAction)signOutButtonTapped:(UIButton *)sender {
    NSError *error;
    [user init];
    [[FIRAuth auth] signOut:&error];
    if (!error) {
        // Sign-out succeeded
        [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser * _Nullable youser, NSError * _Nullable error) {
            if (error != nil) {
                // Uh-oh, an error occurred!
                NSLog(@"Anonymous Firebase User is NOT signed in..");
                NSLog(@"%@", error.localizedDescription);
            }
            else {
                //Assign current Firebase user to a variable called user
                if([FIRAuth auth].currentUser.anonymous){
                    [user goToLoginViewController:self];
                }
            }
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedImageView:(UITapGestureRecognizer *)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped.
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        picker2 = [[UIImagePickerController alloc] init];
        self->picker2.delegate = self;
        [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:picker2 animated:YES completion:NULL];
        // Distructive button tapped.[self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        picker = [[UIImagePickerController alloc] init];
        self->picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:picker animated:YES completion:NULL];
        // OK button tapped. [self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.contentMode  = UIViewContentModeScaleAspectFit;
    [self.imageView setImage:image];
    
    
    CGSize size = CGSizeMake(500, 500);
    UIImage *sizedImage = [[self class] imageWithImage:self.imageView.image scaledToSize:size];
    NSData *encodedString = UIImagePNGRepresentation(sizedImage);
    NSLog(@"image encoded= %@", encodedString);
    
    NSURL *theURL = [NSURL URLWithString:@"https://api.imgur.com/3/image"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
    //Specify method of request(Get or Post)
    [theRequest setHTTPMethod:@"POST"];
    
    //Pass some default parameter(like content-type etc.)
    [theRequest setValue:@"Client-ID bceb6364428afba" forHTTPHeaderField:@"Authorization"];
    [theRequest setHTTPBody:encodedString];
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    

    NSDictionary *dataDictionaryResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:0 error:&theError];
    NSLog(@"url to send request= %@",theURL);
    NSLog(@"%@",dataDictionaryResponse);
    
    
    NSDictionary *output = [dataDictionaryResponse valueForKey:@"data"];
    user.avatarURL = [output valueForKey:@"link"];
    NSLog(@"url is %@", user.avatarURL);
    
    [[[firebaseRef.usersRef child:user.userKey] child:@"avatarURL"] setValue:user.avatarURL];


    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (IBAction)tappedBadges:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"badgesSegue" sender:self];
}
- (IBAction)tappedFriends:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"friendsSegue" sender:self];
}
- (IBAction)tappedMyReviews:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"myReviewsSegue" sender:self];
}
- (IBAction)tappedStrainsTried:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"strainsTriedSegue" sender:self];
}
- (IBAction)tappedStoresVisited:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"storesVisitedSegue" sender:self];
}



@end
