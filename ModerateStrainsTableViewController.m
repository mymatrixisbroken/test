//
//  ModerateStrainsTableViewController.m
//  myProject
//
//  Created by Guy on 10/1/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "ModerateStrainsTableViewController.h"

@interface ModerateStrainsTableViewController ()

@end

@implementation ModerateStrainsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objectsArray.moderateStrainsObjectArray = [[NSMutableArray alloc] init];
    [self loadNavController];
    _strainKeys = [[NSArray alloc] init];
    [self getStrainKeys];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) getStrainKeys{
    //******************** Firebase get all store keys *************************//
    [[firebaseRef.ref child:@"toBeReviewedStrainNames"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            _strainKeys = [snapshot.value allKeys];
            NSLog(@"array keys is %@", _strainKeys);
            [self getStrainInformation];
        }
    }];
}

- (void) getStrainInformation{
    /* need to change from count to 20 items per page*/
    for (int i = 0; i < _strainKeys.count; i++){
        
        strainClass *myStrain = [[strainClass alloc] init];
        [objectsArray.moderateStrainsObjectArray addObject:myStrain];
        
        myStrain = [objectsArray.moderateStrainsObjectArray objectAtIndex:i];
        myStrain.strainKey = [_strainKeys objectAtIndex:i];
        [objectsArray.moderateStrainsObjectArray replaceObjectAtIndex:i withObject:myStrain];
        
        [self getStrainName: i];
        [self getStrainAddedByUser:i];
        [self getStrainFamily:i];
        [self getStrainCBD:i];
        [self getStrainTHC:i];
        [self getStrainCBN:i];
    }
}

- (void) getStrainName:(NSInteger) i {
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [objectsArray.moderateStrainsObjectArray objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"toBeReviewedStrainNames"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            myStrain.strainName = [snapshot.value valueForKey:@"name"];
            
            NSLog(@"object name is %@", myStrain.strainName);
            
            [objectsArray.moderateStrainsObjectArray replaceObjectAtIndex:i withObject:myStrain];
        }
    }];
}

- (void) getStrainAddedByUser:(NSInteger) i {
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [objectsArray.moderateStrainsObjectArray objectAtIndex:i];

    [[[firebaseRef.ref child:@"toBeReviewedStrainAddedByUser"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            myStrain.strainAddedByUser = [[snapshot.value allKeys] objectAtIndex:0];
            
            NSLog(@"object name is %@", myStrain.strainName);

            [objectsArray.moderateStrainsObjectArray replaceObjectAtIndex:i withObject:myStrain];
        }
    }];
}

- (void) getStrainFamily:(NSInteger) i {
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [objectsArray.moderateStrainsObjectArray objectAtIndex:i];

    [[[firebaseRef.ref child:@"toBeReviewedStrainFamily"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            
            myStrain.family = [snapshot.value valueForKey:@"family"];
            
            [objectsArray.moderateStrainsObjectArray replaceObjectAtIndex:i withObject:myStrain];
        }
    }];
}

- (void) getStrainCBD:(NSInteger) i {
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [objectsArray.moderateStrainsObjectArray objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"toBeReviewedCBD"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            myStrain.cbd = [snapshot.value valueForKey:@"cbd"];
            
            [objectsArray.moderateStrainsObjectArray replaceObjectAtIndex:i withObject:myStrain];
        }
    }];
}

- (void) getStrainTHC:(NSInteger) i {
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [objectsArray.moderateStrainsObjectArray objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"toBeReviewedTHC"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            myStrain.thc = [snapshot.value valueForKey:@"thc"];
            
            [objectsArray.moderateStrainsObjectArray replaceObjectAtIndex:i withObject:myStrain];
        }
    }];
}

- (void) getStrainCBN:(NSInteger) i {
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [objectsArray.moderateStrainsObjectArray objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"toBeReviewedCBN"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            myStrain.cbn = [snapshot.value valueForKey:@"cbn"];
            
            [objectsArray.moderateStrainsObjectArray replaceObjectAtIndex:i withObject:myStrain];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [objectsArray.moderateStrainsObjectArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [objectsArray.moderateStrainsObjectArray objectAtIndex:indexPath.row];
    
    
    NSString *cellIdentifier = @"moderateStrainCell";
    ModerateStrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.strainNameField.text = myStrain.strainName;
    cell.cbdField.text = myStrain.cbd;
    cell.thcField.text = myStrain.thc;
    cell.cbnField.text = myStrain.cbn;
    
    if ([myStrain.family isEqualToString:@"Indica"]) {
        cell.familyTypeSegment.selectedSegmentIndex = 0;
    } else if([myStrain.family isEqualToString:@"Sativa"]) {
        cell.familyTypeSegment.selectedSegmentIndex = 1;
    } else if([myStrain.family isEqualToString:@"Hybrid"]) {
        cell.familyTypeSegment.selectedSegmentIndex = 2;
    }
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
