//
//  FindFriendsCell.m
//  myProject
//
//  Created by Guy on 9/16/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "FindFriendsCell.h"

@implementation FindFriendsCell

-(void) uploadCellWithUsername:(NSString *)username imageURL:(NSString *)imageURL{
    NSInteger length = [imageURL length];
    NSString *smallImageURL = [imageURL substringWithRange:NSMakeRange(0, length-4)];
    smallImageURL = [smallImageURL stringByAppendingString:@"b.jpg"];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
        if( data == nil ){
            NSLog(@"image is nil");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            self.image_View.image = [UIImage imageWithData: data];
        });
    });
    
    self.usernameLabel.text = username;
}
- (IBAction)tappedButton:(id)sender {
    _addButton.selected = !_addButton.selected;
    if(self.addButton.selected){
        [[[[firebaseRef.usersRef child:user.user_key] child:@"friends"] child:tempFriend.key] setValue:@"test"];
    }
    else{
        [[[[firebaseRef.usersRef child:user.user_key] child:@"friends"]  child:tempFriend.key] removeValue];
    }
}

@end
