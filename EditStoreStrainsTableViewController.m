//
//  EditStoreStrainsTableViewController.m
//  myProject
//
//  Created by Guy on 10/8/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "EditStoreStrainsTableViewController.h"

@interface EditStoreStrainsTableViewController ()

@end

@implementation EditStoreStrainsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [_editStrainListButton addTarget:self
                         action:@selector(tappedEditStrains:)
               forControlEvents:UIControlEventTouchUpInside];
}

-(void) tappedEditStrains:(UIButton *) button{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    searchStrainsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Search Strain Navigation ID"];
    [self.navigationController pushViewController:vc animated:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"store reviews count %lu", store.hasStrainsArray.count);
    return [store.hasStrainsArray count];
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    strainClass *tempStrain = [[strainClass alloc] init];
    tempStrain = [store.hasStrainsArray objectAtIndex:indexPath.row];
    
    NSLog(@"strain has store name is %@", tempStrain.strainName);
    NSString *cellIdentifier = @"StoreStrainCell";
    StoreStrainsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.strainImageView.layer.cornerRadius = cell.strainImageView.frame.size.height /2;
    cell.strainImageView.layer.masksToBounds = YES;
    cell.strainImageView.layer.borderWidth = 0;
    
    
    cell.strainNameLabel.text = tempStrain.strainName;
    cell.strainFamilyLabel.text = tempStrain.family;
    cell.strainRatingView.value = tempStrain.ratingScore;
    cell.strainReviewCount.text = [[NSString stringWithFormat: @"%ld", (long)tempStrain.ratingCount] stringByAppendingString:@" Reviews"];;
    //    reviewClass *tempReview = [[reviewClass alloc] init];
    //    tempReview = [store.reviews objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    strainClass *tempStrain = [[strainClass alloc] init];
    tempStrain = [store.hasStrainsArray objectAtIndex:indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StrainProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Strain Profile VC SB ID"];
    vc.passedString = tempStrain.strainName;
    [self.navigationController pushViewController:vc animated:false];
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    strainClass *tempStrain = [[strainClass alloc] init];
    tempStrain = [store.hasStrainsArray objectAtIndex:indexPath.row];

    UITableViewRowAction *button = [UITableViewRowAction
                                    rowActionWithStyle:UITableViewRowActionStyleDestructive
                                    title:@"Delete"
                                    handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
    {
        NSLog(@"Action to perform with Button 1");
        [store.hasStrainsArray removeObject:tempStrain];
        
        [[[[firebaseRef.ref child:@"storeHasStrains"]  child:store.storeKey] child:tempStrain.strainKey] removeValue];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"oneGram"] removeValue];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"twoGram"] removeValue];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"eighth"] removeValue];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"fourth"] removeValue];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"half"] removeValue];
        [[[[[firebaseRef.ref child:@"storeStrainPrices"]  child:store.storeKey] child:tempStrain.strainKey] child:@"ounce"] removeValue];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    }];

    return @[button]; //array with all the buttons you want. 1,2,3, etc...
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // you need to implement this method too or nothing will work:
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES; //tableview must be editable or nothing will work...
}


@end
