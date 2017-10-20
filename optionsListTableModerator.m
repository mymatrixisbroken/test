//
//  optionsListTableModerator.m
//  myProject
//
//  Created by Guy on 9/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "optionsListTableModerator.h"

@interface optionsListTableModerator ()

@end

@implementation optionsListTableModerator

- (void)viewDidLoad {
    [super viewDidLoad];
    _usernameLabel.text = user.username;
    _activityCountLabel.text = [NSString stringWithFormat: @"%ld",user.reviewsCount];
    _photoCountLabel.text = @"need to udpate";
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Strains View Controller SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIViewController *vc2 = [sb instantiateViewControllerWithIdentifier:@"Current User Profile VC SB ID"];
    vc2.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIViewController *vc3 = [sb instantiateViewControllerWithIdentifier:@"Add Store VC SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    UIViewController *vc4 = [sb instantiateViewControllerWithIdentifier:@"Add Strain VC SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIViewController *vc5 = [sb instantiateViewControllerWithIdentifier:@"Moderate Stores VC SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIViewController *vc6 = [sb instantiateViewControllerWithIdentifier:@"Moderate Strains VC SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:vc2 animated:false];
            break;
        case 1:
            user.mainNavigationSelected = 1;
            objectsArray.filterSelected = 10;
            objectsArray.strainOrStore = 0;
            [self.navigationController pushViewController:vc animated:false];
            break;
        case 3:
            [self.navigationController pushViewController:vc3 animated:false];
            break;
        case 4:
            [self.navigationController pushViewController:vc4 animated:false];
            break;
        case 5:
            [self.navigationController pushViewController:vc5 animated:false];
            break;
        case 6:
            [self.navigationController pushViewController:vc6    animated:false];
            break;
        default:
            break;
    }
}

@end
