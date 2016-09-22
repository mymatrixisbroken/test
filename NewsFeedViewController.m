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
    
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.tableView addSubview:refresh];
    [refresh addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    //self.refreshControl = refresh;

    
    //self.tableView.emptyDataSetSource = self;
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
    
    
    
    
    FIRUser *u = [FIRAuth auth].currentUser;
    if (!(u.isAnonymous)) {
        [self newLoadEventsFromFirebaseDatabse];
    }
  /*  if (!(u.isAnonymous)) {
        _arr2 = [[NSMutableArray alloc] init];
        FIRDatabaseQuery *friendsQuery = [[[firebaseRef.usersRef child:user.user_key] child:@"friends"] queryOrderedByKey];
        [friendsQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if (![snapshot.value isEqual:@""]) {
                NSArray *keys = [snapshot.value allKeys];
                NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
                
                for (id key in sortedKeys) {
                    [_arr2 addObject:key];
                }
            }
        }];
    }*/
}

-(void) newLoadEventsFromFirebaseDatabse{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        [user.friends removeAllObjects];
        _array = [[NSMutableArray alloc] init];
        _dict = [[NSMutableDictionary alloc] init];
        FIRDatabaseQuery *friendsQuery = [[[firebaseRef.usersRef child:user.user_key] child:@"friends"] queryOrderedByKey];
        [friendsQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            NSLog(@"snapshot is %@", snapshot.value);
            
            if (![snapshot.value isEqual:@""]) {
                NSArray *keys = [snapshot.value allKeys];
                NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
                
                for (id key in sortedKeys) {
                    [user.friends addObject:key];
                }
                
                for (int i = 0; i<[user.friends count]; i++) {
                    FIRDatabaseQuery *eventQuery = [[firebaseRef.eventsRef queryOrderedByChild:@"uid"] queryEqualToValue:[user.friends objectAtIndex:i]];
                    NSLog(@"query is %@", eventQuery);
                    [_array addObject:eventQuery];
                }
                for (int i = 0; i<_array.count; i++) {
                    [[_array objectAtIndex:i] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                        if (snapshot.value == [NSNull null]) {}
                        else{
                            [user.events removeAllObjects];
                            [_dict addEntriesFromDictionary:snapshot.value];
                            
                            NSArray *keys = [_dict allKeys];
                            NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
                            
                            for (id key in sortedKeys) {
                                NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                                NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
                                value = [_dict valueForKey:key];
                                [tempDict setObject:value forKey:key ];
                                NSLog(@"temp dict is %@", value);
                                [user.events addObject:tempDict];
                            }
                        }
                    }];
                }
            }
            else{
                [user.events removeAllObjects];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });

        }];
    });
}


- (void)refreshTable:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    [user.friends removeAllObjects];
    _array = [[NSMutableArray alloc] init];
    _dict = [[NSMutableDictionary alloc] init];
    
    
    FIRDatabaseQuery *friendsQuery = [[[firebaseRef.usersRef child:user.user_key] child:@"friends"] queryOrderedByKey];
    [friendsQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        NSLog(@"snapshot is %@", snapshot.value);
        
        if (![snapshot.value isEqual:@""]) {
            NSArray *keys = [snapshot.value allKeys];
            NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
            
            for (id key in sortedKeys) {
                [user.friends addObject:key];
            }
            
            for (int i = 0; i<[user.friends count]; i++) {
                FIRDatabaseQuery *eventQuery = [[firebaseRef.eventsRef queryOrderedByChild:@"uid"] queryEqualToValue:[user.friends objectAtIndex:i]];
                [_array addObject:eventQuery];
            }
            
            for (int i = 0; i<_array.count; i++) {
                [[_array objectAtIndex:i] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                    if (snapshot.value == [NSNull null]) {}
                    else{
                        [user.events removeAllObjects];
                        [_dict addEntriesFromDictionary:snapshot.value];
                        
                        NSArray *keys = [_dict allKeys];
                        NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
                        
                        for (id key in sortedKeys) {
                            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                            NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
                            value = [_dict valueForKey:key];
                            [tempDict setObject:value forKey:key ];
                            [user.events addObject:tempDict];
                        }
                    }
                }];
            }
            [self.tableView reloadData];
            [refresh endRefreshing];
        }
        else{
            [user.events removeAllObjects];
            [refresh endRefreshing];
            [self.tableView reloadData];
        }
    }];
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
