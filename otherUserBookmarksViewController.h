//
//  otherUserBookmarksViewController.h
//  myProject
//
//  Created by Guy on 10/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userBookmarkTableViewCell.h"
#import "userClass.h"
#import "bookmarkClass.h"
#import "FirebaseReferenceClass.h"
#import "imageClass.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
#import <UIKit/UIKit.h>

@interface otherUserBookmarksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property NSMutableArray *bookmarks;
@property UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet userClass *otherUser;

@end
