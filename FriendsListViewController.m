//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "FriendsListViewController.h"

@interface FriendsListViewController ()

@end

@implementation FriendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.delegate = self;
    _searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    

    
    self.navigationController.navigationBar.topItem.titleView = _searchBar;


    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchBar.text.length == 0){
        [_searchArray removeAllObjects];
        [self.tableView reloadData];
    }
    else{
        [self searchFirebaseForUsernames];
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_searchArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"FindFriendsCell";
    FindFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    for(int i=1; i<=[_searchArray count]; i++){
        tempFriend = [findFriendClass sharedInstance];
        tempFriend = [_searchArray objectAtIndex:indexPath.row];
        
        [cell uploadCell:tempFriend.key
            withUsername:tempFriend.username
                    data:tempFriend.data];
    }
    return cell;
}

-(void) searchFirebaseForUsernames{
    NSInteger length = [_searchBar.text length] - 1;
    unichar c = [_searchBar.text characterAtIndex:length];
    c++;
    NSString *charIncrement = [NSString stringWithCharacters:&c length:1];
    NSString *endString = [_searchBar.text substringWithRange:NSMakeRange(0, length)];
    endString = [endString stringByAppendingString:charIncrement];    
    
    FIRDatabaseQuery *usernamesQuery = [[[firebaseRef.usersRef queryOrderedByChild:@"username"] queryStartingAtValue:_searchBar.text] queryEndingAtValue:endString];

    [usernamesQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){
            _searchArray = [[NSMutableArray alloc] init];
            NSArray *keys = [snapshot.value allKeys];
            for(int i=0; i<keys.count ; i++){
                NSString *key = keys[i];
                NSDictionary *dict = [snapshot.value valueForKey:key];
                NSString *username = [dict valueForKey:@"username"];
                NSString *imageURL = [dict valueForKey:@"avatarURL"];
                
                findFriendClass *friend = [[findFriendClass alloc] init];
                [friend set:key user:username image:imageURL];
                
                
                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    NSInteger length = [imageURL length];
                    NSString *smallImageURL = [imageURL substringWithRange:NSMakeRange(0, length-4)];
                    smallImageURL = [smallImageURL stringByAppendingString:@"b.jpg"];
                    
                    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
                    if( data == nil ){
                        NSLog(@"image is nil");
                        return;
                    }
                    else{
                        friend.data = data;
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                });

                [_searchArray addObject:friend];
                [self.tableView reloadData];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
