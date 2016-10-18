//
//  userFriendsViewController.m
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "userFriendsViewController.h"

@interface userFriendsViewController ()

@end

@implementation userFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _array = [[NSMutableArray alloc] init];

    
    for (NSInteger i = 0; i <user.friends.count; i++) {
        FIRDatabaseQuery *friendQuery = [[firebaseRef.usersRef queryOrderedByKey] queryEqualToValue:[user.friends objectAtIndex:i]];
        
        NSLog(@"friend is %@", [user.friends objectAtIndex:i]);
        findFriendClass *tempFriend = [[findFriendClass alloc] init];


        [friendQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            NSArray *arr = [snapshot.value allKeys];
            NSString *key = [arr objectAtIndex:0];
            NSDictionary *dictionary = [snapshot.value valueForKey:key];
            tempFriend.username = [dictionary valueForKey:@"username"];
            tempFriend.imageURL = [dictionary valueForKey:@"avatarURL"];
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSInteger length = [tempFriend.imageURL length];
                NSString *smallImageURL = [tempFriend.imageURL substringWithRange:NSMakeRange(0, length-4)];
                smallImageURL = [smallImageURL stringByAppendingString:@"t.jpg"];
                
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
                if( data == nil ){
                    NSLog(@"image is nil");
                    return;
                }
                else{
                    tempFriend.data = data;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            });
            [_array addObject:tempFriend];
//            [self.tableView reloadData];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"array count is %lu", _array.count);
    return [_array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"userFriendCell";
    userFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (_array.count > 0) {
        findFriendClass *friend = [_array objectAtIndex:indexPath.row];
//        dispatch_async(dispatch_get_global_queue(0,0), ^{
//            NSInteger length = [friend.imageURL length];
//            NSString *smallImageURL = [friend.imageURL substringWithRange:NSMakeRange(0, length-4)];
//            smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];
//            
//            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
//            if( data == nil ){
//                NSLog(@"image is nil");
//                return;
//            }
//            else{
//                friend.data = data;
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
////                [self.tableView reloadData];
//            });
//        });
        
        cell.userFriendLabel.text = friend.username;
        cell.imageView.image = [UIImage imageWithData:friend.data];
    }
    return cell;
}

@end
