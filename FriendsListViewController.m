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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.shyNavBarManager.scrollView = self.tableView;
    [self loadExtView];
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

- (void) loadExtView{
    extensionViewClass *extView = [[extensionViewClass alloc] init];
    [extView setView:CGRectGetWidth(self.view.bounds)];
    [extView addButtons:CGRectGetWidth(self.view.bounds)];
    [extView.newsFeedButton addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.searchFriendsButton addTarget:self action:@selector(searchFriendsButton:) forControlEvents:UIControlEventTouchUpInside];
    [extView.strainButton addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.storeButton addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.userProfileButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.shyNavBarManager setExtensionView:extView];
    [self.shyNavBarManager setStickyExtensionView:YES];
}

-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    [user goToNewsFeedViewController:self];
}

-(IBAction)searchFriendsButton:(UIButton*)btn {
    [user goToSearchViewController:self];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    objectsArray.selection = NO;
    [user goToStrainsViewController:self];
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    objectsArray.selection = YES;
    [user goToStoresViewController:self];
}

-(IBAction)userProfileButtonPressed:(UIButton*)btn {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToUserNotSignedInViewController:self];
    }
    else{
        [user goToCurrentUserProfileViewController:self];
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
