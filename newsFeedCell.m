//
//  newsFeedCell.m
//  myProject
//
//  Created by Guy on 9/14/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "newsFeedCell.h"

@implementation newsFeedCell

-(void) uploadCellWithUsername:(NSString *)username event:(NSString *)event imageURL:(NSString *)imageURL{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imageURL]];
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
    self.eventLabel.text = event;
    
    
    
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


}

@end
