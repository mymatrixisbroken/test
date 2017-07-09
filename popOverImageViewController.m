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
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedLeft)];
    swipeLeft.numberOfTouchesRequired = 1;
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedRight)];
    swipeRight.numberOfTouchesRequired = 1;
    swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    

}

-(void) loadImageIntoView{
    if (objectsArray.strainOrStore == 1){
        imageClass *image = [[imageClass alloc] init];
        image = [store.imagesArray objectAtIndex:store.imageArrayIndex];
        
        NSInteger thumbsDownScore = image.imageThumbsDown.count;
        NSString *errorTag2 = [NSString stringWithFormat: @"%ld",thumbsDownScore];
        self.voteCountLabel.text = errorTag2;
      
        NSInteger thumbsUpScore = image.imageThumbsUp.count;
        NSString *errorTag1 = [NSString stringWithFormat: @"%ld",thumbsUpScore];
        self.voteThumbsUpLabel.text = errorTag1;
        
        _imageView.image = [UIImage imageWithData: image.data];

        NSString *errorTag = [NSString stringWithFormat: @"%ld / ",store.imageArrayIndex+1];
        NSString *errorString = [NSString stringWithFormat: @"%ld",store.imagesArray.count];
        NSString *errorMessage = [errorTag stringByAppendingString:errorString];
        
        self.indexLabel.text = errorMessage;
        
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

-(void) screenSwipedLeft{
    if (objectsArray.strainOrStore == 1){
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
    if (objectsArray.strainOrStore == 1){
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
        if (objectsArray.strainOrStore == 1){
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
        if (objectsArray.strainOrStore == 1){
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
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
