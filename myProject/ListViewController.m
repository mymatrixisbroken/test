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
    /*
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView reloadData];*/
}
/*
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(_cellSelected){
        return [objectsArray.storeObjectArray count];
    }
    else{
        return [objectsArray.strainObjectArray count];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_cellSelected){
        return [objectsArray.storeObjectArray count];
    }
    else{
        return [objectsArray.strainObjectArray count];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";

    CustomCollectionViewCell *cell =
    (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                                forIndexPath:indexPath];

    
    
    if(_cellSelected){
        NSLog(@"stores selected");
        if ([objectsArray.storeObjectArray count] > 0) {
            
            store = [objectsArray.storeObjectArray objectAtIndex:indexPath.row];
            //cell.label.text = store.store_name;
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:store.image_name]];
                if( data == nil ){
                    NSLog(@"image is nil");
                    return;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // WARNING: is the cell still using the same data by this point??
                    cell.imageView.image = [UIImage imageWithData: data];
                });
            });
        }
    }
    else{
        NSLog(@"strains selected");
        
        if ([objectsArray.strainObjectArray count] > 0) {
            strain = [objectsArray.strainObjectArray objectAtIndex:indexPath.row];
            cell.label.text = strain.strain_name;  
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:strain.image_name]];
                if( data == nil ){
                    NSLog(@"image is nil");
                    return;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // WARNING: is the cell still using the same data by this point??
                    cell.imageView.image = [UIImage imageWithData: data];
                });
            });
        }
    }
    return cell;

}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(_cellSelected){
        NSLog(@"stores selected");
        if ([objectsArray.storeObjectArray count] > 0) {
            NSLog(@"0 Object description is %@",[ICHObjectPrinter descriptionForObject:[objectsArray.storeObjectArray objectAtIndex:0]]);

        store = [objectsArray.storeObjectArray objectAtIndex:indexPath.row];
        cell.textLabel.text = store.store_name;
        cell.detailTextLabel.text = [[[@"City:" stringByAppendingString:store.city] stringByAppendingString:@" State:"]stringByAppendingString:store.state];
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:store.image_name]];
            if( data == nil ){
                NSLog(@"image is nil");
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
                cell.imageView.image = [UIImage imageWithData: data];
            });
        });
        }
    }
    else{
        NSLog(@"strains selected");

        if ([objectsArray.strainObjectArray count] > 0) {
            strain = [objectsArray.strainObjectArray objectAtIndex:indexPath.row];
            cell.textLabel.text = strain.strain_name;     //set textLabel text to index value in _strainNameArray
            cell.detailTextLabel.text = [[[@"THC:" stringByAppendingString:strain.thc] stringByAppendingString:@" CBD:" ] stringByAppendingString:strain.cbd];
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:strain.image_name]];
            if( data == nil ){
                NSLog(@"image is nil");
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
                cell.imageView.image = [UIImage imageWithData: data];
            });
        });
        }
    }
    return cell;
}
*/
/*
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_cellSelected){
        store = [objectsArray.storeObjectArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"listToStoreProfileSegue" sender:self];
    }
    else if (!_cellSelected){
        strain = [objectsArray.strainObjectArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"listToStrainProfileSegue" sender:self];
    }
}
*/



 
- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"listToHomepageSegue" sender:self];
}


@end
