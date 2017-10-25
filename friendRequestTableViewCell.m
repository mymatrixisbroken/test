//
//  friendRequestTableViewCell.m
//  myProject
//
//  Created by Guy on 10/21/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "friendRequestTableViewCell.h"

@implementation friendRequestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [_acceptButton addTarget:self
                       action:@selector(tappedAcceptButton:)
             forControlEvents:UIControlEventTouchUpInside];
    
    [_deleteButton addTarget:self
                      action:@selector(tappedDeleteButton:)
            forControlEvents:UIControlEventTouchUpInside];
    
    // Initialization code
}

- (void) tappedAcceptButton:(UIButton *) button{
    NSLog(@"tag is %ld", (long)self.tag);
    
    NSString *otherUserKey = [user.friendRequestsIncomingKeys objectAtIndex:self.tag];
    
    NSLog(@"key is %@", [user.friendRequestsIncomingKeys objectAtIndex:self.tag]);
    
    [[[[firebaseRef.ref child:@"friends"] child:user.userKey] child:otherUserKey] setValue:@"test"];
    [[[[firebaseRef.ref child:@"friends"] child:otherUserKey] child:user.userKey] setValue:@"test"];
    
    [[[[firebaseRef.ref child:@"friendRequestInbound"] child:user.userKey] child:otherUserKey] removeValue];
    [[[[firebaseRef.ref child:@"friendRequestOutbound"] child:otherUserKey] child:user.userKey] removeValue];

    [user.friendRequestsIncomingKeys removeObjectAtIndex:self.tag];
}

- (void) tappedDeleteButton:(UIButton *) button{
    NSString *otherUserKey = [user.friendRequestsIncomingKeys objectAtIndex:self.tag];

    [[[[firebaseRef.ref child:@"friendRequestInbound"] child:user.userKey] child:otherUserKey] removeValue];
    [[[[firebaseRef.ref child:@"friendRequestOutbound"] child:otherUserKey] child:user.userKey] removeValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
