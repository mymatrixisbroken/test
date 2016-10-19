//
//  userFriendRequestCell.m
//  myProject
//
//  Created by Guy on 10/18/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "userFriendRequestCell.h"

@implementation userFriendRequestCell

//-(void) uploadCell:(NSString *)key
//      withUsername:(NSString *)username
//              data:(NSData *)data{
//    [_imageview setImage:[UIImage imageWithData: data]];
//    _usernameLabel.text = username;
//    
//    if ([user.friends indexOfObject:key] != NSNotFound) {
//        self.addButton.selected = YES;
//    }
//}

- (IBAction)tappedConfirmButton:(id)sender {
    findFriendClass *friend = [[findFriendClass alloc] init];
    friend = [user.friendRequestsIncomingUsers objectAtIndex:self.confirmButton.tag];
    
    [[[[firebaseRef.usersRef child:friend.key] child:@"friends"] child:user.userKey] setValue:@"test"];
    [[[[firebaseRef.usersRef child:user.userKey] child:@"friends"] child:friend.key] setValue:@"test"];

    [[[firebaseRef.usersRef child:user.userKey] child:@"friends"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        [user.friendsKeys removeAllObjects];
        NSArray *sortedKeys = [snapshot.value allKeys];
        user.friendsKeys = [NSMutableArray arrayWithArray:[sortedKeys sortedArrayUsingSelector:@selector(compare:)]];
    }];
    
    [[[[firebaseRef.usersRef child:user.userKey] child:@"friendRequestsIncoming"] child:friend.key] removeValue];
    [[[[firebaseRef.usersRef child:friend.key] child:@"friendRequestsOutgoing"] child:user.userKey] removeValue];
    
    [user.friendRequestsIncomingUsers removeObject:friend];
    [user.friendRequestsIncomingKeys removeObject:friend.key];
    
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableView class]])
        {
//            [(UIViewController*)nextResponder viewDidLoad];
//            [(UITableView*)nextResponder reloadData];
            NSIndexPath *cellIndexPath = [(UITableView*)nextResponder indexPathForCell:self];
            [(UITableView*)nextResponder deleteRowsAtIndexPaths:@[cellIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];

        }
    }

    
//    NSLog(@"keys are %@", user.friendRequestsKeys);

    
//            [[[[firebaseRef.usersRef child:friend.userKey] child:@"friendRequests"] child:user.userKey] setValue:@"test"];
            
            
            /*[user.friends addObject:tempFriend.key];
             NSArray *sortedKeys = [user.friends sortedArrayUsingSelector:@selector(compare:)];
             NSLog(@"user friends is %@",sortedKeys);*/
}

- (IBAction)tappedDeleteButton:(id)sender {
    findFriendClass *friend = [[findFriendClass alloc] init];
    friend = [user.friendRequestsIncomingUsers objectAtIndex:self.confirmButton.tag];

    [[[[firebaseRef.usersRef child:user.userKey] child:@"friendRequestsIncoming"] child:friend.key] removeValue];
    [[[[firebaseRef.usersRef child:friend.key] child:@"friendRequestsOutgoing"] child:user.userKey] removeValue];
    
    [user.friendRequestsIncomingUsers removeObject:friend];
    [user.friendRequestsIncomingKeys removeObject:friend.key];
    
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableView class]])
        {
//            [(UIViewController*)nextResponder viewDidLoad];
//            [(UITableView*)nextResponder reloadData];
            NSIndexPath *cellIndexPath = [(UITableView*)nextResponder indexPathForCell:self];
            [(UITableView*)nextResponder deleteRowsAtIndexPaths:@[cellIndexPath]
                                               withRowAnimation:UITableViewRowAnimationAutomatic];


        }
    }

//    NSLog(@"11keys are %@", user.friendRequestsKeys);



    //            [[[[firebaseRef.usersRef child:user.userKey] child:@"friends"]  child:friend.userKey] removeValue];
    //            [user.friends removeObject:friend.userKey];

//    [[[[firebaseRef.usersRef child:friend.userKey] child:@"friendRequests"] child:user.userKey] removeValue];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
