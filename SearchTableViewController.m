//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "SearchTableViewController.h"
@interface SearchTableViewController ()

@end

@implementation SearchTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    objectsArray = [objectsArrayClass sharedInstance];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"integer"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self loadStrains];
            break;
        }
        case 1:
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"integer"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self loadStores];
            break;
        }
        default:
            break;
    }
}

- (void) loadStrains {
    [objectsArray.strainObjectArray removeAllObjects];
    
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
            [strainLoop.imageNames removeObjectAtIndex:0];

            [objectsArray.strainObjectArray addObject:strainLoop];
        }
        [self performSegueWithIdentifier:@"homepageToListSegue" sender:self];
    }];
}

- (void) loadStores {
    [objectsArray.storeObjectArray removeAllObjects];
    
    [firebaseRef.storesRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _storeObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_storeObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *dict = [_storeObjectDictionary valueForKey:key];
            NSArray *array = [dict valueForKey:@"images"];
            
            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            storeClass *storeloop = [[storeClass alloc] init];
            [storeloop setClassObject:key Values:dict Image:array];
            [storeloop.imageNames removeObjectAtIndex:0];
            
            [objectsArray.storeObjectArray addObject:storeloop];
        }
        [self performSegueWithIdentifier:@"storeSelectionToListSegue" sender:self];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
