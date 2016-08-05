//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StoreListViewController.h"

@interface StoreListViewController ()

@end

@implementation StoreListViewController
- (void)viewDidLoad {
    [self initializeArray];
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self getArrayOfStoreObjects];
    [self.tableView reloadData];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void) initializeArray{
    _storeObjectArray = [[NSMutableArray alloc] init];
}

- (void) getArrayOfStoreObjects{
    NSLog(@"stores ref %@", firebaseRef.storesRef);
    [firebaseRef.storesRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _storeObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_storeObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *dict = [_storeObjectDictionary valueForKey:key];
            
            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            storeClass *storeloop = [[storeClass alloc] init];
            [storeloop setClassObject:key Values:dict];
            [self getSmallImageFromFirebase:storeloop];
            //**********************************************//
            //NSLog(@"0 Object description is %@ at %d",[ICHObjectPrinter descriptionForObject:[_storeObjectArray objectAtIndex:i]], i);
            //**********************************************//
            [_storeObjectArray addObject:storeloop];
        }
        [self.tableView reloadData];
    }];
}

- (void) getSmallImageFromFirebase:(storeClass *)storeloop{
    //FIRStorageReference *imageRef = [firebaseRef.stores_small_images_ref child:storeloop.store_key]; //Create reference to FirStorage imagename
    
    /*FIRStorageDownloadTask *download_task = [imageRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error){
        if (error != nil) {
    }
        else {
            storeloop.small_image = [UIImage imageWithData:data]; //*downloadTask observeStatus:FIRStorageTaskStatusSuccess
        }
    }];
     
    [download_task observeStatus:FIRStorageTaskStatusSuccess handler:^(FIRStorageTaskSnapshot *snapshot) {
        //NSLog(@"small image is %@",_strain.small_image);
    }];*/
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_storeObjectArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"storeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if ([_storeObjectArray count] > 0) {
        store = [_storeObjectArray objectAtIndex:indexPath.row];
        cell.textLabel.text = store.store_name;     //set textLabel text to index value in _strainNameArray
        cell.detailTextLabel.text = [[[@"City:" stringByAppendingString:store.city] stringByAppendingString:@" State:" ] stringByAppendingString:store.state];     //set detailTextLabed text to index value in _thcArray and _cbdArray

        if([_storeObjectArray count] > indexPath.row){ //Check if image array is populated
            cell.imageView.image = store.small_image;}
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    store = [_storeObjectArray objectAtIndex:indexPath.row];
    /*FIRStorageReference *imageRef = [firebaseRef.stores_medium_images_ref child:store.store_key];
    [imageRef dataWithMaxSize:1 * 2000 * 2000 completion:^(NSData *data, NSError *error){
        if (error != nil) {
            // Uh-oh, an error occurred!
        } else {
            store.medium_image = [UIImage imageWithData:data];
        }
    }];*/

    [self performSegueWithIdentifier:@"storeListToProfileSegue" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tappedOptionsList:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"showSplitViewSegue" sender:self];
}

- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showSplitViewSegue"]){
        //AddStoreViewController *controller = (AddStoreViewController *)segue.destinationViewController;
        //controller.store = _addNewStore;
    }
}

@end
