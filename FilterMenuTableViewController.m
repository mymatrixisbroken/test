//
//  TableViewController.m
//  myProject
//
//  Created by Guy on 3/6/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "FilterMenuTableViewController.h"

@interface FilterMenuTableViewController ()

@end

@implementation FilterMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _filterMenuCell.selectionStyle = UITableViewCellSelectionStyleNone;
    _filterMenuCell2.selectionStyle = UITableViewCellSelectionStyleNone;
    _filterMenuCell3.selectionStyle = UITableViewCellSelectionStyleNone;
    _filterMenuCell4.selectionStyle = UITableViewCellSelectionStyleNone;
    _filterMenuCell5.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _gradientMask = [CAGradientLayer layer];
    _gradientMask.frame = _filterMenuCell.frame;
    _gradientMask.colors = @[(id)[UIColor clearColor].CGColor,
                            (id)[UIColor colorWithRed:0.0/255.0 green:57.0/255.0 blue:47.0/255.0 alpha:1.0].CGColor];
    _gradientMask.startPoint = CGPointMake(0.0, 0.5);   // start at left middle
    _gradientMask.endPoint = CGPointMake(1.0, 0.5);     // end at right middle
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    switch (indexPath.row) {
        case 0:
            [_filterMenuCell.layer addSublayer:_gradientMask];
            break;
        case 1:
            [_filterMenuCell2.layer addSublayer:_gradientMask];
            break;
        case 2:
            [_filterMenuCell3.layer addSublayer:_gradientMask];
            break;
        case 3:
            [_filterMenuCell4.layer addSublayer:_gradientMask];
            break;
        case 4:
            [_filterMenuCell5.layer addSublayer:_gradientMask];
            break;
        default:
            break;
    }
    objectsArray.filterSelected = indexPath.row;
    [user goToStrainsStoresViewController:self];
}

@end
