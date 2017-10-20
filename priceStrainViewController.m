//
//  priceStrainViewController.m
//  myProject
//
//  Created by Guy on 10/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "priceStrainViewController.h"

@interface priceStrainViewController ()

@end

@implementation priceStrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _strainArray = [[NSMutableArray alloc] init];
    
    NSLog(@"strains array count %lu", (unsigned long)[_strainArray count]);
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedLeft)];
    swipeLeft.numberOfTouchesRequired = 1;
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];

    self.priceStrainsTableView.delegate = self;
    self.priceStrainsTableView.dataSource = self;
    self.priceStrainsTableView.allowsSelection = NO;

    [_confirmButton addTarget:self
                   action:@selector(tappedConfirmButton:)
         forControlEvents:UIControlEventTouchUpInside];
}

-(void)tappedConfirmButton:(UIButton *)button{
    //do something
    
    NSLog(@"visible row count is %lu",[self.priceStrainsTableView indexPathsForVisibleRows].count);
    
    for(NSIndexPath *indexPath in [self.priceStrainsTableView indexPathsForVisibleRows]){
//        NSString *cellIdentifier = @"resultCell";
//        priceStrainTableViewCell *cell = [_priceStrainsTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        priceStrainTableViewCell *cell = [_priceStrainsTableView cellForRowAtIndexPath:indexPath];

        
        strainClass *tempStrain = [[strainClass alloc] init];
        tempStrain = [_strainArray objectAtIndex:indexPath.row];
        
        [[[[firebaseRef.ref child:@"storeHasStrains"]  child:store.storeKey] child:tempStrain.strainKey] setValue:@"true"];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"oneGram"] setValue:cell.oneGramPrice.text];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"twoGram"] setValue:cell.twoGramPrice.text];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"eighth"] setValue:cell.oneEigthPrice.text];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"fourth"] setValue:cell.oneFourthPrice.text];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"half"] setValue:cell.oneHalfPrice.text];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"ounce"] setValue:cell.oneOuncePrice.text];
    }
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Thank you!"
                                 message:@"Thank you for helping the community thrive. Your photos will help other enthusiasts."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                   StoreProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Store Profile VC SB ID"];
                                   vc.passedString = store.storeName;
                                   [self.navigationController pushViewController:vc animated:false];
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];

}


-(void) screenSwipedLeft{
    FIRUser *currentUser = [FIRAuth auth].currentUser;
    if(currentUser.anonymous){
        [user gotoOptionListViewController:self];
    } else {
        [user gotoOptionListSignedInViewController:self];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return [_strainArray count];
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        NSString *cellIdentifier = @"resultCell";
        priceStrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if ([_strainArray count] > 0) {
            strainClass *tempStrain = [[strainClass alloc] init];
            tempStrain = [_strainArray objectAtIndex:indexPath.row];
            cell.strainNameLabel.text = tempStrain.strainName;
        }
        return cell;
    }
    else{
        NSString *cellIdentifier = @"resultCell";
        priceStrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        return cell;
    }
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
