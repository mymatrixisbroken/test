//
//  userFriendsViewController.m
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "userFriendsViewController.h"

@interface userFriendsViewController ()

@end

@implementation userFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _friendsArray = [[NSMutableArray alloc] init];

    
    for(NSString *friendKey in user.friendsKeys){
        userClass *otherUser = [[userClass alloc] init];
        otherUser.userKey = friendKey;
        
        [_friendsArray addObject:otherUser];
    }
    
    [self getFriendInformation];

//    user.friendsUsers = [[NSMutableArray alloc] init];
//
//    for (NSInteger i = 0; i <user.friendsKeys.count; i++) {
//        FIRDatabaseQuery *friendQuery = [[firebaseRef.usersRef queryOrderedByKey] queryEqualToValue:[user.friendsKeys objectAtIndex:i]];
//
//        NSLog(@"friend is %@", [user.friendsKeys objectAtIndex:i]);
//        findFriendClass *tempFriend = [[findFriendClass alloc] init];
//
//
//        [friendQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//            NSArray *arr = [snapshot.value allKeys];
//            tempFriend.key = [arr objectAtIndex:0];
//            NSDictionary *dictionary = [snapshot.value valueForKey:tempFriend.key];
//            tempFriend.username = [dictionary valueForKey:@"username"];
//            tempFriend.avatarDataString = [dictionary valueForKey:@"avatarData"];
//            tempFriend.avatarData =  [[NSData alloc] initWithBase64EncodedString:tempFriend.avatarDataString options:0];
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
//
//            [user.friendsUsers addObject:tempFriend];
//        }];
//    }
}

-(void) getFriendInformation{
    //    for(userClass *otherUser in _friendsArray){
    for (int i = 0; i < [_friendsArray count]; i++) {
        userClass *otherUser = [[userClass alloc] init];
        otherUser = [_friendsArray objectAtIndex:i];
        
        [self getusername: i];
        [self getFriendImages: i];
    }
}

- (void) getusername:(NSInteger) i{
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_friendsArray objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"usernames"] child:otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            otherUser.username = [snapshot.value valueForKey:@"username"];
        }
        [_friendsArray replaceObjectAtIndex:i withObject:otherUser];
    }];
}

- (void) getFriendImages:(NSInteger) i{
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_friendsArray objectAtIndex:i];
    
    [[[[firebaseRef.ref child:@"images"] child:@"users"] child:otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [otherUser.imageKeys addObject:key];
                [otherUser.imageLinks addObject:[snapshot.value valueForKey:key]];
            }
            //            [self loadProfilePicture];
        }
        [_friendsArray replaceObjectAtIndex:i withObject:otherUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [user.friendsKeys count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_friendsArray objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = @"userFriendCell";
    userFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.userFriendLabel.text = otherUser.username;
    
    cell.friendImageView.layer.cornerRadius = cell.friendImageView.frame.size.height /2;
    cell.friendImageView.layer.masksToBounds = YES;
    cell.friendImageView.layer.borderWidth = 0;
    
    
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];
    
    if ([otherUser.imageLinks count] > 0){                                      //check images array is null
        NSLog(@"image link is %@", [otherUser.imageLinks objectAtIndex:0]);
        FIRStorageReference *spaceRef = [[[storageRef child:@"users"] child:otherUser.userKey] child:[otherUser.imageLinks objectAtIndex:0]];
        NSLog(@"ref is %@", spaceRef);
        
        UIImage *placeHolder = [[UIImage alloc] init];
        [cell.friendImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
    }

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_friendsArray objectAtIndex:indexPath.row];

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"User Profile VC SB ID"];
    vc.passedString = otherUser.username;
    [self.navigationController pushViewController:vc animated:false];
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_friendsArray objectAtIndex:indexPath.row];

    UITableViewRowAction *button = [UITableViewRowAction
                                    rowActionWithStyle:UITableViewRowActionStyleDestructive
                                    title:@"Delete"
                                    handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        NSLog(@"Action to perform with Button 1");
                                        [_friendsArray removeObject:otherUser];
                                        [user.friendsKeys removeObject:otherUser.userKey];
                                        
                                        [[[[firebaseRef.ref child:@"friends"] child:user.userKey] child:otherUser.userKey] removeValue];
                                        [[[[firebaseRef.ref child:@"friends"] child:otherUser.userKey] child:user.userKey] removeValue];
                                        
                                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
                                    }];
    
    return @[button]; //array with all the buttons you want. 1,2,3, etc...
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // you need to implement this method too or nothing will work:
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES; //tableview must be editable or nothing will work...
}


//- (NSArray *)rightButtons
//{
//    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
//    [rightUtilityButtons sw_addUtilityButtonWithColor:
//     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
//                                                title:@"Delete"];
//
//    return rightUtilityButtons;
//}
//
//- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell{
//    return YES;
//}
//
//- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
//    switch (index) {
//        case 0:{
//            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
//            findFriendClass *friend = [user.friendsUsers objectAtIndex:cellIndexPath.row];
//
//            [[[[firebaseRef.usersRef child:user.userKey] child:@"friends"] child:friend.key] removeValue];
//            [[[[firebaseRef.usersRef child:friend.key] child:@"friends"] child:user.userKey] removeValue];
//
//            [user.friendsKeys removeObject:friend.key];
//            [user.friendsUsers removeObjectAtIndex:cellIndexPath.row];
//
//            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath]
//                                  withRowAnimation:UITableViewRowAnimationAutomatic];
//            break;
//        }
//        default:
//            break;
//    }
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *cellIdentifier = @"userFriendCell";
//    userFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//
//    if (user.friendsUsers.count > 0) {
//        findFriendClass *friend = [user.friendsUsers objectAtIndex:indexPath.row];
//        cell.rightUtilityButtons = [self rightButtons];
//        cell.delegate = self;
//
//        cell.userFriendLabel.text = friend.username;
//        cell.imageView.image = [UIImage imageWithData:friend.avatarData];
//    }
//    return cell;
//}

@end
