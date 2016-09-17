//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "popOverStrainImageViewController.h"
@interface popOverStrainImageViewController ()

@end

@implementation popOverStrainImageViewController

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
    _i = 1;
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[strain.imageNames objectAtIndex:_i] ]];
        if( data == nil ){
            NSLog(@"image is nil");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            _imageView.image = [UIImage imageWithData: data];
        });
    });
}

-(void) screenSwipedLeft{
    if(_i < (strain.imageNames.count -1)){
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[strain.imageNames objectAtIndex:_i+= 1] ]];
            if( data == nil ){
                NSLog(@"image is nil");
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
                _imageView.image = [UIImage imageWithData: data];
            });
        });
    }
}

-(void) screenSwipedRight{
    if(_i > 1){
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[strain.imageNames objectAtIndex:_i-= 1] ]];
        if( data == nil ){
            NSLog(@"image is nil");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            _imageView.image = [UIImage imageWithData: data];
        });
    });
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