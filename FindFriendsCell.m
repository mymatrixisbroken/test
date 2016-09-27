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

    if ([user.friends indexOfObject:key] != NSNotFound) {
        self.addButton.selected = YES;
    }
}

- (IBAction)tappedButton:(id)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if (youser.email == nil) {
        //present a VC saying user not logged in
    }
    else {
        _addButton.selected = !_addButton.selected;
        if(_addButton.selected){
            [[[[firebaseRef.usersRef child:user.userKey] child:@"friends"] child:tempFriend.key] setValue:@"test"];
            
            [[[firebaseRef.usersRef child:user.userKey] child:@"friends"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                [user.friends removeAllObjects];
                NSArray *sortedKeys = [snapshot.value allKeys];
                user.friends = [NSMutableArray arrayWithArray:[sortedKeys sortedArrayUsingSelector:@selector(compare:)]];
            }];
            
            /*[user.friends addObject:tempFriend.key];
            NSArray *sortedKeys = [user.friends sortedArrayUsingSelector:@selector(compare:)];
            NSLog(@"user friends is %@",sortedKeys);*/
        }
        else{
            [[[[firebaseRef.usersRef child:user.userKey] child:@"friends"]  child:tempFriend.key] removeValue];
            [user.friends removeObject:tempFriend.key];
        }
    }
}

@end
