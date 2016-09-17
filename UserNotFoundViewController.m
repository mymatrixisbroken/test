//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "UserNotFoundViewController.h"

@interface UserNotFoundViewController ()

@end

@implementation UserNotFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self descriptionForEmptyDataSet];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)descriptionForEmptyDataSet{
    _label.text = @"You aren't signed in :(";
    _label.textColor = [UIColor colorWithHex:@"828587"];
    _label.font = [UIFont systemFontOfSize:14.0];
}

- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (IBAction)tappedLogIn:(UIButton *)sender {
    [self performSegueWithIdentifier:@"userNotFoundLoginSegue" sender:self];

}
- (IBAction)tappedImNew:(UIButton *)sender {
    [self performSegueWithIdentifier:@"userNotFoundSigninSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"userNotFoundLoginSegue"]){
        LoginViewController *controller = (LoginViewController *)segue.destinationViewController;
        dispatch_async(dispatch_get_main_queue(), ^{
            controller.viewForButtonCreateAccount.hidden = YES;
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
