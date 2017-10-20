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
    _emptyStateView.hidden = YES;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedLeft)];
    swipeLeft.numberOfTouchesRequired = 1;
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.shyNavBarManager.scrollView = self.tableView;
//    [self loadExtView];
    
//    user.activityArray = [[NSMutableArray alloc] init];
    _queriesArray = [[NSMutableArray alloc] init];
    _dict = [[NSMutableDictionary alloc] init];

    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.tableView addSubview:refresh];
    [refresh addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    
    [self getActivityKeys];

//    if (!([FIRAuth auth].currentUser.isAnonymous)) {
//        [self newLoadEventsFromFirebaseDatabse];
//    }
}

-(void) screenSwipedLeft{
    FIRUser *currentUser = [FIRAuth auth].currentUser;
    if(currentUser.anonymous){
        [user gotoOptionListViewController:self];
    } else {
        [user gotoOptionListSignedInViewController:self];
    }
}

- (void) loadExtView{
    extensionViewClass *extView = [[extensionViewClass alloc] init];
    [extView setView:CGRectGetWidth(self.view.bounds)];
    [extView addButtons:CGRectGetWidth(self.view.bounds)];
    [extView.extensionViewLabel setText:@"News Feed"];
    [extView.firstButton addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.secondButton addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.thirdButton addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.fourthButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    extView.fourthButton.highlighted = YES;
    [self.shyNavBarManager setExtensionView:extView];
    [self.shyNavBarManager setStickyExtensionView:YES];
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    objectsArray.strainOrStore = 1;
    [user goToStrainsStoresViewController:self];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    objectsArray.strainOrStore = 0;
    [user goToStrainsViewController:self];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionCount = 0;
    
    if ([user.activityArray count] > 0){
        sectionCount++;
        self.tableView.backgroundView = nil;
    }
    else{
//        UIImageView *noDataImage         = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width/2, self.tableView.bounds.size.height/2)];
//        noDataImage.contentMode = UIViewContentModeCenter;
//        noDataImage.image = [UIImage imageNamed:@"puppy"];
//        self.tableView.backgroundView = noDataImage;
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _emptyStateView.hidden = NO;
        [self.tableView addSubview:_emptyStateView];
//        self.tableView.backgroundView = _emptyStateView;

    }
    return sectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [user.activityArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"newsFeedStoreAddPhotosCell";
    NSString *cellIdentifier1 = @"newsFeedCheckInCell";
    NSString *cellIdentifier2 = @"newsFeedWroteReviewStoreCell";
    NSString *cellIdentifier3 = @"newsFeedWroteReviewStrainCell";
    
//    activity.activityKey = [[[objectsArray.eventObjectArray objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
//    
//    NSDictionary *dict = [objectsArray.eventObjectArray objectAtIndex:indexPath.row];
//    NSDictionary *dict1 = [dict valueForKey:activity.activityKey];
//    
//    activity.message = [dict1 valueForKey:@"message"];
//    activity.username = [dict1 valueForKey:@"username"];
//    
//    NSString *userDataString = [dict1 valueForKey:@"userImageData"];
//    activity.userImageData = [[NSData alloc] initWithBase64EncodedString:userDataString options:0];
//    
//    activity.activityType = [dict1 valueForKey:@"eventType"];
//    activity.objectName = [dict1 valueForKey:@"objectName"];
//    activity.objectRating = [dict1 valueForKey:@"objectRating"];
//
//    NSString *objectDataString =  [dict1 valueForKey:@"objectImageData"];
//    activity.objectData = [[NSData alloc] initWithBase64EncodedString:objectDataString options:0];
    
    activityClass *activity = [[activityClass alloc] init];
    activity = [user.activityArray objectAtIndex:indexPath.row];
    
    NSLog(@"activity type is %@", activity.activityType);
    
    if ([activity.activityType isEqual:@"storeAddPhotos"]) {
        newsFeedStoreAddPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        FIRStorage *storage = [FIRStorage storage];
        FIRStorageReference *storageRef = [storage reference];
        
        if ([activity.userImageLink count] > 0){                                      //check images array is null
            FIRStorageReference *spaceRef = [[[storageRef child:@"users"] child:activity.userKey] child:[activity.userImageLink objectAtIndex:0]];
            UIImage *placeHolder = [[UIImage alloc] init];
            
            [cell.userImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
        }
        
        if ([activity.objectImagesArray count] > 0) {
//            FIRStorage *storage = [FIRStorage storage];
//            FIRStorageReference *storageRef = [storage reference];
            imageClass *image = [[imageClass alloc] init];
            image = [activity.objectImagesArray objectAtIndex:0];
            FIRStorageReference *spaceRef = [[[storageRef child:@"stores"] child:activity.objectKey] child:image.imageURL];
            UIImage *placeHolder = [[UIImage alloc] init];
            
            [cell.strainImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
        }
        
        cell.usernameLabel.text = activity.username;
        cell.eventLabel.text = @"Added photos for:";
        cell.strainNameLabel.text = activity.objectName;
        cell.strainRatingView.value = activity.objectRating;
        cell.likeButton.titleLabel.text = @"Like";
        cell.commentsButton.titleLabel.text = @"Comments";
        cell.objectReviewCountLabel.text = [[NSString stringWithFormat: @"%ld", (long)activity.objectReviewCount] stringByAppendingString:@" Reviews"];
        [cell.likeButton addTarget:cell action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if ([objectsArray.eventObjectArray indexOfObject:activity.activityKey] != NSNotFound) {
            cell.likeButton.selected = YES;
        }
        cell.likeButton.tag = indexPath.row;
        return cell;

    }
    else if ([activity.activityType isEqual:@"wroteReviewForStore"]) {
        newsFeedWroteReviewStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
        FIRStorage *storage = [FIRStorage storage];
        FIRStorageReference *storageRef = [storage reference];
        
        if ([activity.userImageLink count] > 0){                                      //check images array is null
            FIRStorageReference *spaceRef = [[[storageRef child:@"users"] child:activity.userKey] child:[activity.userImageLink objectAtIndex:0]];
            UIImage *placeHolder = [[UIImage alloc] init];
            
            [cell.userImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
        }
        
        if ([activity.objectImagesArray count] > 0) {
            //            FIRStorage *storage = [FIRStorage storage];
            //            FIRStorageReference *storageRef = [storage reference];
            imageClass *image = [[imageClass alloc] init];
            image = [activity.objectImagesArray objectAtIndex:0];
            FIRStorageReference *spaceRef = [[[storageRef child:@"stores"] child:activity.objectKey] child:image.imageURL];
            UIImage *placeHolder = [[UIImage alloc] init];
            
            [cell.storeImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
        }
        
        cell.usernameLabel.text = activity.username;
        cell.eventLabel.text = @"Wrote a review for:";
        cell.storeNameLabel.text = activity.objectName;
        cell.storeRatingView.value = activity.objectRating;
        cell.likeButton.titleLabel.text = @"Like";
//        cell.commentsButton.titleLabel.text = @"Comments";
        cell.storeReviewCountLabel.text = [[NSString stringWithFormat: @"%ld", (long)activity.objectReviewCount] stringByAppendingString:@" Reviews"];
        cell.reviewMessageLabel.text = activity.instantiationMessage;
        cell.reviewRatingView.value = [activity.instantiationRating floatValue];
        [cell.likeButton addTarget:cell action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if ([objectsArray.eventObjectArray indexOfObject:activity.activityKey] != NSNotFound) {
            cell.likeButton.selected = YES;
        }
        cell.likeButton.tag = indexPath.row;
        return cell;

    }
    
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
        return cell;
    }

//    else if ([activity.activityType isEqual:@"checkIn"]){
//        newsFeedCheckInCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1 forIndexPath:indexPath];
//        [cell uploadCellWithUsernameEventData:activity];
//        
//        cell.likeButton.tag = indexPath.row;
//        return cell;
//    } else if ([activity.activityType isEqual:@"wroteReviewStore"]){
//        activity.reviewRating = [dict1 valueForKey:@"reviewRating"];
//        activity.reviewMessage = [dict1 valueForKey:@"reviewMessage"];
//        newsFeedWroteReviewStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
//        [cell uploadCellWithUsernameEventData:activity];
//        cell.likeButton.tag = indexPath.row;
//
//        return cell;
//    } else {
//        activity.reviewRating = [dict1 valueForKey:@"reviewRating"];
//        activity.reviewMessage = [dict1 valueForKey:@"reviewMessage"];
//
//        newsFeedWroteReviewStrainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3 forIndexPath:indexPath];
//        [cell uploadCellWithUsernameEventData:activity];
//        cell.likeButton.tag = indexPath.row;
//
//        return cell;
//    }
}

- (void)refreshTable:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    [self newLoadEventsFromFirebaseDatabse];
    [refresh endRefreshing];
}

-(void)getActivityKeys{
    NSLog(@"friend keys count is %lu", user.friendsKeys.count);
    [_queriesArray removeAllObjects];
    [objectsArray.eventObjectArray removeAllObjects];
    
    for (int i = 0; i<[user.friendsKeys count]; i++) {
        NSString *friendKey = [user.friendsKeys objectAtIndex:i];
        NSLog(@"friend key is %@",friendKey);
        [[[firebaseRef.ref child:@"activityKey"] child:friendKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            NSLog(@"snapshot is %@",snapshot.value);
            if (snapshot.value != [NSNull null]) {
                
                NSLog(@"snapshot count is %lu",[[snapshot.value allKeys] count]);
                for (int j = 0; (j < [[snapshot.value allKeys] count] && j <10 ); j++) {
                    activityClass *activity = [[activityClass alloc] init];
                    [user.activityArray insertObject:activity atIndex:i];
                    activity = [user.activityArray objectAtIndex:i];

                    activity.activityKey = [[snapshot.value allKeys] objectAtIndex:j];
                    activity.userKey = friendKey;
                    [[[firebaseRef.ref child:@"usernames"] child:friendKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                        activity.username = [snapshot.value valueForKey:@"username"];
                    }];
                    NSLog(@"activity key is %@",activity.activityKey);
                    [user.activityArray replaceObjectAtIndex:i withObject:activity];
                }
                [self getUserImages];
                [self getActivityType];
                [self getActivityObjectKey];
            }
        }];
    }
}

- (void) getUserImages{
    for (int i = 0; i<user.activityArray.count; i++) {
        activityClass *activity = [[activityClass alloc] init];
        activity = [user.activityArray objectAtIndex:i];

        [[[[firebaseRef.ref child:@"images"] child:@"users"] child:activity.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                for (id key in snapshot.value) {
                    [activity.userImageKey addObject:key];
                    [activity.userImageLink addObject:[snapshot.value valueForKey:key]];
                }
                [user.activityArray replaceObjectAtIndex:i withObject:activity];
            }
        }];
    }
}

- (void) getImagesStore:(NSInteger) i {
        activityClass *activity = [[activityClass alloc] init];
        activity = [user.activityArray objectAtIndex:i];

        NSLog(@"image object key  is %@", activity.objectKey);

        [[[[firebaseRef.ref child:@"images"] child:@"stores"] child:activity.objectKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                
                NSArray *imageKeys = [[NSArray alloc] init];
                imageKeys = [snapshot.value allKeys];
                
                for(int j=0; j<imageKeys.count ; j++){
                    NSLog(@"image snapshot  is %@", snapshot.value);
                    
                    
                    imageClass *image = [[imageClass alloc] init];
                    image.imageKey = [imageKeys objectAtIndex:j];
                    image.imageURL = [snapshot.value valueForKey:image.imageKey];
                    [activity.objectImagesArray addObject:image];
                }
                [user.activityArray replaceObjectAtIndex:i withObject:activity];
   
//                NSLog(@"object image count is %lu", (unsigned long)[store.imagesArray count]);
            }
        }];
}


-(void)getActivityType{
    for (int i = 0; i<user.activityArray.count; i++) {
        activityClass *activity = [[activityClass alloc] init];
        NSLog(@"count is %lu",[user.activityArray count]);

        activity = [user.activityArray objectAtIndex:i];
        
        [[[firebaseRef.ref child:@"activityType"] child:activity.activityKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            NSLog(@"2snapshot is %@",snapshot.value);

            if (snapshot.value != [NSNull null]) {
                activity.activityType = [[snapshot.value allValues] objectAtIndex:0];
                NSLog(@"activity type is %@",activity.activityType);
                [user.activityArray replaceObjectAtIndex:i withObject:activity];
                [self getActivityDetails:i];
            }
        }];
    }
}

-(void)getActivityObjectKey{
    for (int i = 0; i<user.activityArray.count; i++) {
        activityClass *activity = [[activityClass alloc] init];
        activity = [user.activityArray objectAtIndex:i];
        
        [[[firebaseRef.ref child:@"activityObject"] child:activity.activityKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            NSLog(@"3snapshot is %@",snapshot.value);

            if (snapshot.value != [NSNull null]) {
                activity.objectKey = [[snapshot.value allKeys] objectAtIndex:0];
                NSLog(@"activity object Key is %@'",activity.objectKey);
                [user.activityArray replaceObjectAtIndex:i withObject:activity];
                [self getImagesStore: i];
                [self getActivityObjectName: i];
                [self getActivityObjectRating: i];
            }
        }];
    }
}

-(void)getActivityObjectName:(NSInteger) i{
        activityClass *activity = [[activityClass alloc] init];
        activity = [user.activityArray objectAtIndex:i];
        
        [[[firebaseRef.ref child:@"storeNames"] child:activity.objectKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            NSLog(@"4snapshot is %@",snapshot.value);

            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                activity.objectName = [snapshot.value valueForKey:@"name"];
                NSLog(@"object name is %@", activity.objectName);
                [user.activityArray replaceObjectAtIndex:i withObject:activity];
            }
        }];
}

-(void)getActivityObjectRating:(NSInteger) i{
        activityClass *activity = [[activityClass alloc] init];
        activity = [user.activityArray objectAtIndex:i];
        
        [[[[firebaseRef.ref child:@"starRating"] child:@"stores"] child:activity.objectKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                NSArray *scores = [[NSArray alloc] init];
                scores = [snapshot.value allValues];
                activity.objectReviewCount = [[snapshot.value allValues] count];
                if ([scores count] > 0) {
                    for (id i in scores){
                        activity.objectRating = activity.objectRating + [i floatValue];
                    }
                }
                [user.activityArray replaceObjectAtIndex:i withObject:activity];
            }
        }];
}

-(void) getActivityDetails:(NSInteger) i{
        activityClass *activity = [[activityClass alloc] init];
        activity = [user.activityArray objectAtIndex:i];
    
    if ([activity.activityType isEqual:@"wroteReviewForStore"]) {
        [[[firebaseRef.ref child:@"activityInstantiationKey"] child:activity.activityKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            NSLog(@"5snapshot is %@",snapshot.value);

            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                NSString *reviewKey = [[snapshot.value allKeys] objectAtIndex:0];
                
                [[[firebaseRef.ref child:@"reviewMessage"] child:reviewKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                    NSLog(@"6snapshot is %@",snapshot.value);

                    if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                            activity.instantiationMessage = [[snapshot.value allValues] objectAtIndex:0];
                        
                        [[[firebaseRef.ref child:@"reviewRating"] child:reviewKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                            NSLog(@"7snapshot is %@",snapshot.value);

                            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                                activity.instantiationRating = [[snapshot.value allValues] objectAtIndex:0];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self.tableView reloadData];
                                });
                                [user.activityArray replaceObjectAtIndex:i withObject:activity];
                            }
                        }];
                    }
                }];
            }
        }];
    }
}

-(void) newLoadEventsFromFirebaseDatabse{
//    [self getActivityKeys];
    
    
//    NSLog(@"friend keys count is %lu", user.friendsKeys.count);
//    [_queriesArray removeAllObjects];
//    [objectsArray.eventObjectArray removeAllObjects];
//
//    for (int i = 0; i<[user.friendsKeys count]; i++) {
//        NSString *friendKey = [user.friendsKeys objectAtIndex:i];
//        
////        FIRDatabaseQuery *activityQuery = [[[firebaseRef.ref child:@"activityKey"] child:friendKey] queryLimitedToFirst:10];
//        [[[firebaseRef.ref child:@"activityKey"] child:friendKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//            if (snapshot.value == [NSNull null]) {
//                for (int i = 0; i < 10; i++) {
//                    [user.activityKeys addObject:[[snapshot.value allKeys] objectAtIndex:i]];
//                }
//            }
//        }];
    
//        FIRDatabaseQuery *eventQuery = [[firebaseRef.eventsRef queryOrderedByChild:@"userID"] queryEqualToValue:[user.friendsKeys objectAtIndex:i]];
//        [_queriesArray addObject:eventQuery];
////    }
//    for (int i = 0; i<user.activityKeys.count; i++) {
//        NSString *activityKey = [user.activityKeys objectAtIndex:i];
//        [[[firebaseRef.ref child:@"activityType"] child:activityKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//            if (snapshot.value != [NSNull null]) {
//                activityClass *activity = [[activityClass alloc] init];
//                [objectsArray.eventObjectArray removeAllObjects];
//                [_dict addEntriesFromDictionary:snapshot.value];
//                
//                NSArray *keys = [_dict allKeys];
//                NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
//                
//                for (id key in sortedKeys) {
//                    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
//                    NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
//                    value = [_dict valueForKey:key];
//                    [tempDict setObject:value forKey:key];
//                    
//                    NSString *dataString = [value valueForKey:@"userAvatarData"];
//                    NSString *dataString2 = [value valueForKey:@"objectData"];
//                    
//                    [[tempDict valueForKey:key] setObject:dataString forKey:@"userImageData"];
//                    [[tempDict valueForKey:key] setObject:dataString2 forKey:@"objectImageData"];
//                    
//                    [objectsArray.eventObjectArray addObject:tempDict];
//                    objectsArray.eventObjectArray = [NSMutableArray arrayWithArray:[[objectsArray.eventObjectArray reverseObjectEnumerator] allObjects]];
//                }
//                [self.tableView reloadData];
//
//            }
//        }];
//    }
//
    
//    for (int i = 0; i<_queriesArray.count; i++) {
//        [[_queriesArray objectAtIndex:i] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//            if (snapshot.value == [NSNull null]) {}
//            else{
//                [objectsArray.eventObjectArray removeAllObjects];
//                [_dict addEntriesFromDictionary:snapshot.value];
//                
//                NSArray *keys = [_dict allKeys];
//                NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
//                
//                for (id key in sortedKeys) {
//                    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
//                    NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
//                    value = [_dict valueForKey:key];
//                    [tempDict setObject:value forKey:key];
//                    
//                    NSString *dataString = [value valueForKey:@"userAvatarData"];
//                    NSString *dataString2 = [value valueForKey:@"objectData"];
//
//                    [[tempDict valueForKey:key] setObject:dataString forKey:@"userImageData"];
//                    [[tempDict valueForKey:key] setObject:dataString2 forKey:@"objectImageData"];
//                    
//                    [objectsArray.eventObjectArray addObject:tempDict];
//                    objectsArray.eventObjectArray = [NSMutableArray arrayWithArray:[[objectsArray.eventObjectArray reverseObjectEnumerator] allObjects]];
//                }
//                [self.tableView reloadData];
//            }
//        }];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

