//
//  optionsListTableViewController.m
//  myProject
//
//  Created by Guy on 9/20/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "optionsListTableViewController.h"

@implementation optionsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentUser = [FIRAuth auth].currentUser;
}

//-(void) viewWillAppear:(BOOL)animated{
//    if (!(_currentUser.anonymous)) {
//        [self.tableView setContentOffset:CGPointMake(0, 44)];
//    }
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    switch (indexPath.row) {
        case 0:
            [user goToLoginViewController:self];
            break;
        case 3:
            [user goToSearchUsersViewController:self];
            break;
        default:
            break;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (!(_currentUser.anonymous)) {
//        if (section == 0) {
//            //header height for selected section
//            return 0.1;
//        } else {
//            //keeps all other Headers unaltered
//            return [super tableView:tableView heightForHeaderInSection:section];
//        }
//    }
//    else
//        return [super tableView:tableView heightForHeaderInSection:section];
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (!(_currentUser.anonymous)) {
//        if (section == 0) {
//            //header height for selected section
//            return 0.1;
//        } else {
//            // keeps all other footers unaltered
//            return [super tableView:tableView heightForFooterInSection:section];
//        }
//    }
//    else
//        return [super tableView:tableView heightForFooterInSection:section];
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (!(_currentUser.anonymous)) {
//        if (section == 0) { //Index number of interested section
//            if (0) {
//                return 0; //number of row in section when you click on hide
//            } else {
//                return 3; //number of row in section when you click on show (if it's higher than rows in Storyboard, app will crash)
//            }
//        }
//        else {
//            return [super tableView:tableView numberOfRowsInSection:section]; //keeps inalterate all other rows
//        }
//    }
//    else
//        return [super tableView:tableView numberOfRowsInSection:section]; //keeps inalterate all other rows
//}

@end
