//
//  StoreReviewTableViewController.m
//  myProject
//
//  Created by Guy on 10/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StorePhotosTableViewController.h"

@interface StorePhotosTableViewController ()

@end

@implementation StorePhotosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([store.imagesArray count] > 0) {
        NSString *imageCount = [NSString stringWithFormat:@"%lu Photos", [store.imagesArray count]];
        _numberOfPhotosLabel.text = imageCount;
    }
    else{
        _numberOfPhotosLabel.text = @"0 Photos";
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

//- (IBAction)tappedWriteReviewButton:(UIButton *)sender {
//    FIRUser *youser = [FIRAuth auth].currentUser;
//    if (youser.email == nil) {
//        [user goToUserNotSignedInViewController:self];
//    } else {
//        [user goToWriteReviewViewController:self];
//    }
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    static NSString *HeaderCellIdentifier = @"Header";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
//    }
//    
//    // Configure the cell title etc
//    
//    return cell;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (IBAction)selectedAddPhoto:(UIButton *)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToLoginViewController:self];
    }
    else{
        [user goToSelectPhotosViewController:self];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"store reviews count %lu", store.imagesArray.count);
    return [store.imagesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"StorePhotoCell";
    StorePhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
    [cell uploadCellWithPhoto];
//    imageClass *image = [[imageClass alloc] init];
//    NSLog(@"store images array count %lu", store.imagesArray.count);
//    image = [store.imagesArray objectAtIndex:indexPath.row];
    //    _store_image_view.image = [UIImage imageWithData: image.data];
    
    for (int i = 0; i < [store.imagesArray count]; i++) {
        FIRStorage *storage = [FIRStorage storage];
        FIRStorageReference *storageRef = [storage reference];
        
        imageClass *image = [[imageClass alloc] init];
        image = [store.imagesArray objectAtIndex:i];
        
        NSLog(@"image link is %@", image.imageURL);
        FIRStorageReference *spaceRef = [[[storageRef child:@"stores"] child:store.storeKey] child:image.imageURL];
        NSLog(@"ref is %@", spaceRef);
        
        UIImage *placeHolder = [[UIImage alloc] init];
        [cell.photoImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    store.imageArrayIndex = indexPath.row;
    
    NSLog(@"%@",[self.navigationController.viewControllers objectAtIndex:0]);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    popOverImageViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Popover Image VC SB ID"];
    NSString *otherStrainName = [NSString stringWithFormat: @"%@",[self.navigationController.viewControllers objectAtIndex:0]];
    vc.passedString = otherStrainName;
    vc.indexForImage = indexPath.row;
    [self.navigationController pushViewController:vc animated:false];

//    [user goToPopoverImageViewController:self];
}

@end
