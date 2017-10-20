//
//  moderateStoreTableViewController.m
//  myProject
//
//  Created by Guy on 9/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "moderateStoreTableViewController.h"

@interface moderateStoreTableViewController ()

@end

@implementation moderateStoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objectsArray.moderateStoresObjectArray = [[NSMutableArray alloc] init];
    [self loadNavController];
    _storeKeys = [[NSArray alloc] init];
    [self getStoreKeys];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) getStoreKeys{
    //******************** Firebase get all store keys *************************//
    [[firebaseRef.ref child:@"toBeReviewedStoreNames"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            _storeKeys = [snapshot.value allKeys];
            NSLog(@"array keys is %@", _storeKeys);
            [self getStoreInformation];
        }
    }];
}

- (void) getStoreInformation{
    /* need to change from count to 20 items per page*/
    for (int i = 0; i < _storeKeys.count; i++){
        
        storeClass *myStore = [[storeClass alloc] init];
        [objectsArray.moderateStoresObjectArray addObject:myStore];
        
        myStore = [objectsArray.moderateStoresObjectArray objectAtIndex:i];
        myStore.storeKey = [_storeKeys objectAtIndex:i];
        [objectsArray.moderateStoresObjectArray replaceObjectAtIndex:i withObject:myStore];
        
        [self getStoreName: i];
        [self getStoreAddedByUser:i];
        [self getStoreLocation:i];
        [self getStorePhoneNumber:i];
//        [self getStoreHours:i];
    }
}

- (void) getStoreName:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.moderateStoresObjectArray objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"toBeReviewedStoreNames"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            myStore.storeName = [snapshot.value valueForKey:@"name"];
            
            NSLog(@"object name is %@", myStore.storeName);
            
            [objectsArray.moderateStoresObjectArray replaceObjectAtIndex:i withObject:myStore];
        }
    }];
}

- (void) getStoreAddedByUser:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.moderateStoresObjectArray objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"toBeReviewedStoreAddedByUser"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            myStore.storeAddedByUser = [[snapshot.value allKeys] objectAtIndex:0];
            
            NSLog(@"object name is %@", myStore.storeName);
            
            [objectsArray.moderateStoresObjectArray replaceObjectAtIndex:i withObject:myStore];
        }
    }];
}

- (void) getStoreLocation:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.moderateStoresObjectArray objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"toBeReviewedLocation"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null

            myStore.address = [snapshot.value valueForKey:@"address"];
            myStore.city = [snapshot.value valueForKey:@"cityStateZip"];
            myStore.latitude = [snapshot.value valueForKey:@"latitude"];
            myStore.longitude = [snapshot.value valueForKey:@"longitude"];
            
            [objectsArray.moderateStoresObjectArray replaceObjectAtIndex:i withObject:myStore];
        }
    }];
}

- (void) getStorePhoneNumber:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.moderateStoresObjectArray objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"toBeReviewedPhoneNumbers"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            myStore.phone_number = [snapshot.value valueForKey:@"phoneNumber"];
            
            [objectsArray.moderateStoresObjectArray replaceObjectAtIndex:i withObject:myStore];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });

        }
    }];
}

//- (void) getStoreHours:(NSInteger) i {
//    storeClass *myStore = [[storeClass alloc] init];
//    myStore = [objectsArray.storeObjectArray objectAtIndex:i];
//    
//    [[[firebaseRef.ref child:@"toBeReviewedStoreHours"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            myStore.hour = [snapshot.value valueForKey:@"address"];
//            
//            [objectsArray.moderateStoresObjectArray replaceObjectAtIndex:i withObject:myStore];
//        }
//    }];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [objectsArray.moderateStoresObjectArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.moderateStoresObjectArray objectAtIndex:indexPath.row];

    
    NSString *cellIdentifier = @"moderateStoreCell";
    moderateStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.storeName.text = myStore.storeName;
    cell.address.text = myStore.address;
    cell.cityStateZip.text = myStore.city;
    cell.phoneNumber.text = myStore.phone_number;
//    cell.storeHours.text = myStore.;
    
    [cell.approveButton addTarget:self
                       action:@selector(tappedApproveButton:)
             forControlEvents:UIControlEventTouchUpInside];
    
    [cell.deleteButton addTarget:self
                      action:@selector(tappedDeleteButton:)
            forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}

- (void) tappedApproveButton:(UIButton *) button{
    [self.tableView reloadData];
}
- (void) tappedDeleteButton:(UIButton *) button{
    [self.tableView reloadData];
}

- (void) loadNavController{
    
    UIButton *btn1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,0,25,25);
    [btn1 setBackgroundImage:[UIImage imageNamed:@"newsFeedWhiteIcon"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonOne = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    
    UIButton *btn2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0,0,25,25);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"mapWhiteIcon"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(mapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonTwo = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    
    UIButton *btn3 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0,0,25,25);
    [btn3 setBackgroundImage:[UIImage imageNamed:@"searchWhiteIcon"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonThree = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    
    UIButton *btn4 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0,0,25,25);
    [btn4 setBackgroundImage:[UIImage imageNamed:@"storesWhiteIcon"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonFour = [[UIBarButtonItem alloc] initWithCustomView:btn4];
    
    
    UIButton *btn5 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(0,0,25,25);
    [btn5 setBackgroundImage:[UIImage imageNamed:@"hamburgerWhiteIcon"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(barButtonCustomPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonFive = [[UIBarButtonItem alloc] initWithCustomView:btn5];
    
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    space.width = 55;

    NSArray *buttons = @[buttonOne, space, buttonTwo, space, buttonThree, space, buttonFour, space, buttonFive];
    
    self.navigationController.navigationBar.topItem.title = nil;
    self.navigationController.navigationBar.topItem.leftBarButtonItems = buttons;
}

-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 0;
    [user goToNewsFeedViewController:self];
}

-(IBAction)mapButtonPressed:(UIButton*)btn {
    [user gotoMapViewViewController:self];
}

-(IBAction)searchButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 2;
    [user goToSearchViewController:self];
}


-(IBAction)userProfileButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 2;
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToUserNotSignedInViewController:self];
    }
    else{
        [user goToCurrentUserProfileViewController:self];
    }
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 3;
    objectsArray.filterSelected = 10;
    objectsArray.strainOrStore = 1;
    [user goToStrainsStoresViewController:self];
}


-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    FIRUser *currentUser = [FIRAuth auth].currentUser;
    if(currentUser.anonymous){
        [user gotoOptionListViewController:self];
        
    } else {
        [user gotoOptionListSignedInViewController:self];
    }
}

@end
