//
//  searchStrainsViewController.m
//  myProject
//
//  Created by Guy on 10/8/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "searchStrainsViewController.h"

@interface searchStrainsViewController ()

@end

@implementation searchStrainsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _selectedStrains = [[NSMutableArray alloc] init];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedLeft)];
    swipeLeft.numberOfTouchesRequired = 1;
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    [self loadExtView];
    [self loadTextField];
    
    CGRect newFrame = _searchStrainsTableView.frame;
    newFrame.origin.y += 100;
    _searchStrainsTableView.frame = newFrame;
    self.searchStrainsTableView.delegate = self;
    self.searchStrainsTableView.dataSource = self;
    self.searchStrainsTableView.allowsMultipleSelection = true;
    
    [self loadAllStrainsOnce];
    
    [_textField addTarget:self
                   action:@selector(textFieldDidChange:)
         forControlEvents:UIControlEventEditingChanged];
    
    [_addButton addTarget:self
                      action:@selector(tappedAddButton:)
            forControlEvents:UIControlEventTouchUpInside];
    
    //    [self loadStarRating];
}

-(void)tappedAddButton:(UIButton *)button{
    NSLog(@"selected row count is %lu", [self.searchStrainsTableView indexPathsForSelectedRows].count);
    NSLog(@"selected row indexes are %@", [self.searchStrainsTableView indexPathsForSelectedRows]);
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    priceStrainViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Price Strain Navigation ID"];
    vc.strainArray = [[NSMutableArray alloc] init];
    
//    for(NSIndexPath *indexPath in [self.searchStrainsTableView indexPathsForSelectedRows]){
    for(strainClass *tempStrain in _selectedStrains){
        [vc.strainArray addObject:tempStrain];
    }
    
    [self.navigationController pushViewController:vc animated:false];

//    NSIndexPath *indexPath = [[self.searchStrainsTableView indexPathsForSelectedRows] objectAtIndex:0];
//    strainClass *tempStrain = [[strainClass alloc] init];
//    tempStrain = [_displayStrains objectAtIndex:indexPath.row];
//
//    NSLog(@"strain key is %@", tempStrain.strainKey);
}

-(void) screenSwipedLeft{
    FIRUser *currentUser = [FIRAuth auth].currentUser;
    if(currentUser.anonymous){
        [user gotoOptionListViewController:self];
    } else {
        [user gotoOptionListSignedInViewController:self];
    }
}

//-(void) loadAllStrainsBefore{                                 //update to load 20 some odd
//    [[firebaseRef.ref child:@"strainNames"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        NSLog(@"snapshot3 is %@",snapshot);
//        _strainNamesArray = [[NSMutableArray alloc] init];
//        if ([NSNull null] != snapshot.value){
//            for(id key in [snapshot.value allKeys]){
//                NSString *keyPath = [key stringByAppendingString:@".name"];
//                NSString *name = [snapshot.value valueForKeyPath:keyPath];
//                NSLog(@"strainName is %@",name);
//                [_strainNamesArray addObject:name];
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_searchStrainsTableView reloadData];
//        });
//    }];
//}

- (void) loadAllStrainsOnce{
    _strainsDownloadOnce = [[NSMutableArray alloc] init];
    _strainKeys = [[NSArray alloc] init];
    [[firebaseRef.ref child:@"strainKeys"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            
            _strainKeys = [snapshot.value allKeys];
            NSLog(@"strain keys count is %lu", (unsigned long)[_strainKeys count]);
            [self getStrainInformation];
        }
    }];
}

- (void) copyArraryToArray{
    _displayStrains = [[NSMutableArray alloc] init];
    _displayStrains = [NSMutableArray arrayWithArray:_strainsDownloadOnce];
//    NSLog(@"display array count is %lu", (unsigned long)[_displayStrains count]);
}

- (void) getStrainInformation{
    for (int i = 0; i < _strainKeys.count; i++){
        
        strainClass *myStrain = [[strainClass alloc] init];
        [_strainsDownloadOnce addObject:myStrain];
        
        myStrain = [_strainsDownloadOnce objectAtIndex:i];
        myStrain.strainKey = [_strainKeys objectAtIndex:i];
        [_strainsDownloadOnce replaceObjectAtIndex:i withObject:myStrain];
        
        [self getStrainName: i];
        [self getStrainCBD: i];
        [self getStrainTHC: i];
        [self getStrainCBN: i];
        [self getStrainFamily: i];
    }
    [self copyArraryToArray];
}

- (void) getStrainName:(NSInteger) i {
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [_strainsDownloadOnce objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"strainNames"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            
            myStrain.strainName = [snapshot.value valueForKey:@"name"];
            
            NSLog(@"object name is %@", myStrain.strainName);
            
            [_strainsDownloadOnce replaceObjectAtIndex:i withObject:myStrain];
        }
    }];
}

- (void) getStrainCBD:(NSInteger) i{
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [_strainsDownloadOnce objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"CBD"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            
            myStrain.cbd = [snapshot.value valueForKey:@"CBD"];
            
            NSLog(@"CBD is %@", myStrain.cbd);
            
            [_strainsDownloadOnce replaceObjectAtIndex:i withObject:myStrain];
        }
    }];
}

- (void) getStrainTHC:(NSInteger) i{
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [_strainsDownloadOnce objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"THC"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            
            myStrain.thc = [snapshot.value valueForKey:@"THC"];
            
            NSLog(@"THC is %@", myStrain.thc);
            
            [_strainsDownloadOnce replaceObjectAtIndex:i withObject:myStrain];
        }
    }];
}

- (void) getStrainCBN:(NSInteger) i{
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [_strainsDownloadOnce objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"CBN"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            
            myStrain.cbn = [snapshot.value valueForKey:@"CBN"];
            
            NSLog(@"CBN is %@", myStrain.thc);
            
            [_strainsDownloadOnce replaceObjectAtIndex:i withObject:myStrain];
        }
    }];
}

- (void) getStrainFamily:(NSInteger) i{
    strainClass *myStrain = [[strainClass alloc] init];
    myStrain = [_strainsDownloadOnce objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"strainFamily"] child:myStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            
            myStrain.family = [snapshot.value valueForKey:@"family"];
            
            NSLog(@"family is %@", myStrain.family);
            
            [_strainsDownloadOnce replaceObjectAtIndex:i withObject:myStrain];
        }
    }];
}

- (void) textFieldDidChange:(UITextField *)textField{
    if(textField.text.length == 0){
        //        _strainNamesArray  = [[NSMutableArray alloc] init];
        //        [_searchStrainsTableView reloadData];
        
        [self copyArraryToArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_searchStrainsTableView reloadData];
        });
    }
    else{
        [self searchDownloadOnceArray];
    }
}


//- (void) textFieldDidChange:(UITextField *)textField{
//    if(textField.text.length == 0){
////        _strainNamesArray  = [[NSMutableArray alloc] init];
////        [_searchStrainsTableView reloadData];
//
//        [self loadAllStrains];
//    }
//    else{
//        [self searchFirebaseForText];
//    }
//}

- (void) loadExtView{
    _extView = [[extensionViewClass alloc] init];
    [_extView setView:CGRectGetWidth(self.view.bounds)];
    CGRect newFrame = _extView.frame;
    newFrame.origin.y += 75;
    _extView.frame = newFrame;
    
    //    [extView addTexField:CGRectGetWidth(self.view.bounds)];
//        [self.view bringSubviewToFront:_extView];
    [self.shyNavBarManager setExtensionView:_extView];
    [self.shyNavBarManager setStickyExtensionView:NO];
}

- (void) loadTextField{
    _textField = [[UITextField alloc] initWithFrame:_extView.frame];
    _extView.frame = CGRectOffset( _extView.frame, 0, 20 ); // offset by an amount
    _textField.font = [UIFont fontWithName:@"CERVO-LIGHT" size:23.0];
    _textField.placeholder = @"Type here to start search.";
    _textField.tintColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1];
    _textField.textColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1];
    [_extView addSubview:_textField];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return [_displayStrains count];
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        NSString *cellIdentifier = @"resultCell";
        searchStrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//        cell.strainNameLabel.text = [_strainNamesArray objectAtIndex:indexPath.row];
        if ([_displayStrains count] > 0) {
            strainClass *tempStrain = [[strainClass alloc] init];
            tempStrain = [_displayStrains objectAtIndex:indexPath.row];
            cell.strainNameLabel.text = tempStrain.strainName;
            cell.familyLabel.text = tempStrain.family;
            cell.cbdPercentLabel.text = [[NSString stringWithFormat:@"%@", tempStrain.cbd] stringByAppendingString:@"%"];
            cell.cbnPercentLabel.text = [[NSString stringWithFormat:@"%@", tempStrain.cbn] stringByAppendingString:@"%"];
            cell.thcPercentLabel.text= [[NSString stringWithFormat:@"%@", tempStrain.thc] stringByAppendingString:@"%"];
        }
        return cell;
    }
    else{
        NSString *cellIdentifier = @"resultCell";
        searchStrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.strainNameLabel.text = @"";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    strainClass *tempStrain = [[strainClass alloc] init];
    tempStrain = [_displayStrains objectAtIndex:indexPath.row];
    if([_selectedStrains indexOfObject:tempStrain] != NSNotFound){
        [cell setSelected:YES animated:NO];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
        strainClass *tempStrain = [[strainClass alloc] init];
        tempStrain = [_displayStrains objectAtIndex:indexPath.row];
        [_selectedStrains removeObject:tempStrain];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        strainClass *tempStrain = [[strainClass alloc] init];
        tempStrain = [_displayStrains objectAtIndex:indexPath.row];
        [_selectedStrains addObject:tempStrain];
}

-(void) searchDownloadOnceArray{    
    _displayStrains = [[NSMutableArray alloc] init];
    for(strainClass *strain in _strainsDownloadOnce){
        if ([strain.strainName rangeOfString:_textField.text options:NSAnchoredSearch | NSCaseInsensitiveSearch].location == NSNotFound) {
            //string not found
        } else {
            [_displayStrains addObject:strain];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_searchStrainsTableView reloadData];
    });
}



//-(void) searchFirebaseForText{
//    NSString *lowerString = [_textField.text lowercaseString];
//    NSInteger length = [_textField.text length] - 1;
//    unichar c = [_textField.text characterAtIndex:length];
//    c++;
//    NSString *charIncrement = [NSString stringWithCharacters:&c length:1];
//    NSString *endString = [_textField.text substringWithRange:NSMakeRange(0, length)];
//    endString = [endString stringByAppendingString:charIncrement];
//    endString = [endString lowercaseString];
//
//    NSLog(@"end string is %@", endString);
//
//    FIRDatabaseQuery *strainNamesQuery = [[[[[firebaseRef.ref child:@"strainNames"] queryOrderedByChild:@"lowerName"] queryStartingAtValue:lowerString] queryEndingAtValue:endString] queryLimitedToFirst:4];
//
//    [strainNamesQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        NSLog(@"snapshot3 is %@",snapshot);
//        _strainNamesArray = [[NSMutableArray alloc] init];
//        if ([NSNull null] != snapshot.value){
//            for(id key in [snapshot.value allKeys]){
//                NSString *keyPath = [key stringByAppendingString:@".name"];
//                NSString *name = [snapshot.value valueForKeyPath:keyPath];
//                NSLog(@"strainName is %@",name);
//                [_strainNamesArray addObject:name];
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_searchStrainsTableView reloadData];
//        });
//    }];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
