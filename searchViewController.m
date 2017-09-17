//
//  searchViewController.m
//  myProject
//
//  Created by Guy on 8/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "searchViewController.h"

@interface searchViewController ()

@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadExtView];
    [self loadTextField];
    
    CGRect newFrame = _searchTableView.frame;
    newFrame.origin.y += 40;
    _searchTableView.frame = newFrame;
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    
    [_textField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
//    self.shyNavBarManager.scrollView = self.searchTableView;
}

- (void) textFieldDidChange:(UITextField *)textField{
    if(textField.text.length == 0){
        _usernamesArray  = [[NSMutableArray alloc] init];
        _storeNamesArray  = [[NSMutableArray alloc] init];
        _strainNamesArray  = [[NSMutableArray alloc] init];
        [_searchTableView reloadData];
    }
    else{
        [self searchFirebaseForText];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadExtView{
    _extView = [[extensionViewClass alloc] init];
    [_extView setView:CGRectGetWidth(self.view.bounds)];
//    [extView addTexField:CGRectGetWidth(self.view.bounds)];
    [self.shyNavBarManager setExtensionView:_extView];
    [self.shyNavBarManager setStickyExtensionView:YES];
}

- (void) loadTextField{
    _textField = [[UITextField alloc] initWithFrame:_extView.frame];
    _textField.font = [UIFont fontWithName:@"CERVO-LIGHT" size:23.0];
    _textField.placeholder = @"Typing Goes Here...";
    _textField.tintColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1];
    _textField.textColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1];
    [_extView addSubview:_textField];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    NSArray *viewsToRemove = [header subviews];
    for (UIView *v in viewsToRemove) {
        if ([v isKindOfClass:[UIImageView class]])
            [v removeFromSuperview];
    }

    
    NSLog(@"executed add image. section is %ld ",(long)section);
    UIImageView *imageView1 =  [[UIImageView alloc] initWithFrame:CGRectMake(35,12,25,25)];
    UIImageView *imageView2 =  [[UIImageView alloc] initWithFrame:CGRectMake(35,12,25,25)];
    UIImageView *imageView3 =  [[UIImageView alloc] initWithFrame:CGRectMake(35,12,25,25)];

    switch (section) {
        case 0:
            header.textLabel.text = @"               Stores";
            imageView1.image = [UIImage imageNamed:@"storesGreenIcon"];
            [header addSubview:imageView1];
            break;
        case 1:
            header.textLabel.text = @"               Users";
            imageView2.image = [UIImage imageNamed:@"avatarGreenIcon"];
            [header addSubview:imageView2];
            break;
        case 2:
            header.textLabel.text = @"               Strains";
            imageView3.image = [UIImage imageNamed:@"strainGreenIcon"];
            [header addSubview:imageView3];
            break;
        default:
            break;
    }
    

    header.tintColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1];
    header.textLabel.textColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1];
    header.textLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return [_storeNamesArray count];
    }
    else if(section == 1){
        return [_usernamesArray count];
    }
    else if(section == 2){
        return [_strainNamesArray count];
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        NSString *cellIdentifier = @"resultCell";
        searchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.resultLabel.text = [_storeNamesArray objectAtIndex:indexPath.row];
        
        return cell;
    }
    else if(indexPath.section == 1){
        NSString *cellIdentifier = @"resultCell";
        searchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.resultLabel.text = [_usernamesArray objectAtIndex:indexPath.row];
        return cell;
    }
    else if(indexPath.section == 2){
        NSString *cellIdentifier = @"resultCell";
        searchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.resultLabel.text = [_strainNamesArray objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        NSString *cellIdentifier = @"resultCell";
        searchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.resultLabel.text = @"";
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        StoreProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Store Profile VC SB ID"];
        NSLog(@"other store name is %@",[_storeNamesArray objectAtIndex:indexPath.row]);
        NSString *otherStoreName = [_storeNamesArray objectAtIndex:indexPath.row];
        vc.passedString = otherStoreName;
        [self.navigationController pushViewController:vc animated:false];
    }
    else if(indexPath.section == 1){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        UserProfileViewController *vc = [[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:nil];
        UserProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"User Profile VC SB ID"];
        //        UIViewController *vc3 = [sb instantiateViewControllerWithIdentifier:@"User Profile VC SB ID"];
//        UIViewController *vc2 = [sb instantiateViewControllerWithIdentifier:@"UserProfile Navigation SB ID"];
        NSLog(@"other user name is %@",[_usernamesArray objectAtIndex:indexPath.row]);
        NSString *otherUserName = [_usernamesArray objectAtIndex:indexPath.row];
        vc.passedString = otherUserName;
        //        [self.navigationController pushViewController:vc2 animated:YES];
        //    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //    [viewController presentViewController:vc animated:YES completion:NULL];
        [self.navigationController pushViewController:vc animated:false];
        
    }
    else if(indexPath.section == 2){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UserProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Strain Profile VC SB ID"];
        NSLog(@"other strain name is %@",[_strainNamesArray objectAtIndex:indexPath.row]);
        NSString *otherStrainName = [_strainNamesArray objectAtIndex:indexPath.row];
        vc.passedString = otherStrainName;
        [self.navigationController pushViewController:vc animated:false];
    }
}


-(void) searchFirebaseForText{
    NSString *lowerString = [_textField.text lowercaseString];
    NSInteger length = [_textField.text length] - 1;
    unichar c = [_textField.text characterAtIndex:length];
    c++;
    NSString *charIncrement = [NSString stringWithCharacters:&c length:1];
    NSString *endString = [_textField.text substringWithRange:NSMakeRange(0, length)];
    endString = [endString stringByAppendingString:charIncrement];
    endString = [endString lowercaseString];
    
    NSLog(@"end string is %@", endString);
    
    FIRDatabaseQuery *usernamesQuery = [[[[[firebaseRef.ref child:@"usernames"] queryOrderedByChild:@"lowerUsername"] queryStartingAtValue:lowerString] queryEndingAtValue:endString] queryLimitedToFirst:4];
    FIRDatabaseQuery *storeNamesQuery = [[[[[firebaseRef.ref child:@"storeNames"] queryOrderedByChild:@"lowerName"] queryStartingAtValue:lowerString] queryEndingAtValue:endString] queryLimitedToFirst:4];
    FIRDatabaseQuery *strainNamesQuery = [[[[[firebaseRef.ref child:@"strainNames"] queryOrderedByChild:@"lowerName"] queryStartingAtValue:lowerString] queryEndingAtValue:endString] queryLimitedToFirst:4];
    
    [usernamesQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        NSLog(@"snapshot1 is %@",snapshot);
        _usernamesArray = [[NSMutableArray alloc] init];
        if ([NSNull null] != snapshot.value){
            for(id key in [snapshot.value allKeys]){
                NSString *keyPath = [key stringByAppendingString:@".username"];
                NSString *name = [snapshot.value valueForKeyPath:keyPath];
                NSLog(@"username is %@",name);
                [_usernamesArray addObject:name];
            }
        }
    }];
    
    [storeNamesQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        NSLog(@"snapshot2 is %@",snapshot);
        _storeNamesArray = [[NSMutableArray alloc] init];
        if ([NSNull null] != snapshot.value){
            for(id key in [snapshot.value allKeys]){
                NSString *keyPath = [key stringByAppendingString:@".name"];
                NSString *name = [snapshot.value valueForKeyPath:keyPath];
                NSLog(@"storeName is %@",name);
                [_storeNamesArray addObject:name];
            }
        }
    }];
    [strainNamesQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        NSLog(@"snapshot3 is %@",snapshot);
        _strainNamesArray = [[NSMutableArray alloc] init];
        if ([NSNull null] != snapshot.value){
            for(id key in [snapshot.value allKeys]){
                NSString *keyPath = [key stringByAppendingString:@".name"];
                NSString *name = [snapshot.value valueForKeyPath:keyPath];
                NSLog(@"strainName is %@",name);
                [_strainNamesArray addObject:name];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_searchTableView reloadData];
        });
    }];
}


@end
