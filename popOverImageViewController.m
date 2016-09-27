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
}

-(void) loadImageIntoView{
    if (objectsArray.selection == 1){
        _imageView.image = [UIImage imageWithData: store.data];
    }
    else{
        self.imageView.image = [UIImage imageWithData:strain.data];
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
