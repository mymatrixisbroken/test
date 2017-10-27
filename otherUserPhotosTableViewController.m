//
//  otherUserPhotosTableViewController.m
//  myProject
//
//  Created by Guy on 10/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "otherUserPhotosTableViewController.h"

@interface otherUserPhotosTableViewController ()

@end

@implementation otherUserPhotosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _photoCountLabel.text = [[NSString stringWithFormat: @"%ld", [_otherUser.imagesUploaded count]] stringByAppendingString:@" Photos"];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionCount = 0;
    
    if ([_otherUser.imagesUploaded count] > 0){
        sectionCount++;
    }
    if ([_otherUser.imagesUploaded count] == 0) {
        UIView *rootView = [[[NSBundle mainBundle] loadNibNamed:@"reviewsEmptyView" owner:self options:nil] objectAtIndex:0];
        self.tableView.backgroundView = rootView;
    }
    NSLog(@"section count is %lu",sectionCount);
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_otherUser.imagesUploaded count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    userPhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"currentUserPhotoCell" forIndexPath:indexPath];
    
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];
    
    if ([_otherUser.imagesUploaded count] > 0){                                      //check images array is null
        imageClass *image = [[imageClass alloc] init];
        image = [_otherUser.imagesUploaded objectAtIndex:0];
        NSString *imageURL = [image.imageKey stringByAppendingString:@".jpg"];
        FIRStorageReference *spaceRef = [[[storageRef child:image.imageType] child:image.objectKey] child:imageURL];
        NSLog(@"space ref is %@", spaceRef);
        UIImage *placeHolder = [[UIImage alloc] init];
        
        [cell.imageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
    }
    return cell;
    
    // Configure the cell...
    
    
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
