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
            NSArray *array = [dict valueForKey:@"images"];
            
            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            strainClass *strainLoop = [[strainClass alloc] init];
            [strainLoop setClassObject:key Values:dict Image:array];

            //**********************************************//
            //NSLog(@"0 Object description is %@ at %d",[ICHObjectPrinter descriptionForObject:[_strainObjectArray objectAtIndex:i]], i);
            //**********************************************//
            [_strainObjectArray addObject:strainLoop];
        }
        [self.tableView reloadData];
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
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[strain.imageNames objectAtIndex:0]]];
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    strain = [_strainObjectArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"strainListToProfileSegue" sender:self];
}


- (IBAction)tappedAddStrain:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
