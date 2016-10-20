//
//  userFriendRequestCell.m
//  myProject
//
//  Created by Guy on 10/18/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "userFriendRequestCell.h"

@implementation userFriendRequestCell

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
            NSIndexPath *cellIndexPath = [(UITableView*)nextResponder indexPathForCell:self];
            [(UITableView*)nextResponder deleteRowsAtIndexPaths:@[cellIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];

        }
    }
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
            NSIndexPath *cellIndexPath = [(UITableView*)nextResponder indexPathForCell:self];
            [(UITableView*)nextResponder deleteRowsAtIndexPaths:@[cellIndexPath]
                                               withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
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
