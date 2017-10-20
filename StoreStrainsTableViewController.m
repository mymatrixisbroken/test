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
    NSLog(@"store reviews count %lu", store.hasStrainsArray.count);
    return [store.hasStrainsArray count];
}

- (IBAction)didTapFilterButton:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"strainsFilterSBID"];
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.preferredContentSize = CGSizeMake(175, 300);

    UIPopoverPresentationController *popOver = vc.popoverPresentationController;
    popOver.delegate = self;
    popOver.sourceView = self.view;
    popOver.sourceRect = sender.frame;
    popOver.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popOver.backgroundColor = [UIColor colorWithRed:7.0/255.0 green:18.0/255.0 blue:17.0/255.0 alpha:1.0];

//    vc.navigationBarHidden = YES;

    [self presentViewController:vc animated:YES completion:NULL];
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    strainClass *tempStrain = [[strainClass alloc] init];
    tempStrain = [store.hasStrainsArray objectAtIndex:indexPath.row];
    
    NSLog(@"strain has store name is %@", tempStrain.strainName);
    NSString *cellIdentifier = @"StoreStrainCell";
    StoreStrainsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.strainImageView.layer.cornerRadius = cell.strainImageView.frame.size.height /2;
    cell.strainImageView.layer.masksToBounds = YES;
    cell.strainImageView.layer.borderWidth = 0;


    cell.strainNameLabel.text = tempStrain.strainName;
    cell.strainFamilyLabel.text = tempStrain.family;
    cell.strainRatingView.value = tempStrain.ratingScore;
    cell.strainReviewCount.text = [[NSString stringWithFormat: @"%ld", (long)tempStrain.ratingCount] stringByAppendingString:@" Reviews"];;
    //    reviewClass *tempReview = [[reviewClass alloc] init];
    //    tempReview = [store.reviews objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    strainClass *tempStrain = [[strainClass alloc] init];
    tempStrain = [store.hasStrainsArray objectAtIndex:indexPath.row];

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StrainProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Strain Profile VC SB ID"];
    vc.passedString = tempStrain.strainName;
    [self.navigationController pushViewController:vc animated:false];
}


@end
