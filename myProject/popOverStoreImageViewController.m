//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "popOverStoreImageViewController.h"
@interface popOverStoreImageViewController ()

@end

@implementation popOverStoreImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_imageView setImage:store.medium_image];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)touchedPopOverStoreImage:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
