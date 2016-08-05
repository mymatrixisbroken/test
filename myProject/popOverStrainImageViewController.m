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
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:strain.image_name]];
        if( data == nil ){
            NSLog(@"image is nil");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            _imageView.image = [UIImage imageWithData: data];
        });
    });

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
