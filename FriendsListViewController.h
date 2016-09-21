//
//  SecondViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import "extensionViewClass.h"
#import "FirebaseReferenceClass.h"
#import "FindFriendsCell.h"
#import "findFriendClass.h"
#import "userClass.h"
#import "objectsArrayClass.h"
@import Firebase;

@interface FriendsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchController *searchController;
@property (strong, nonatomic) IBOutlet NSMutableArray *friendsArray;
@property (nonatomic, strong) findFriendClass *puto;
@property BOOL isFiltered;


@end

