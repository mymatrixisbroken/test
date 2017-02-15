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
    }
}
- (void) loadExtView{
    extensionViewClass *extView = [[extensionViewClass alloc] init];
    [extView setView:CGRectGetWidth(self.view.bounds)];
    [extView addButtons:CGRectGetWidth(self.view.bounds)];
    [extView.storeButton addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.strainButton addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.newsFeedButton addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.userProfileButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    extView.newsFeedButton.highlighted = YES;
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
    return [objectsArray.eventObjectArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"newsFeedCell";
    NSString *cellIdentifier1 = @"newsFeedCheckInCell";
    NSString *cellIdentifier2 = @"newsFeedWroteReviewStoreCell";
    NSString *cellIdentifier3 = @"newsFeedWroteReviewStrainCell";
    
    event.eventKey = [[[objectsArray.eventObjectArray objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    
    NSDictionary *dict = [objectsArray.eventObjectArray objectAtIndex:indexPath.row];
    NSDictionary *dict1 = [dict valueForKey:event.eventKey];
    
    event.message = [dict1 valueForKey:@"message"];
    event.username = [dict1 valueForKey:@"username"];
    
    NSString *userDataString = [dict1 valueForKey:@"userImageData"];
    event.userImageData = [[NSData alloc] initWithBase64EncodedString:userDataString options:0];
    
    event.eventType = [dict1 valueForKey:@"eventType"];
    event.objectName = [dict1 valueForKey:@"objectName"];
    event.objectRating = [dict1 valueForKey:@"objectRating"];

    NSString *objectDataString =  [dict1 valueForKey:@"objectImageData"];
    event.objectData = [[NSData alloc] initWithBase64EncodedString:objectDataString options:0];
    
    
    if ([event.eventType isEqual:@"smokedNew"]) {
        newsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell uploadCellWithUsernameEventData:event];
        
        cell.likeButton.tag = indexPath.row;
        return cell;

    } else if ([event.eventType isEqual:@"checkIn"]){
        newsFeedCheckInCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1 forIndexPath:indexPath];
        [cell uploadCellWithUsernameEventData:event];
        
        cell.likeButton.tag = indexPath.row;
        return cell;
    } else if ([event.eventType isEqual:@"wroteReviewStore"]){
        event.reviewRating = [dict1 valueForKey:@"reviewRating"];
        event.reviewMessage = [dict1 valueForKey:@"reviewMessage"];
        newsFeedWroteReviewStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
        [cell uploadCellWithUsernameEventData:event];
        cell.likeButton.tag = indexPath.row;

        return cell;
    } else {
        event.reviewRating = [dict1 valueForKey:@"reviewRating"];
        event.reviewMessage = [dict1 valueForKey:@"reviewMessage"];

        newsFeedWroteReviewStrainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3 forIndexPath:indexPath];
        [cell uploadCellWithUsernameEventData:event];
        cell.likeButton.tag = indexPath.row;

        return cell;
    }
    
}

- (void)refreshTable:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    [self newLoadEventsFromFirebaseDatabse];
    [refresh endRefreshing];
}

-(void) newLoadEventsFromFirebaseDatabse{
    NSLog(@"friend keys count is %lu", user.friendsKeys.count);
    [_queriesArray removeAllObjects];
    [objectsArray.eventObjectArray removeAllObjects];

    for (int i = 0; i<[user.friendsKeys count]; i++) {
        FIRDatabaseQuery *eventQuery = [[firebaseRef.eventsRef queryOrderedByChild:@"userID"] queryEqualToValue:[user.friendsKeys objectAtIndex:i]];
        [_queriesArray addObject:eventQuery];
    }
    
    for (int i = 0; i<_queriesArray.count; i++) {
        [[_queriesArray objectAtIndex:i] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if (snapshot.value == [NSNull null]) {}
            else{
                [objectsArray.eventObjectArray removeAllObjects];
                [_dict addEntriesFromDictionary:snapshot.value];
                
                NSArray *keys = [_dict allKeys];
                NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
                
                for (id key in sortedKeys) {
                    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                    NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
                    value = [_dict valueForKey:key];
                    [tempDict setObject:value forKey:key];
                    
                    NSString *dataString = [value valueForKey:@"userAvatarData"];
                    NSString *dataString2 = [value valueForKey:@"objectData"];

                    [[tempDict valueForKey:key] setObject:dataString forKey:@"userImageData"];
                    [[tempDict valueForKey:key] setObject:dataString2 forKey:@"objectImageData"];
                    
                    [objectsArray.eventObjectArray addObject:tempDict];
                    objectsArray.eventObjectArray = [NSMutableArray arrayWithArray:[[objectsArray.eventObjectArray reverseObjectEnumerator] allObjects]];
                }
                [self.tableView reloadData];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

