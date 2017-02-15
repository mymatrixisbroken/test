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
    user.friendsUsers = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i <user.friendsKeys.count; i++) {
        FIRDatabaseQuery *friendQuery = [[firebaseRef.usersRef queryOrderedByKey] queryEqualToValue:[user.friendsKeys objectAtIndex:i]];
        
        NSLog(@"friend is %@", [user.friendsKeys objectAtIndex:i]);
        findFriendClass *tempFriend = [[findFriendClass alloc] init];


        [friendQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            NSArray *arr = [snapshot.value allKeys];
            tempFriend.key = [arr objectAtIndex:0];
            NSDictionary *dictionary = [snapshot.value valueForKey:tempFriend.key];
            tempFriend.username = [dictionary valueForKey:@"username"];
            tempFriend.avatarDataString = [dictionary valueForKey:@"avatarData"];
            tempFriend.avatarData =  [[NSData alloc] initWithBase64EncodedString:tempFriend.avatarDataString options:0];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
            [user.friendsUsers addObject:tempFriend];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"array count is %lu", user.friendsUsers.count);
    return [user.friendsUsers count];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell{
    return YES;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:{
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            findFriendClass *friend = [user.friendsUsers objectAtIndex:cellIndexPath.row];

            [[[[firebaseRef.usersRef child:user.userKey] child:@"friends"] child:friend.key] removeValue];
            [[[[firebaseRef.usersRef child:friend.key] child:@"friends"] child:user.userKey] removeValue];

            [user.friendsKeys removeObject:friend.key];
            [user.friendsUsers removeObjectAtIndex:cellIndexPath.row];
            
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"userFriendCell";
    userFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (user.friendsUsers.count > 0) {
        findFriendClass *friend = [user.friendsUsers objectAtIndex:indexPath.row];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;

        cell.userFriendLabel.text = friend.username;
        cell.imageView.image = [UIImage imageWithData:friend.avatarData];
    }
    return cell;
}

@end
