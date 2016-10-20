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
            [self.addButton setTitle:@"Pending" forState:UIControlStateSelected];
            
            [[[[firebaseRef.usersRef child:friend.userKey] child:@"friendRequestsIncoming"] child:user.userKey] setValue:@"test"];
            [[[[firebaseRef.usersRef child:user.userKey] child:@"friendRequestsOutgoing"] child:friend.userKey] setValue:@"test"];
        }
        else{
            [self.addButton setTitle:@"Add +" forState:UIControlStateNormal];

            [[[[firebaseRef.usersRef child:friend.userKey] child:@"friendRequestsIncoming"] child:user.userKey] removeValue];
            [[[[firebaseRef.usersRef child:user.userKey] child:@"friendRequestsOutgoing"] child:friend.userKey] removeValue];
        }
    }
}

@end
