//
//  StoreReviewTableViewController.m
//  myProject
//
//  Created by Guy on 10/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StoreStrainsTableViewController.h"

@interface StoreStrainsTableViewController ()

@end

@implementation StoreStrainsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

//- (IBAction)tappedWriteReviewButton:(UIButton *)sender {
//    FIRUser *youser = [FIRAuth auth].currentUser;
//    if (youser.email == nil) {
//        [user goToUserNotSignedInViewController:self];
//    } else {
//        [user goToWriteReviewViewController:self];
//    }
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    static NSString *HeaderCellIdentifier = @"Header";
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
//    }
//
//    // Configure the cell title etc
//
//    return cell;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"store reviews count %lu", store.imagesArray.count);
    return 1;
    //    return [store.imagesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"StoreStrainCell";
    StoreStrainsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //    reviewClass *tempReview = [[reviewClass alloc] init];
    //    tempReview = [store.reviews objectAtIndex:indexPath.row];
    
    [cell uploadCellWithPhoto];
    
    return cell;
}

@end
