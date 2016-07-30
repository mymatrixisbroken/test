//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}



- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_optionSelected){
        return [store.storeObjectArray count];
    }
    else{
        return [strain.strainObjectArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_optionSelected){
        static NSString *cellIdentifier = @"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if ([store.storeObjectArray count] > 0) {
            store = [store.storeObjectArray objectAtIndex:indexPath.row];
            cell.textLabel.text = store.store_name;     //set textLabel text to index value in _strainNameArray
            cell.detailTextLabel.text = [[[@"City:" stringByAppendingString:store.city] stringByAppendingString:@" State:" ] stringByAppendingString:store.state];     //set detailTextLabed text to index value in _thcArray and _cbdArray
            
            if([store.storeObjectArray count] > indexPath.row){ //Check if image array is populated
                cell.imageView.image = store.small_image;}
        }
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if ([strain.strainObjectArray count] > 0) {
            strain = [strain.strainObjectArray objectAtIndex:indexPath.row];
            cell.textLabel.text = strain.strain_name;     //set textLabel text to index value in _strainNameArray
            cell.detailTextLabel.text = [[[@"THC:" stringByAppendingString:strain.thc] stringByAppendingString:@" CBD:" ] stringByAppendingString:strain.cbd];
            if([strain.strainObjectArray count] > indexPath.row){
                cell.imageView.image = strain.small_image;
            }
        }
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_optionSelected){
        store = [store.storeObjectArray objectAtIndex:indexPath.row];
        FIRStorageReference *imageRef = [firebaseRef.strains_medium_images_ref child:strain.strain_key];
        [imageRef dataWithMaxSize:1 * 2000 * 2000 completion:^(NSData *data, NSError *error){
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                strain.medium_image = [UIImage imageWithData:data];
                [self performSegueWithIdentifier:@"storeListToProfileSegue" sender:self];
            }
        }];
    }
    else{
        strain = [strain.strainObjectArray objectAtIndex:indexPath.row];
        FIRStorageReference *imageRef = [firebaseRef.strains_medium_images_ref child:strain.strain_key];
        [imageRef dataWithMaxSize:1 * 2000 * 2000 completion:^(NSData *data, NSError *error){
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                strain.medium_image = [UIImage imageWithData:data];
                [self performSegueWithIdentifier:@"StrainListToProfileSegue" sender:self];
            }
        }];
    }
}

- (IBAction)tappedAddButton:(UIBarButtonItem *)sender {
    if(_optionSelected){
        [self performSegueWithIdentifier:@"AddStoreSegue" sender:self];
    }
    else{
        [self performSegueWithIdentifier:@"AddStrainSegue" sender:self];
    }
}

- (IBAction)tappedOptionsButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"optionListSegue" sender:self];
}


@end
