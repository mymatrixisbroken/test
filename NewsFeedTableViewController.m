//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "NewsFeedTableViewController.h"

@interface NewsFeedTableViewController ()
@end

@implementation NewsFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    self.tableView.tableFooterView = [UIView new];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSString *text = @"News feed empty";
    UIFont *font = [UIFont boldSystemFontOfSize:16.0];
    UIColor *textColor = [UIColor colorWithHex:@"828587"];
    [attributes setObject:@(-0.10) forKey:NSKernAttributeName];

    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSString *text = @"When you add a friend, their activity will show up here.";
    UIFont *font = [UIFont systemFontOfSize:14.0];
    UIColor *textColor = [UIColor colorWithHex:@"828587"];
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];

    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    __block UIImage *image;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:@"http://i.imgur.com/3tGKHYV.png"]];
        if( data == nil ){
            NSLog(@"image is nil");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            image = [UIImage imageWithData:data];
        });
    });
    
    return image;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIColor colorWithHex:@"f7fafa"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [user.events count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"newsFeedCell";
    newsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *friendKey;
    NSString *event;
    __block NSString *imageURL;
    if (user.events.count ==nil){
        //[cell uploadCellWithUsername:@"lskdjgas" event:@"lsdkjgs" imageURL:@"http://i.imgur.com/H2nQOo4.jpg"];
    }
    else{
        NSDictionary *dict1 = [user.events objectAtIndex:indexPath.row];
        
        for (id key in dict1) {
            id value = [dict1 objectForKey:key];
            NSDictionary *dict2 = value;
            
            for (id key in dict2) {
                id value = [dict2 objectForKey:key];
                friendKey = key;
                event = value;
            }
        }
        
        [[firebaseRef.usersRef child:friendKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            imageURL = [snapshot.value valueForKey:@"avatar"];
            NSString *username = [snapshot.value valueForKey:@"username"];
            [cell uploadCellWithUsername:username event:event imageURL:imageURL];
        }];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
