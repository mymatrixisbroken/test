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
    
    _sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     _vc = [_sb instantiateViewControllerWithIdentifier:@"Login View SB ID"];
    
    if (!(_currentUser.anonymous)){
//        NSIndexPath *cellIndexPath [self.tableView indexPathForCell:cell];
        NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0] ;

        [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath]
                              withRowAnimation:UITableViewRowAnimationNone];

    }
//    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [viewController presentViewController:vc animated:YES completion:NULL];

}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//   
//    switch (indexPath.row) {
//        case 0:
////            [self showDetailViewController:_vc sender:self];
//
//            [user goToLoginViewController:self];
//            break;
//        case 3:
//            [user goToSearchUsersViewController:self];
//            break;
//        default:
//            break;
//    }
//}

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
