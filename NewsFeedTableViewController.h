//
//  NewsFeedTableViewController.h
//  myProject
//
//  Created by Guy on 9/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"
#import "userClass.h"
#import "newsFeedCell.h"
#import "FirebaseReferenceClass.h"
#import "UIColor+Hexadecimal.h"


@interface NewsFeedTableViewController : UITableViewController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end
