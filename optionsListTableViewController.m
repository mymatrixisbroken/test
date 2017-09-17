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
    
//    _currentUser = [FIRAuth auth].currentUser;
//    
//    _sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//     _vc = [_sb instantiateViewControllerWithIdentifier:@"Login View SB ID"];
//    
//    if (!(_currentUser.anonymous)){
//        NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0] ;
//        NSIndexPath *cellIndexPath [self.tableView indexPathForCell:cell];
//        [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationNone];

//    }
//    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [viewController presentViewController:vc animated:YES completion:NULL];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 4;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        return 100;
//    }
//    return UITableViewAutomaticDimension;
//}


//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
//    switch (indexPath.row) {
//        case 1:
//            cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
//            cell.imageView.image = [UIImage imageNamed:@"mapIcon"];
//            cell.textLabel
//
//            break;
//            
//        default:
//            cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell" forIndexPath:indexPath];
//
//            break;
//    }
//    return cell;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = cell.frame;
//    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,
//                             (id)[UIColor colorWithRed:255.0/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gradientLayer.startPoint = CGPointMake(0.0, 0.5);   // start at left middle
//    gradientLayer.endPoint = CGPointMake(1.0, 0.5);     // end at right middle
//    UIView *bgColorView = [[UIView alloc] init];
//    [bgColorView.layer addSublayer:gradientLayer];
//    bgColorView.backgroundColor = [UIColor redColor];
//    
//    cell.selectedBackgroundView = bgColorView;

//    [cell high:bgColorView];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Strains View Controller SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    UIViewController *vc2 = [sb instantiateViewControllerWithIdentifier:@"Login View VC SB ID"];
    vc2.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:vc2 animated:false];
//            [user goToLoginViewController:self];
            break;
        case 1:
                user.mainNavigationSelected = 1;
                objectsArray.filterSelected = 10;
                objectsArray.strainOrStore = 0;
            
            [self.navigationController pushViewController:vc animated:false];
//            [user goToStrainsViewController:self];
            break;
        case 3:
            [self.navigationController pushViewController:vc2 animated:false];
            break;
        case 4:
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

@end
