//
//  newsFeedCell.h
//  myProject
//
//  Created by Guy on 9/14/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsFeedCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image_View;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;

-(void) uploadCellWithUsername:(NSString *)username event:(NSString *)event imageURL:(NSString *)imageURL;

@end
