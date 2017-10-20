//
//  AddStorePromoUIViewController.m
//  myProject
//
//  Created by Guy on 9/19/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "AddStorePromoViewController.h"

@interface AddStorePromoViewController ()

@end

@implementation AddStorePromoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_submitButton addTarget:self
                   action:@selector(tappedSubmitButton:)
         forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

-(void) tappedSubmitButton:(UIButton *) button{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];

    NSString *promoKey = [[[firebaseRef.ref child:@"promos"] child:store.storeKey] childByAutoId].key;
    [[[[[firebaseRef.ref child:@"promos"] child:store.storeKey] child:promoKey] child:promoKey] setValue:@"true"];
     
    [[[[[firebaseRef.ref child:@"promoDate"] child:store.storeKey] child:promoKey] childByAutoId] setValue:[dateFormat stringFromDate:today]];

    [[[[[firebaseRef.ref child:@"promoText"] child:store.storeKey] child:promoKey] childByAutoId] setValue:_promoTextField.text];

    [self viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
