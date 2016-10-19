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
//    _array = [[NSMutableArray alloc] init];
    
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
                friendRequestor.imageURL = [dictionary valueForKey:@"avatarURL"];
                
                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    NSInteger length = [friendRequestor.imageURL length];
                    NSString *smallImageURL = [friendRequestor.imageURL substringWithRange:NSMakeRange(0, length-4)];
                    smallImageURL = [smallImageURL stringByAppendingString:@"t.jpg"];
                    
                    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
                    if( data == nil ){
                        NSLog(@"image is nil");
                        return;
                    }
                    else{
                        friendRequestor.data = data;
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                });
                [user.friendRequestsIncomingUsers addObject:friendRequestor];
                //            [self.tableView reloadData];
            }
        }];
    }
    // Do any additional setup after loading the view.
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
       
        cell.requestorImageView.image = [UIImage imageWithData:friendRequestor.data];
        cell.requestorNameLabel.text = friendRequestor.username;
        
        cell.confirmButton.tag = indexPath.row;
    }

//    [cell uploadCell:_friend.userKey
//        withUsername:_friend.username
//                data:_friend.data];
    
//    cell.addButton.tag = indexPath.row;
    
    return cell;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
