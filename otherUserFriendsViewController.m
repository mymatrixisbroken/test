//
//  otherUserFriendsViewController.m
//  myProject
//
//  Created by Guy on 10/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "otherUserFriendsViewController.h"

@interface otherUserFriendsViewController ()

@end

@implementation otherUserFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _friendsArray = [[NSMutableArray alloc] init];
    
    
    for(NSString *friendKey in _otherUser2.friendsKeys){
        userClass *otherUser = [[userClass alloc] init];
        otherUser.userKey = friendKey;
        
        [_friendsArray addObject:otherUser];
    }
    
    [self getFriendInformation];
}

-(void) getFriendInformation{
    //    for(userClass *otherUser in _friendsArray){
    for (int i = 0; i < [_friendsArray count]; i++) {
        userClass *otherUser = [[userClass alloc] init];
        otherUser = [_friendsArray objectAtIndex:i];
        
        [self getusername: i];
        [self getFriendImages: i];
    }
}

- (void) getusername:(NSInteger) i{
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_friendsArray objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"usernames"] child:otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            otherUser.username = [snapshot.value valueForKey:@"username"];
        }
        [_friendsArray replaceObjectAtIndex:i withObject:otherUser];
    }];
}

- (void) getFriendImages:(NSInteger) i{
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_friendsArray objectAtIndex:i];
    
    [[[[firebaseRef.ref child:@"images"] child:@"users"] child:otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [otherUser.imageKeys addObject:key];
                [otherUser.imageLinks addObject:[snapshot.value valueForKey:key]];
            }
            //            [self loadProfilePicture];
        }
        [_friendsArray replaceObjectAtIndex:i withObject:otherUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_otherUser2.friendsKeys count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_friendsArray objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = @"userFriendCell";
    userFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.userFriendLabel.text = otherUser.username;
    
    cell.friendImageView.layer.cornerRadius = cell.friendImageView.frame.size.height /2;
    cell.friendImageView.layer.masksToBounds = YES;
    cell.friendImageView.layer.borderWidth = 0;
    
    
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];
    
    if ([otherUser.imageLinks count] > 0){                                      //check images array is null
        NSLog(@"image link is %@", [otherUser.imageLinks objectAtIndex:0]);
        FIRStorageReference *spaceRef = [[[storageRef child:@"users"] child:otherUser.userKey] child:[otherUser.imageLinks objectAtIndex:0]];
        NSLog(@"ref is %@", spaceRef);
        
        UIImage *placeHolder = [[UIImage alloc] init];
        [cell.friendImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    userClass *otherUser = [[userClass alloc] init];
    otherUser = [_friendsArray objectAtIndex:indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"User Profile VC SB ID"];
    vc.passedString = otherUser.username;
    [self.navigationController pushViewController:vc animated:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
