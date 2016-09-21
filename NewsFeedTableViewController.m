//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "NewsFeedTableViewController.h"

@interface NewsFeedTableViewController ()
@end

@implementation NewsFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.tableView addSubview:refresh];
    [refresh addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
}

- (void)refreshTable:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    [user.friends removeAllObjects];
    _array = [[NSMutableArray alloc] init];
    _dict = [[NSMutableDictionary alloc] init];

    
    FIRDatabaseQuery *friendsQuery = [[[firebaseRef.usersRef child:user.user_key] child:@"friends"] queryOrderedByKey];
    [friendsQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
