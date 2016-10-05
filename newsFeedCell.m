//
//  newsFeedCell.m
//  myProject
//
//  Created by Guy on 9/14/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "newsFeedCell.h"

@implementation newsFeedCell

-(void) uploadCellWithUsername:(NSString *)username
                         event:(NSString *)message
                          data:(NSData *)imageURL{
    self.usernameLabel.text = username;
    self.eventLabel.text = message;
    self.image_View.image = [UIImage imageWithData:imageURL];

    self.likeButton.titleLabel.text = @"Like";
    self.commentsButton.titleLabel.text = @"Comments";
    
    [self.likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)likeButtonPressed:(UIButton*)btn {
    event.eventKey = [[[objectsArray.eventObjectArray objectAtIndex:self.likeButton.tag] allKeys] objectAtIndex:0];
    self.likeButton.selected = !self.likeButton.selected;
    
    if(self.likeButton.selected){
        NSLog(@"event key is %@", event.eventKey);
        [[[[firebaseRef.eventsRef child:event.eventKey] child:@"likes"] child:user.userKey] setValue:user.username];
    }
    else{
        [[[[firebaseRef.eventsRef child:event.eventKey] child:@"likes"] child:user.userKey] removeValue];
    }
}
@end
