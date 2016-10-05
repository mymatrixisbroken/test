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
                         event:(NSString *)event
                          data:(NSData *)imageURL{    
    self.usernameLabel.text = username;
    self.eventLabel.text = event;
    self.image_View.image = [UIImage imageWithData:imageURL];

    
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];

    
    self.likeButton.tintColor = [UIColor colorWithHex:@"f7fafa"];
    self.commentsButton.tintColor = [UIColor colorWithHex:@"f7fafa"];

    NSString *text = @"Like";
    NSString *text1 = @"Comments";
    UIFont *font = [UIFont systemFontOfSize:14.0];
    UIColor *textColor = [UIColor colorWithHex:@"828587"];
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:text1 attributes:attributes];

    
    [self.likeButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    [self.commentsButton setAttributedTitle:attributedString1 forState:UIControlStateNormal];
    
    [self.likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)likeButtonPressed:(UIButton*)btn {
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSString *text = @"Like";
    UIFont *font = [UIFont systemFontOfSize:14.0];
    UIColor *textColor = [UIColor colorWithHex:@"828587"];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSBackgroundColorAttributeName];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    [self.likeButton setAttributedTitle:attributedString forState:UIControlStateNormal];

//    [firebaseRef.eventsRef child:(nonnull NSString *)];
}






@end
