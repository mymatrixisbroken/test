//
//  CurrentUserReviewsController.m
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "CurrentUserReviewsController.h"

@interface CurrentUserReviewsController ()

@end

@implementation CurrentUserReviewsController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionCount = 0;
    
    if ([user.reviews count] > 0)
        sectionCount++;
    else{
        UIImageView *noDataImage         = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width/2, self.tableView.bounds.size.height/2)];
        noDataImage.contentMode = UIViewContentModeCenter;
        noDataImage.image = [UIImage imageNamed:@"puppy"];
        self.tableView.backgroundView = noDataImage;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [user.reviews count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"CurrentUserReviewCell";
    CurrentUserReviewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    reviewClass *tempReview = [[reviewClass alloc] init];
    tempReview = [user.reviews objectAtIndex:indexPath.row];
    
    [cell uploadCellWithReview:tempReview];
    
    return cell;
}

@end
