//
//  StoreReviewTableViewController.m
//  myProject
//
//  Created by Guy on 10/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StoreReviewTableViewController.h"

@interface StoreReviewTableViewController ()

@end

@implementation StoreReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",store.ratingScore];
    _reviewCountLabel.text = [[NSString stringWithFormat:@"%ld",(long)store.ratingCount] stringByAppendingString:@" Reviews"];
}

- (IBAction)tappedWriteReviewButton:(UIButton *)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToLoginViewController:self];
    }
    else{
        [user goToWriteReviewViewController:self];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *HeaderCellIdentifier = @"Header";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    
    // Configure the cell title etc
        
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"store reviews count %lu", store.reviewsArray.count);
    return [store.reviewsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 178;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"StoreReviewCell";
    StoreReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];

    
    reviewClassNew *review = [[reviewClassNew alloc] init];
    review = [store.reviewsArray objectAtIndex:indexPath.row];
    
//    [cell uploadCellWithReview:tempReview];
    if ([review.userImageLink count] > 0){                                      //check images array is null
        FIRStorageReference *spaceRef = [[[storageRef child:@"users"] child:review.authoredByUserKey] child:[review.userImageLink objectAtIndex:0]];
        UIImage *placeHolder = [[UIImage alloc] init];
        
        [cell.userImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
    }

    
    cell.usernameLabel.text = review.authoredByUsername;
    cell.reviewStarRating.value = [review.rating floatValue];;
    cell.reviewMessageLabel.text = review.message;
//    cell.reviewLikesLabel.text = promo.promoText;
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
}

@end
