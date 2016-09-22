//
//  findFriendClass.h
//  myProject
//
//  Created by Guy on 9/16/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class findFriendClass;
extern findFriendClass *tempFriend;

@interface findFriendClass : UITableViewCell
@property NSString *key;
@property NSString *username;
@property NSString *imageURL;
@property NSData *data;

+ (findFriendClass *)sharedInstance;
-(id)set:(NSString *)uid User:(NSString *)name image:(NSString *)url;

@end
