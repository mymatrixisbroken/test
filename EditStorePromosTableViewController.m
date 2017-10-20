//
//  EditStorePromosTableViewController.m
//  myProject
//
//  Created by Guy on 9/19/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "EditStorePromosTableViewController.h"

@interface EditStorePromosTableViewController ()

@end

@implementation EditStorePromosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_addButton addTarget:self
                       action:@selector(tappedAddButton:)
             forControlEvents:UIControlEventTouchUpInside];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}


-(IBAction) tappedAddButton:(UIButton*)btn
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddStorePromoViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Write Store Promo SB ID"];
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.preferredContentSize = CGSizeMake(280, 125);
    
    UIPopoverPresentationController *popOver = vc.popoverPresentationController;
    
    popOver.delegate = self;
    popOver.sourceView = self.view;
    popOver.sourceRect = btn.frame;
    popOver.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popOver.backgroundColor = [UIColor colorWithRed:7.0/255.0 green:18.0/255.0 blue:17.0/255.0 alpha:1.0];
    
    [self presentViewController:vc animated:YES completion:NULL];
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
    return [store.promosArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    promoClass *promo = [[promoClass alloc] init];
    promo = [store.promosArray objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = @"EditStorePromoCell";
    EditStoresPromosCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.promoDateLabel.text = promo.promoDate;
    cell.promoTextLabel.text = promo.promoText;
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
