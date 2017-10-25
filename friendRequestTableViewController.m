//
//  friendRequestTableViewController.m
//  myProject
//
//  Created by Guy on 10/21/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "friendRequestTableViewController.h"

@interface friendRequestTableViewController ()

@end

@implementation friendRequestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavController];
    _requestUsersArray = [[NSMutableArray alloc] init];
    
    for(NSString *inboundKey in user.friendRequestsIncomingKeys){
        userClass *otherUser = [[userClass alloc] init];
        otherUser.userKey = inboundKey;
        
        [_requestUsersArray addObject:otherUser];
    }
    
    [self getOtherUserInformation];
}

-(void) getOtherUserInformation{
//    for(userClass *otherUser in _requestUsersArray){
    for (int i = 0; i < [_requestUsersArray count]; i++) {
        userClass *otherUser = [[userClass alloc] init];
        otherUser = [_requestUsersArray objectAtIndex:i];
        
        [self getusername: i];
        [self getUserImages: i];
    }
}

- (void) getusername:(NSInteger) i{
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_requestUsersArray objectAtIndex:i];

    [[[firebaseRef.ref child:@"usernames"] child:otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            otherUser.username = [snapshot.value valueForKey:@"username"];
        }
        [_requestUsersArray replaceObjectAtIndex:i withObject:otherUser];
    }];
}

- (void) getUserImages:(NSInteger) i{
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_requestUsersArray objectAtIndex:i];

    [[[[firebaseRef.ref child:@"images"] child:@"users"] child:otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [otherUser.imageKeys addObject:key];
                [otherUser.imageLinks addObject:[snapshot.value valueForKey:key]];
            }
//            [self loadProfilePicture];
        }
        [_requestUsersArray replaceObjectAtIndex:i withObject:otherUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [user.friendRequestsIncomingKeys count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_requestUsersArray objectAtIndex:indexPath.row];

    NSString *cellIdentifier = @"friendRequestCell";
    friendRequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.tag = indexPath.row;
    cell.requestUsernameLabel.text = otherUser.username;
    
    cell.friendRequestImageView.layer.cornerRadius = cell.friendRequestImageView.frame.size.height /2;
    cell.friendRequestImageView.layer.masksToBounds = YES;
    cell.friendRequestImageView.layer.borderWidth = 0;

    
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];
    
    if ([otherUser.imageLinks count] > 0){                                      //check images array is null
        NSLog(@"image link is %@", [otherUser.imageLinks objectAtIndex:0]);
        FIRStorageReference *spaceRef = [[[storageRef child:@"users"] child:otherUser.userKey] child:[otherUser.imageLinks objectAtIndex:0]];
        NSLog(@"ref is %@", spaceRef);
        
        UIImage *placeHolder = [[UIImage alloc] init];
        [cell.friendRequestImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
    }

    [cell.acceptButton addTarget:self
                           action:@selector(tappedAcceptButton:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [cell.deleteButton addTarget:self
                          action:@selector(tappedDeleteButton:)
                forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (void) tappedAcceptButton:(UIButton *) button{
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
    [btn2 addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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

-(IBAction)strainButtonPressed:(UIButton*)btn {
    [user gotoMapViewViewController:self];
    
    //    user.mainNavigationSelected = 1;
    //    objectsArray.filterSelected = 10;
    //    objectsArray.strainOrStore = 0;
    //    [user goToStrainsViewController:self];
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
