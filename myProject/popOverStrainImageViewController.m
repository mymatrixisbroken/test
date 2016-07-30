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
    [_imageView setImage:strain.medium_image];

    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)touchedPopOverStrainImage:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
