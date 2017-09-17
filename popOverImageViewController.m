//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "popOverImageViewController.h"
@interface popOverImageViewController ()

@end

@implementation popOverImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImageIntoView];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedLeft)];
    swipeLeft.numberOfTouchesRequired = 1;
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedRight)];
    swipeRight.numberOfTouchesRequired = 1;
    swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];

    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedUp)];
    swipeUp.numberOfTouchesRequired = 1;
    swipeUp.direction=UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];

    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedDown)];
    swipeDown.numberOfTouchesRequired = 1;
    swipeDown.direction=UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];

    

}

-(void) loadImageIntoView{
    if ([_passedString rangeOfString:@"StoreProfile"].location != NSNotFound) {
        imageClass *image = [[imageClass alloc] init];
        NSLog(@"store images array count %lu", store.imagesArray.count);
        image = [store.imagesArray objectAtIndex:0];
        //    _store_image_view.image = [UIImage imageWithData: image.data];
        
        if ([store.imagesArray count] > 0) {
            FIRStorage *storage = [FIRStorage storage];
            FIRStorageReference *storageRef = [storage reference];
            
            imageClass *image = [[imageClass alloc] init];
            image = [store.imagesArray objectAtIndex:0];
            
            NSLog(@"image link is %@", image.imageURL);
            FIRStorageReference *spaceRef = [[[storageRef child:@"stores"] child:store.storeKey] child:image.imageURL];
            NSLog(@"ref is %@", spaceRef);
            
            UIImage *placeHolder = [[UIImage alloc] init];
            [_imageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
        }
        
//        NSInteger thumbsDownScore = image.imageThumbsDown.count;
//        NSString *errorTag2 = [NSString stringWithFormat: @"%ld",thumbsDownScore];
//        self.voteCountLabel.text = errorTag2;
//      
//        NSInteger thumbsUpScore = image.imageThumbsUp.count;
//        NSString *errorTag1 = [NSString stringWithFormat: @"%ld",thumbsUpScore];
//        self.voteThumbsUpLabel.text = errorTag1;
//        
//        NSString *errorTag = [NSString stringWithFormat: @"%ld / ",store.imageArrayIndex+1];
//        NSString *errorString = [NSString stringWithFormat: @"%ld",store.imagesArray.count];
//        NSString *errorMessage = [errorTag stringByAppendingString:errorString];
//        
//        self.indexLabel.text = errorMessage;
        
    }
    else{
        imageClass *image = [[imageClass alloc] init];
        image = [strain.imagesArray objectAtIndex:strain.imageArrayIndex];
        
        NSInteger thumbsDownScore = image.imageThumbsDown.count;
        NSString *errorTag2 = [NSString stringWithFormat: @"%ld",thumbsDownScore];
        self.voteCountLabel.text = errorTag2;
        
        NSInteger thumbsUpScore = image.imageThumbsUp.count;
        NSString *errorTag1 = [NSString stringWithFormat: @"%ld",thumbsUpScore];
        self.voteThumbsUpLabel.text = errorTag1;

        _imageView.image = [UIImage imageWithData: image.data];

        NSString *errorTag = [NSString stringWithFormat: @"%ld / ",strain.imageArrayIndex+1];
        NSString *errorString = [NSString stringWithFormat: @"%ld",strain.imagesArray.count];
        NSString *errorMessage = [errorTag stringByAppendingString:errorString];
        
        self.indexLabel.text = errorMessage;
    }
}

-(void) screenSwipedUp{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void) screenSwipedDown{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) screenSwipedLeft{
    if ([_passedString rangeOfString:@"StoreProfile"].location != NSNotFound) {
        if(store.imageArrayIndex < (store.imagesArray.count -1)){
        store.imageArrayIndex+= 1;
        [self loadImageIntoView];
        }
    }
    else{
        if(strain.imageArrayIndex < (strain.imagesArray.count -1)){
            strain.imageArrayIndex+= 1;
            [self loadImageIntoView];
        }
    }
}

-(void) screenSwipedRight{
    if ([_passedString rangeOfString:@"StoreProfile"].location != NSNotFound) {
        if(store.imageArrayIndex > 0){
            store.imageArrayIndex-= 1;
            [self loadImageIntoView];
        }
    }
    else{
        if(strain.imageArrayIndex > 0){
            strain.imageArrayIndex-= 1;
            [self loadImageIntoView];
        }
    }
}

- (IBAction)touchedThumbsUpButton:(UIButton *)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if (youser.email == nil) {
        [user goToUserNotSignedInViewController:self];
    } else {
        if ([_passedString rangeOfString:@"StoreProfile"].location != NSNotFound) {
            imageClass *image = [[imageClass alloc] init];
            image = [store.imagesArray objectAtIndex:store.imageArrayIndex];

            if (![image.imageThumbsUp containsObject:user.userKey]) {
                [image.imageThumbsUp addObject:user.userKey];
            }
            if ([image.imageThumbsDown containsObject:user.userKey]) {
                if (image.imageThumbsDown.count == 1){
                    image.imageThumbsDown = [[NSMutableArray alloc] init];
                }
                else{
                    [image.imageThumbsDown removeObject:user.userKey];
                }
            }
            
            NSString *index = [NSString stringWithFormat:@"%ld",(long)image.firebaseIndex];
            
            [[[[[[firebaseRef.storesRef child:store.storeKey] child:@"images"] child:index] child:@"thumbsUp"] child:user.userKey] setValue:@"test"];
            [[[[[[firebaseRef.storesRef child:store.storeKey] child:@"images"] child:index] child:@"thumbsDown"] child:user.userKey] removeValue];
        }
        else{
            imageClass *image = [[imageClass alloc] init];
            image = [strain.imagesArray objectAtIndex:strain.imageArrayIndex];

            if (![image.imageThumbsUp containsObject:user.userKey]) {
                [image.imageThumbsUp addObject:user.userKey];
            }
            if ([image.imageThumbsDown containsObject:user.userKey]) {
                if (image.imageThumbsDown.count == 1){
                    image.imageThumbsDown = [[NSMutableArray alloc] init];
                }
                else{
                    [image.imageThumbsDown removeObject:user.userKey];
                }
            }
            
            NSString *index = [NSString stringWithFormat:@"%ld",(long)image.firebaseIndex];
            
            [[[[[[firebaseRef.strainsRef child:strain.strainKey] child:@"images"] child:index] child:@"thumbsUp"] child:user.userKey] setValue:@"test"];
            [[[[[[firebaseRef.strainsRef child:strain.strainKey] child:@"images"] child:index] child:@"thumbsDown"] child:user.userKey] removeValue];
        }
        [self loadImageIntoView];
    }
}
- (IBAction)touchedThumbsDownButton:(UIButton *)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if (youser.email == nil) {
        [user goToUserNotSignedInViewController:self];
    } else {
        if ([_passedString rangeOfString:@"StoreProfile"].location != NSNotFound) {
            imageClass *image = [[imageClass alloc] init];
            image = [store.imagesArray objectAtIndex:store.imageArrayIndex];
            
            if (![image.imageThumbsDown containsObject:user.userKey]) {
                [image.imageThumbsDown addObject:user.userKey];

            }
            if ([image.imageThumbsUp containsObject:user.userKey]) {
                if (image.imageThumbsUp.count == 1){
                    image.imageThumbsUp = [[NSMutableArray alloc] init];
                }
                else{
                    [image.imageThumbsUp removeObject:user.userKey];
                }
            }

            NSString *index = [NSString stringWithFormat:@"%ld",(long)image.firebaseIndex];
            
                [[[[[[firebaseRef.storesRef child:store.storeKey] child:@"images"] child:index] child:@"thumbsDown"] child:user.userKey] setValue:@"test"];
            [[[[[[firebaseRef.storesRef child:store.storeKey] child:@"images"] child:index] child:@"thumbsUp"] child:user.userKey] removeValue];
        }
        else{
            imageClass *image = [[imageClass alloc] init];
            image = [strain.imagesArray objectAtIndex:strain.imageArrayIndex];
            
            if (![image.imageThumbsDown containsObject:user.userKey]) {
                [image.imageThumbsDown addObject:user.userKey];                
            }
            if ([image.imageThumbsUp containsObject:user.userKey]) {
                if (image.imageThumbsUp.count == 1){
                    image.imageThumbsUp = [[NSMutableArray alloc] init];
                }
                else{
                    [image.imageThumbsUp removeObject:user.userKey];
                }
            }
            
            NSString *index = [NSString stringWithFormat:@"%ld",(long)image.firebaseIndex];
            
            [[[[[[firebaseRef.strainsRef child:strain.strainKey] child:@"images"] child:index] child:@"thumbsDown"] child:user.userKey] setValue:@"test"];
            [[[[[[firebaseRef.strainsRef child:strain.strainKey] child:@"images"] child:index] child:@"thumbsUp"] child:user.userKey] removeValue];
        }
        [self loadImageIntoView];
    }
}

- (IBAction)touchedPopOverStrainImage:(UITapGestureRecognizer *)sender {
//    [self.navigationController popToRootViewControllerAnimated:NO];

//    UIViewController *vc = [self parentViewController];
//         UIViewController *vc = [self presentingViewController]; //ios 5 or later
//    [self dismissViewControllerAnimated:NO completion:^{}];
//    [vc dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
