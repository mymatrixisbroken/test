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
        objectsArray.userSearchObjectArray = [[NSMutableArray alloc] init];
        [self.tableView reloadData];
    }
    else{
        [self searchFirebaseForUsernames];
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [objectsArray.userSearchObjectArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"FindFriendsCell";
    FindFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
        [cell uploadCell:_friend.userKey
            withUsername:_friend.username
                    data:_friend.data];

    cell.addButton.tag = indexPath.row;

    return cell;
}

-(void) searchFirebaseForUsernames{
    NSInteger length = [_searchBar.text length] - 1;
    unichar c = [_searchBar.text characterAtIndex:length];
    c++;
    NSString *charIncrement = [NSString stringWithCharacters:&c length:1];
    NSString *endString = [_searchBar.text substringWithRange:NSMakeRange(0, length)];
    endString = [endString stringByAppendingString:charIncrement];
    
    NSLog(@"end string is %@", endString);
    
    FIRDatabaseQuery *usernamesQuery = [[[firebaseRef.usersRef queryOrderedByChild:@"username"] queryStartingAtValue:_searchBar.text] queryEndingAtValue:endString];

    [usernamesQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){
            objectsArray.userSearchObjectArray = [[NSMutableArray alloc] init];
            NSArray *keys = [snapshot.value allKeys];
            for(int i=0; i<keys.count ; i++){
                NSString *key = keys[i];
                NSDictionary *dict = [snapshot.value valueForKey:key];
                NSString *username = [dict valueForKey:@"username"];
                NSString *imageURL = [dict valueForKey:@"avatarURL"];
                
                _friend = [[userClass alloc] init];
                [_friend set:key user:username image:imageURL];
                
                
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
                        _friend.data = data;
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                });

                [objectsArray.userSearchObjectArray addObject:_friend];
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
