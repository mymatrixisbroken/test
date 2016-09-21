//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "NewsFeedViewController.h"

@interface NewsFeedViewController ()
@end

@implementation NewsFeedViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.emptyDataSetSource = _tableView;
    //self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    
    //self.scrollView.contentSize = self.view.bounds.size;
    self.shyNavBarManager.scrollView = self.tableView;
    
    extensionViewClass *extView = [[extensionViewClass alloc] init];
    [extView setView:CGRectGetWidth(self.view.bounds)];
    [extView addButtons:CGRectGetWidth(self.view.bounds)];
    [extView.newsFeedButton addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.friendsButton addTarget:self action:@selector(friendsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.strainButton addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.storeButton addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.userProfileButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    [self.shyNavBarManager setExtensionView:extView];
    [self.shyNavBarManager setStickyExtensionView:YES];
}



- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSString *text = @"News feed empty";
    UIFont *font = [UIFont boldSystemFontOfSize:16.0];
    UIColor *textColor = [UIColor colorWithHex:@"828587"];
    [attributes setObject:@(-0.10) forKey:NSKernAttributeName];
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSString *text = @"When you add a friend, their activity will show up here.";
    UIFont *font = [UIFont systemFontOfSize:14.0];
    UIColor *textColor = [UIColor colorWithHex:@"828587"];
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    __block UIImage *image;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:@"http://i.imgur.com/3tGKHYV.png"]];
        if( data == nil ){
            NSLog(@"image is nil");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            image = [UIImage imageWithData:data];
        });
    });
    
    return image;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIColor colorWithHex:@"f7fafa"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [user.events count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"newsFeedCell";
    newsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSArray *keys = [[user.events objectAtIndex:indexPath.row] allKeys];
    NSString *key = [keys objectAtIndex:0];
    NSDictionary *dict = [user.events objectAtIndex:indexPath.row];
    NSDictionary *dict1 = [dict valueForKey:key];
    
    NSString *event = [dict1 valueForKey:@"message"];
    NSString *username = [dict1 valueForKey:@"username"];
    NSString *imageURL = [dict1 valueForKey:@"imageURL"];
    
    [cell uploadCellWithUsername:username event:event imageURL:imageURL];
    
    return cell;
}




-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"News Feed Navigation SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}

-(IBAction)friendsButtonPressed:(UIButton*)btn {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Friends Navigation SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"List View Controller  SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    objectsArray.selection = NO;
    [self presentViewController:vc animated:YES completion:NULL];
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    objectsArray.selection = YES;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"List View Controller  SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}

-(IBAction)userProfileButtonPressed:(UIButton*)btn {
    FIRUser *user = [FIRAuth auth].currentUser;
    if(user.anonymous){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"User Not Found SB ID"];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:vc animated:YES completion:NULL];
    }
    else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"User Profile Navigation SB ID"];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:vc animated:YES completion:NULL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
