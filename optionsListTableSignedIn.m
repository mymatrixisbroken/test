//
//  optionsListTableSignedIn.m
//  myProject
//
//  Created by Guy on 8/25/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "optionsListTableSignedIn.h"

@interface optionsListTableSignedIn ()

@end

@implementation optionsListTableSignedIn

- (void)viewDidLoad {
    [super viewDidLoad];
    _usernameLabel.text = user.username;
    _activityCountLabel.text = [NSString stringWithFormat: @"%ld",user.reviewsCount];
    _photoCountLabel.text = @"need to udpate";
//    _currentUser = [FIRAuth auth].currentUser;
//    
//    _sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    _vc = [_sb instantiateViewControllerWithIdentifier:@"Login View SB ID"];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    UIViewController *vc2 = [sb instantiateViewControllerWithIdentifier:@"Current User Profile VC SB ID"];
    vc2.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    UIViewController *vc3 = [sb instantiateViewControllerWithIdentifier:@"Add Store VC SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIViewController *vc4 = [sb instantiateViewControllerWithIdentifier:@"Add Strain VC SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:vc2 animated:false];
//            [self showDetailViewController:_vc sender:self];
//            [user goToCurrentUserProfileViewController:self.parentViewController];
//            NSLog(@"%@",self.parentViewController);
            break;
        case 1:
            user.mainNavigationSelected = 1;
            objectsArray.filterSelected = 10;
            objectsArray.strainOrStore = 0;
            [self.navigationController pushViewController:vc animated:false];
            break;
//            [user goToStrainsViewController:self];
//            [user gotoMapViewViewController:self];
        case 3:
            [self.navigationController pushViewController:vc3 animated:false];
            break;
        case 4:
            [self.navigationController pushViewController:vc4 animated:false];
            break;
        case 5:
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
