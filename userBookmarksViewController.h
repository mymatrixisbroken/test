//
//  userBookmarksViewController.h
//  myProject
//
//  Created by Guy on 10/23/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userBookmarkTableViewCell.h"
#import "userClass.h"
#import "bookmarkClass.h"
#import "FirebaseReferenceClass.h"
#import "imageClass.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
@import Firebase;

@interface userBookmarksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *bookmarks;
@property UIActivityIndicatorView *spinner;

@end
