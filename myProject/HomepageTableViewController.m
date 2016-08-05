//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "HomepageTableViewController.h"
@interface HomepageTableViewController ()

@end

@implementation HomepageTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"homepageToListSegue" sender:self];
    }
    else if (indexPath.row ==1){
        _cellSelected = 1;
        [self performSegueWithIdentifier:@"homepageToListSegue" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"homepageToListSegue"]){
        ViewController *controller = (ViewController *)segue.destinationViewController;
        controller.cellSelected = _cellSelected;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
