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
//    _array = [[NSMutableArray alloc] init];
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
            tempFriend.imageURL = [dictionary valueForKey:@"avatarURL"];
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSInteger length = [tempFriend.imageURL length];
                NSString *smallImageURL = [tempFriend.imageURL substringWithRange:NSMakeRange(0, length-4)];
                smallImageURL = [smallImageURL stringByAppendingString:@"t.jpg"];
                
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
                if( data == nil ){
                    NSLog(@"image is nil");
                    return;
                }
                else{
                    tempFriend.data = data;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            });
            [user.friendsUsers addObject:tempFriend];
//            [self.tableView reloadData];
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
//    [rightUtilityButtons sw_addUtilityButtonWithColor:
//     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
//                                                title:@"More"];
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
            NSLog(@"Delete button was pressed");
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            findFriendClass *friend = [user.friendsUsers objectAtIndex:cellIndexPath.row];
            NSLog(@"friend key is %@", friend.key);

            [[[[firebaseRef.usersRef child:user.userKey] child:@"friends"] child:friend.key] removeValue];
            [[[[firebaseRef.usersRef child:friend.key] child:@"friends"] child:user.userKey] removeValue];

            [user.friendsKeys removeObject:friend.key];
            [user.friendsUsers removeObjectAtIndex:cellIndexPath.row];
            
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];

            break;
        }
        case 1:
        {
//            // Delete button was pressed
//            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
//            
////            [_testArray removeObjectAtIndex:cellIndexPath.row];
//            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath]
//                                  withRowAnimation:UITableViewRowAnimationAutomatic];
//            break;
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
//        dispatch_async(dispatch_get_global_queue(0,0), ^{
//            NSInteger length = [friend.imageURL length];
//            NSString *smallImageURL = [friend.imageURL substringWithRange:NSMakeRange(0, length-4)];
//            smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];
//            
//            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
//            if( data == nil ){
//                NSLog(@"image is nil");
//                return;
//            }
//            else{
//                friend.data = data;
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
////                [self.tableView reloadData];
//            });
//        });
        
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;

        cell.userFriendLabel.text = friend.username;
        cell.imageView.image = [UIImage imageWithData:friend.data];
    }
    return cell;
}

@end
