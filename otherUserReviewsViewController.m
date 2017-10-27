//
//  otherUserReviewsViewController.m
//  myProject
//
//  Created by Guy on 10/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "otherUserReviewsViewController.h"

@interface otherUserReviewsViewController ()

@end

@implementation otherUserReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionCount = 0;
    
    if ([_otherUser.reviews count] > 0){
        sectionCount++;
    }
    else{
        UIView *rootView = [[[NSBundle mainBundle] loadNibNamed:@"reviewsEmptyView" owner:self options:nil] objectAtIndex:0];
        self.tableView.backgroundView = rootView;
    }
    NSLog(@"section count is %lu",sectionCount);
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_otherUser.reviews count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"userReviewCell";
    userReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    reviewClassNew *tempReview = [[reviewClassNew alloc] init];
    tempReview = [_otherUser.reviews objectAtIndex:indexPath.row];
    
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];
    
    if ([tempReview.objectImageLink count] > 0){                                      //check images array is null
        FIRStorageReference *spaceRef = [[[storageRef child:@"stores"] child:tempReview.objectKey] child:[tempReview.objectImageLink objectAtIndex:0]];
        UIImage *placeHolder = [[UIImage alloc] init];
        
        [cell.objectImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
    }
    
    cell.reviewRatingView.value = [tempReview.rating floatValue];
    cell.reviewMessageLabel.text = tempReview.message;
    cell.objectNameLabel.text = tempReview.objectName;
    //    cell.objectRatingView.value = tempReview.objectRating ;
    cell.objectReviewCount.text = [[NSString stringWithFormat: @"%ld", tempReview.objectReviewCount] stringByAppendingString:@" Reviews"];
    
    
    //    [cell uploadCellWithReview:tempReview];
    
    return cell;
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