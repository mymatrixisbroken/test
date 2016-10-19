//
//  userReviewsViewController.m
//  myProject
//
//  Created by Guy on 10/18/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "userReviewsViewController.h"

@interface userReviewsViewController ()

@end

@implementation userReviewsViewController

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [user.reviews count];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    //    [rightUtilityButtons sw_addUtilityButtonWithColor:
    //     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
    //                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell{
    return YES;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:{
            NSLog(@"Delete button was pressed");
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            reviewClass *review = [user.reviews objectAtIndex:cellIndexPath.row];
            NSLog(@"review key is %@", review.reviewKey);
            
            [[firebaseRef.reviewsRef child:review.reviewKey]  removeValue];
            [user.reviews removeObject:review];
                        
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            
            break;
        }
        case 1:
        {
            //            // Delete button was pressed
            //            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            //
            ////            [_testArray removeObjectAtIndex:cellIndexPath.row];
            //            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath]
            //                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            //            break;
        }
        default:
            break;
    }
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"userReviewCell";
    userReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    reviewClass *tempReview = [[reviewClass alloc] init];
    tempReview = [user.reviews objectAtIndex:indexPath.row];
    //    NSLog(@"object name is %@", tempReview.objectName);
    
    //    dispatch_async(dispatch_get_global_queue(0,0), ^{
    //        NSInteger length = [tempReview.objectImageURL length];
    //        NSString *smallImageURL = [tempReview.objectImageURL substringWithRange:NSMakeRange(0, length-4)];
    //        smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];
    //
    //        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
    //        if( data == nil ){
    //            NSLog(@"image is nil");
    //            return;
    //        }
    //        else{
    //            tempReview.data = data;
    //        }
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [self.tableView reloadData];
    //        });
    //    });
    
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;

    [cell uploadCellWithReview:tempReview];
    
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
