//
//  newsFeedCell.m
//  myProject
//
//  Created by Guy on 9/14/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "newsFeedCell.h"

@implementation newsFeedCell
-(void) uploadCellWithUsernameEventData:(eventClass *)tempEvent{
    self.usernameLabel.text = tempEvent.username;
    self.eventLabel.text = tempEvent.message;
    self.userImageView.image = [UIImage imageWithData:tempEvent.userImageData];
    
    self.strainNameLabel.text = tempEvent.objectName;
    self.strainRatingView.value = [tempEvent.objectRating integerValue];
    self.strainImageView.image = [UIImage imageWithData:tempEvent.objectData];
    
    self.likeButton.titleLabel.text = @"Like";
    self.commentsButton.titleLabel.text = @"Comments";
    
    [self.likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    if ([objectsArray.eventObjectArray indexOfObject:event.eventKey] != NSNotFound) {
        self.likeButton.selected = YES;
    }
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
