//
//  FindFriendsCell.m
//  myProject
//
//  Created by Guy on 9/16/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "FindFriendsCell.h"

@implementation FindFriendsCell

-(void) uploadCell:(NSString *)key WithUsername:(NSString *)username imageURL:(NSString *)imageURL :(NSData *)data{
    self.image_View.image = [UIImage imageWithData: data];
    self.usernameLabel.text = username;

    if ([user.friends indexOfObject:key] != NSNotFound) {
        self.addButton.selected = YES;
    }
}

- (IBAction)tappedButton:(id)sender {
    _addButton.selected = !_addButton.selected;
    if(self.addButton.selected){
        [[[[firebaseRef.usersRef child:user.user_key] child:@"friends"] child:tempFriend.key] setValue:@"test"];
        [[[firebaseRef.usersRef child:user.user_key] child:@"friends"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            [user.friends removeAllObjects];
            NSArray *sortedKeys = [snapshot.value allKeys];
            user.friends = [NSMutableArray arrayWithArray:[sortedKeys sortedArrayUsingSelector:@selector(compare:)]];
            NSLog(@"user friends is %@",user.friends);
        }];
        
        /*[user.friends addObject:tempFriend.key];
        NSArray *sortedKeys = [user.friends sortedArrayUsingSelector:@selector(compare:)];
        NSLog(@"user friends is %@",sortedKeys);*/
    }
    else{
        [[[[firebaseRef.usersRef child:user.user_key] child:@"friends"]  child:tempFriend.key] removeValue];
        [user.friends removeObject:tempFriend.key];
    }
}

@end
