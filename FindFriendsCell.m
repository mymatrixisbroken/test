//
//  FindFriendsCell.m
//  myProject
//
//  Created by Guy on 9/16/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "FindFriendsCell.h"

@implementation FindFriendsCell

-(void) uploadCell:(NSString *)key
      withUsername:(NSString *)username
              data:(NSData *)data{
    [_imageview setImage:[UIImage imageWithData: data]];
    _usernameLabel.text = username;
    
//    NSLog(@"out keys are %@", user.friendRequestsOutgoingKeys);
//    NSLog(@"key is  %@", key);
    
    self.addButton.selected = NO;

    if ([user.friendRequestsOutgoingKeys indexOfObject:key] != NSNotFound) {
        self.addButton.selected = YES;
            [self.addButton setTitle:@"Pending" forState:UIControlStateSelected];
            [self.addButton setTitle:@"Add +" forState:UIControlStateNormal];
    }
}

- (IBAction)tappedButton:(id)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if (youser.email == nil) {
        //present a VC saying user not logged in
    }
    else {
        _addButton.selected = !_addButton.selected;
        userClass *friend = [[userClass alloc] init];
        friend = [objectsArray.userSearchObjectArray objectAtIndex:self.addButton.tag];

        if(_addButton.selected){
//            [[[[firebaseRef.usersRef child:user.userKey] child:@"friends"] child:friend.userKey] setValue:@"test"];
//            
//            [[[firebaseRef.usersRef child:user.userKey] child:@"friends"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//                [user.friends removeAllObjects];
//                NSArray *sortedKeys = [snapshot.value allKeys];
//                user.friends = [NSMutableArray arrayWithArray:[sortedKeys sortedArrayUsingSelector:@selector(compare:)]];
//            }];
            
            [self.addButton setTitle:@"Pending" forState:UIControlStateSelected];
//            self.addButton.titleLabel.text = @"Pending";
            
            [[[[firebaseRef.usersRef child:friend.userKey] child:@"friendRequestsIncoming"] child:user.userKey] setValue:@"test"];
            [[[[firebaseRef.usersRef child:user.userKey] child:@"friendRequestsOutgoing"] child:friend.userKey] setValue:@"test"];

            
            /*[user.friends addObject:tempFriend.key];
            NSArray *sortedKeys = [user.friends sortedArrayUsingSelector:@selector(compare:)];
            NSLog(@"user friends is %@",sortedKeys);*/
        }
        else{
            [self.addButton setTitle:@"Add +" forState:UIControlStateNormal];

//            self.addButton.titleLabel.text = @"Add +";

            [[[[firebaseRef.usersRef child:friend.userKey] child:@"friendRequestsIncoming"] child:user.userKey] removeValue];
            [[[[firebaseRef.usersRef child:user.userKey] child:@"friendRequestsOutgoing"] child:friend.userKey] removeValue];

//            [[[[firebaseRef.usersRef child:user.userKey] child:@"friends"]  child:friend.userKey] removeValue];
//            [user.friends removeObject:friend.userKey];
        }
    }
}

@end
