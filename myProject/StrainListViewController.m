//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StrainListViewController.h"

@interface StrainListViewController ()
@end

@implementation StrainListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeArray];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self getArrayOfStrainObjects];
    [self.tableView reloadData];
}

- (void) initializeArray{
    _strainObjectArray = [[NSMutableArray alloc] init];
}

- (void) getArrayOfStrainObjects{
    [firebaseRef.strainsRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _strainObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_strainObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *dict = [_strainObjectDictionary valueForKey:key];

            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            strainClass *strainLoop = [[strainClass alloc] init];
            [strainLoop setClassObject:key Values:dict];
            [self getSmallImageFromFirebase:strainLoop];
            //**********************************************//
            //NSLog(@"0 Object description is %@ at %d",[ICHObjectPrinter descriptionForObject:[_strainObjectArray objectAtIndex:i]], i);
            //**********************************************//
            [_strainObjectArray addObject:strainLoop];
        }
        [self.tableView reloadData];
    }];
}

- (void) getSmallImageFromFirebase:(strainClass *)strainLoop{
    FIRStorageReference *imageRef = [firebaseRef.strains_small_images_ref child:strainLoop.strain_key];
    [imageRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error){
        if (error != nil) {
            // Uh-oh, an error occurred!
        } else {
            strainLoop.small_image = [UIImage imageWithData:data]; //*downloadTask observeStatus:FIRStorageTaskStatusSuccess
        }
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_strainObjectArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"strainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if ([_strainObjectArray count] > 0) {
        strain = [_strainObjectArray objectAtIndex:indexPath.row];
        cell.textLabel.text = strain.strain_name;     //set textLabel text to index value in _strainNameArray
        cell.detailTextLabel.text = [[[@"THC:" stringByAppendingString:strain.thc] stringByAppendingString:@" CBD:" ] stringByAppendingString:strain.cbd];
        if([_strainObjectArray count] > indexPath.row){
            cell.imageView.image = strain.small_image;
        }
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    strain = [_strainObjectArray objectAtIndex:indexPath.row];
    
    FIRStorageReference *imageRef = [firebaseRef.strains_medium_images_ref child:strain.strain_key];
    [imageRef dataWithMaxSize:1 * 2000 * 2000 completion:^(NSData *data, NSError *error){
        if (error != nil) {
            // Uh-oh, an error occurred!
        } else {
            strain.medium_image = [UIImage imageWithData:data];
        }
    }];
    [self performSegueWithIdentifier:@"strainListToProfileSegue" sender:self];

}


- (IBAction)tappedOptionButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"optionListSegue" sender:self];
}

- (IBAction)tappedAddStrain:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
