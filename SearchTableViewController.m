//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "SearchTableViewController.h"
@interface SearchTableViewController ()

@end

@implementation SearchTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"View Controller SB ID"];
            vc.cellSelected = indexPath.row;
            [self performSegueWithIdentifier:@"homepageToListSegue" sender:self];
            break;
        }
        case 1:
        {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"View Controller SB ID"];
            vc.cellSelected = indexPath.row;
            [self performSegueWithIdentifier:@"storeSelectionToListSegue" sender:self];
            break;
        }
        default:
            break;
    }

    /*if(indexPath.row == 0){
        NSLog(@"0 index select");
        _cellSelected = 0;
        [self performSegueWithIdentifier:@"homepageToListSegue" sender:self];
    }
    else if (indexPath.row ==1){
        NSLog(@"1 index select");
        _cellSelected = 1;
        [self performSegueWithIdentifier:@"storeSelectionToListSegue" sender:self];
    }*/
}

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"homepageToListSegue"]){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"View Controller SB ID"];
        NSLog(@"1 cell selected is %d", _cellSelected);

        vc.cellSelected = _cellSelected;
    }
    else if([segue.identifier isEqualToString:@"storeSelectionToListSegue"]){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"View Controller SB ID"];
        NSLog(@"2 cell selected is %d", _cellSelected);

        vc.cellSelected = _cellSelected;
    }

}
/*

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"homepageToListSegue"]){
        ViewController *vc = [segue destinationViewController];
        [vc setCellSelected:0];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"homepageToListSegue"]){
        ViewController *controller = (ViewController *)segue.destinationViewController;
        controller.cellSelected = _cellSelected;
    }
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
