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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.shyNavBarManager.scrollView = self.tableView;
    [self loadExtView];
    
    _queriesArray = [[NSMutableArray alloc] init];
    _dict = [[NSMutableDictionary alloc] init];

    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.tableView addSubview:refresh];
    [refresh addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    
    if (!([FIRAuth auth].currentUser.isAnonymous)) {
        [self newLoadEventsFromFirebaseDatabse];
//        [self loadEventsFromFirebaseDatabse];
    }
    
//    NSLog(@"friend events is %@", user.friendsEvents);
//    NSLog(@"friend events count is %lu", (unsigned long)user.friendsEvents.count);
}
- (void) loadExtView{
    extensionViewClass *extView = [[extensionViewClass alloc] init];
    [extView setView:CGRectGetWidth(self.view.bounds)];
    [extView addButtons:CGRectGetWidth(self.view.bounds)];
    [extView.storeButton addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.strainButton addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.newsFeedButton addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.userProfileButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.shyNavBarManager setExtensionView:extView];
    [self.shyNavBarManager setStickyExtensionView:YES];
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    objectsArray.selection = 1;
    [user goToStrainsStoresViewController:self];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    objectsArray.selection = 0;
    [user goToStrainsStoresViewController:self];
}

-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    [user goToNewsFeedViewController:self];
}

-(IBAction)userProfileButtonPressed:(UIButton*)btn {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToUserNotSignedInViewController:self];
    }
    else{
        [user goToCurrentUserProfileViewController:self];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [user.friendsEvents count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"newsFeedCell";
    newsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSArray *keys = [[user.friendsEvents objectAtIndex:indexPath.row] allKeys];
//    NSLog(@"keys is %@", keys);
    NSString *key = [keys objectAtIndex:0];
//    NSLog(@"key is %@", key);

    NSDictionary *dict = [user.friendsEvents objectAtIndex:indexPath.row];
    NSDictionary *dict1 = [dict valueForKey:key];
    
    NSString *event = [dict1 valueForKey:@"message"];
    NSString *username = [dict1 valueForKey:@"username"];
    NSString *avatarURL = [dict1 valueForKey:@"userAvatarURL"];
    
    [cell uploadCellWithUsername:username
                           event:event
                        imageURL:avatarURL];
        
    return cell;
}

- (void)refreshTable:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    [self newLoadEventsFromFirebaseDatabse];
//    [self loadEventsFromFirebaseDatabse];
    [refresh endRefreshing];
}

-(void) newLoadEventsFromFirebaseDatabse{
    for (int i = 0; i<[user.friends count]; i++) {
        FIRDatabaseQuery *eventQuery = [[firebaseRef.eventsRef queryOrderedByChild:@"userID"] queryEqualToValue:[user.friends objectAtIndex:i]];
        [_queriesArray addObject:eventQuery];
    }
    
    for (int i = 0; i<_queriesArray.count; i++) {
        [[_queriesArray objectAtIndex:i] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if (snapshot.value == [NSNull null]) {}
            else{
                [user.friendsEvents removeAllObjects];
                [_dict addEntriesFromDictionary:snapshot.value];
                
                NSArray *keys = [_dict allKeys];
                NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
                
                for (id key in sortedKeys) {
                    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                    NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
                    value = [_dict valueForKey:key];
                    [tempDict setObject:value forKey:key ];
                    [user.friendsEvents addObject:tempDict];
                    user.friendsEvents = [NSMutableArray arrayWithArray:[[user.friendsEvents reverseObjectEnumerator] allObjects]];
                }
                [self.tableView reloadData];
            }
        }];
    }
}

//-(void) loadEventsFromFirebaseDatabse{
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//
////        [user.friends removeAllObjects];
//        _array = [[NSMutableArray alloc] init];
//        _dict = [[NSMutableDictionary alloc] init];
//        
//        FIRDatabaseQuery *friendsQuery = [[[firebaseRef.usersRef child:user.userKey] child:@"friends"] queryOrderedByKey];
//  
//        [friendsQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//            if (![snapshot.value isEqual:@""]) {
//                NSArray *keys = [snapshot.value allKeys];
//                NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
//                
//                for (id key in sortedKeys) {
//                    [user.friends addObject:key];}
//                
//                for (int i = 0; i<[user.friends count]; i++) {
//                    FIRDatabaseQuery *eventQuery = [[firebaseRef.eventsRef queryOrderedByChild:@"userID"] queryEqualToValue:[user.friends objectAtIndex:i]];
//                    [_array addObject:eventQuery];
//                }
//                
//                for (int i = 0; i<_array.count; i++) {
//                    [[_array objectAtIndex:i] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//                        if (snapshot.value == [NSNull null]) {}
//                        else{
////                            [user.friendsEvents removeAllObjects];
//                            [_dict addEntriesFromDictionary:snapshot.value];
//                            
//                            NSArray *keys = [_dict allKeys];
//                            NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
//                            
//                            for (id key in sortedKeys) {
//                                NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
//                                NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
//                                value = [_dict valueForKey:key];
//                                [tempDict setObject:value forKey:key ];
//                                [user.friendsEvents addObject:tempDict];}
//                            
////                            user.friendsEvents = [NSMutableArray arrayWithArray:[[user.friendsEvents reverseObjectEnumerator] allObjects]]
//                            ;}}];}
////                [self.tableView reloadData];
//}
//            else{
////                [user.friendsEvents removeAllObjects];
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
////                [self.tableView reloadData];
//            });
//         }];
//    });
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

