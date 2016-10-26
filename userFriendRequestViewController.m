//
//  userFriendRequestViewController.m
//  myProject
//
//  Created by Guy on 10/18/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "userFriendRequestViewController.h"

@interface userFriendRequestViewController ()

@end

@implementation userFriendRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [user.friendRequestsIncomingUsers removeAllObjects];
    
    for (NSInteger i = 0; i <user.friendRequestsIncomingKeys.count; i++) {
        FIRDatabaseQuery *friendRequestQuery = [[firebaseRef.usersRef queryOrderedByKey] queryEqualToValue:[user.friendRequestsIncomingKeys objectAtIndex:i]];
        
        findFriendClass *friendRequestor = [[findFriendClass alloc] init];
        
        [friendRequestQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if (!([snapshot.value isEqual: @""])) {
                NSArray *arr = [snapshot.value allKeys];
                friendRequestor.key = [arr objectAtIndex:0];
                NSDictionary *dictionary = [snapshot.value valueForKey:friendRequestor.key];
                friendRequestor.username = [dictionary valueForKey:@"username"];
                friendRequestor.avatarDataString = [dictionary valueForKey:@"avatarData"];
                friendRequestor.avatarData =  [[NSData alloc] initWithBase64EncodedString:friendRequestor.avatarDataString options:0];


                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });

                [user.friendRequestsIncomingUsers addObject:friendRequestor];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [user.friendRequestsIncomingUsers count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"userFriendRequestCell";
    userFriendRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (user.friendRequestsIncomingUsers.count > 0) {
        NSLog(@"11array count is %lu", user.friendRequestsIncomingUsers.count);

        findFriendClass *friendRequestor = [user.friendRequestsIncomingUsers objectAtIndex:indexPath.row];
       
        cell.requestorImageView.image = [UIImage imageWithData:friendRequestor.avatarData];
        cell.requestorNameLabel.text = friendRequestor.username;
        
        cell.confirmButton.tag = indexPath.row;
    }
    
    return cell;

}


@end
