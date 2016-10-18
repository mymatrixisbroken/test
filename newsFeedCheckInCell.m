//
//  NewsFeedCheckInCell.m
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "NewsFeedCheckInCell.h"

@implementation newsFeedCheckInCell

//-(void) uploadCellWithUsername:(NSString *)username
//                         event:(NSString *)message
//                          data:(NSData *)imageURL{
//    self.usernameLabel.text = username;
//    self.eventLabel.text = message;
//    self.userImageView.image = [UIImage imageWithData:imageURL];
//    
//    self.likesButton.titleLabel.text = @"Like";
//    self.commentsButton.titleLabel.text = @"Comments";
//    
//    [self.likesButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //    event.eventKey = [[[objectsArray.eventObjectArray objectAtIndex:self.likeButton.tag] allKeys] objectAtIndex:0];
//    
//    if ([objectsArray.eventObjectArray indexOfObject:event.eventKey] != NSNotFound) {
//        self.likesButton.selected = YES;
//    }
//    
//}

-(void) uploadCellWithUsernameEventData:(eventClass *)tempEvent{
    self.usernameLabel.text = tempEvent.username;
    self.eventLabel.text = tempEvent.message;
    self.userImageView.image = [UIImage imageWithData:tempEvent.userImageData];
    
    self.storeNameLabel.text = tempEvent.objectName;
    self.storeRatingView.value = [tempEvent.objectRating integerValue];
    self.storeImageView.image = [UIImage imageWithData:tempEvent.objectData];
    
    self.likeButton.titleLabel.text = @"Like";
    self.commentsButton.titleLabel.text = @"Comments";
    
    [self.likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //    event.eventKey = [[[objectsArray.eventObjectArray objectAtIndex:self.likeButton.tag] allKeys] objectAtIndex:0];
    
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
