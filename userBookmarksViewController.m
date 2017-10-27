//
//  userBookmarksViewController.m
//  myProject
//
//  Created by Guy on 10/23/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "userBookmarksViewController.h"

@interface userBookmarksViewController ()

@end

@implementation userBookmarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _bookmarks = [[NSMutableArray alloc] init];
    
    _spinner = [[UIActivityIndicatorView alloc]
                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.hidesWhenStopped = YES;
    _spinner.center = self.view.center;
    [self.view addSubview:_spinner];
    [_spinner startAnimating];


    // Do any additional setup after loading the view.
    [self getBookmarkInformation];
}

-(void) getBookmarkInformation{
    for(int i = 0; i < [user.storeBookmarks count]; i++){
        bookmarkClass *bookmark = [[bookmarkClass alloc] init];
        [_bookmarks addObject:bookmark];
        
        [self getBookmarkName:i];
        [self getBookmarkRating:i];
        [self getBookmarkImages:i];
    }
}

-(void) getBookmarkName:(NSInteger) i{
    bookmarkClass *bookmark = [[bookmarkClass alloc] init];
    bookmark = [_bookmarks objectAtIndex:i];
    NSString *stringKey = [user.storeBookmarks objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"storeNames"] child:stringKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            bookmark.bookmarkName = [snapshot.value valueForKey:@"name"];
            [_bookmarks replaceObjectAtIndex:i withObject:bookmark];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    }];

}

-(void) getBookmarkRating:(NSInteger) i{
    bookmarkClass *bookmark = [[bookmarkClass alloc] init];
    bookmark = [_bookmarks objectAtIndex:i];
    NSString *stringKey = [user.storeBookmarks objectAtIndex:i];

    [[[[firebaseRef.ref child:@"starRating"] child:@"stores"] child:stringKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSArray *scores = [[NSArray alloc] init];
            scores = [snapshot.value allValues];
            bookmark.bookmarkReviewCount = [scores count];
            
            if ([scores count] > 0) {
                float floatRating;
                floatRating = [bookmark.bookmarkRating floatValue];
                for (id i in scores){
                    floatRating = floatRating + [i floatValue];
                }
                bookmark.bookmarkRating = [NSString stringWithFormat:@"%lf", floatRating];
            }
            [_bookmarks replaceObjectAtIndex:i withObject:bookmark];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        [_spinner stopAnimating];
    }];
}

-(void) getBookmarkImages:(NSInteger) i{
    bookmarkClass *bookmark = [[bookmarkClass alloc] init];
    bookmark = [_bookmarks objectAtIndex:i];
    NSString *stringKey = [user.storeBookmarks objectAtIndex:i];

    [[[[firebaseRef.ref child:@"images"] child:@"stores"] child:stringKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSArray *imageKeys = [[NSArray alloc] init];
            imageKeys = [snapshot.value allKeys];
            
            imageClass *image = [[imageClass alloc] init];
            image.imageKey = [imageKeys objectAtIndex:0];
            image.imageURL = [snapshot.value valueForKey:image.imageKey];
            [bookmark.bookmarkImageLink addObject:image];
            [_bookmarks replaceObjectAtIndex:i withObject:bookmark];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionCount = 0;
    
    if ([user.storeBookmarks count] > 0){
        sectionCount++;
    }
    if ([user.strainBookmarks count] > 0){
        sectionCount++;
    }
    if (([user.strainBookmarks count] == 0) && ([user.storeBookmarks count] == 0)) {
        UIView *rootView = [[[NSBundle mainBundle] loadNibNamed:@"reviewsEmptyView" owner:self options:nil] objectAtIndex:0];
        self.tableView.backgroundView = rootView;
    }
    NSLog(@"section count is %lu",sectionCount);
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return [user.storeBookmarks count];
    }
    else if(section ==1 ){
        return [user.strainBookmarks count];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    switch (section) {
        case 0:
            header.textLabel.text = @"S T O R E S";
            break;
        case 1:
            header.textLabel.text = @"Strains";
            break;
        default:
            break;
    }
    
    header.tintColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1];
    header.textLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    header.textLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        NSString *cellIdentifier = @"userBookmarkCell";
        userBookmarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
       
        bookmarkClass *bookmark = [[bookmarkClass alloc] init];
        bookmark = [_bookmarks objectAtIndex:indexPath.row];
        NSString *bookmarkKey = [user.storeBookmarks objectAtIndex:indexPath.row];
        
        cell.bookmarkNameLabel.text =bookmark.bookmarkName;
        cell.bookmarkRatingView.value = [bookmark.bookmarkRating floatValue];
        cell.bookmarkReviewCountLabel.text = [[NSString stringWithFormat: @"%ld", (long)bookmark.bookmarkReviewCount] stringByAppendingString:@" Reviews"];

        FIRStorage *storage = [FIRStorage storage];
        FIRStorageReference *storageRef = [storage reference];

        if ([bookmark.bookmarkImageLink count] > 0){                                      //check images array is null
            imageClass *image = [[imageClass alloc] init];
            image = [bookmark.bookmarkImageLink objectAtIndex:0];
            FIRStorageReference *spaceRef = [[[storageRef child:@"stores"] child:bookmarkKey] child:image.imageURL];
            UIImage *placeHolder = [[UIImage alloc] init];
            
            [cell.bookmarkImageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
        }
        return cell;
    }
    else{
        NSString *cellIdentifier = @"userBookmarkCell";
        userBookmarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        return cell;
    }
}

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
