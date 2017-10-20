//
//  selectPhotosCollectionView.m
//  myProject
//
//  Created by Guy on 9/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "selectPhotosCollectionView.h"

@interface selectPhotosCollectionView ()

@end

@implementation selectPhotosCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavController];
    _assets = [[NSMutableArray alloc] init];
    objectsArray.addPhotosObjectArray = [[NSMutableArray alloc] init];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status)
     {
         switch (status) {
             case PHAuthorizationStatusAuthorized:
                 [self performSelectorOnMainThread:@selector(getAllPicture) withObject:nil waitUntilDone:NO];
                 // [self getAllPictures];
                 NSLog(@"PHAuthorizationStatusAuthorized");
                 break;
             case PHAuthorizationStatusRestricted:
                 NSLog(@"PHAuthorizationStatusRestricted");
                 break;
             case PHAuthorizationStatusDenied:
                 NSLog(@"PHAuthorizationStatusDenied");
                 break;
             default:
                 break;
         }
     }];
}

-(void)getAllPicture{
    NSLog(@"Started...");
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.synchronous = YES;
    PHFetchOptions *allPhotosOptions = [PHFetchOptions new];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:allPhotosOptions];
    for (PHAsset *asset in result) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:asset forKey:@"asset"];
        [_assets insertObject:dic atIndex:0];
        dic = nil;
    }
    NSLog(@"Completed...");
    NSLog(@"Assets count is %lu...", [_assets count]);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"Second Assets count is %lu...", [_assets count]);
    return [_assets count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *CellIdentifier = @"takePhotoCollectionCell";
        takePhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else{
        NSString *CellIdentifier = @"photoCollectionCell";
        
        photoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        // Configure the cell
        
        // load the asset for this cell
        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.synchronous = YES;
        
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestImageForAsset:[[_assets objectAtIndex:indexPath.row] valueForKey:@"asset"] //[INDEX_ARRAY][@"assest"]
                           targetSize:CGSizeMake(self.view.frame.size.width/3, 200)
                          contentMode:PHImageContentModeDefault
                              options:requestOptions
                        resultHandler:^void(UIImage *image, NSDictionary *info) {
                            cell.imageView.image = image;
                        }];
        
        NSLog(@"asset is %@",[[_assets objectAtIndex:indexPath.row] valueForKey:@"asset"]);
        PHAsset *asset = [[_assets objectAtIndex:indexPath.row]valueForKey:@"asset"];
        [asset requestContentEditingInputWithOptions:kNilOptions
                                   completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info) {
                                       NSURL *imageURL = contentEditingInput.fullSizeImageURL;
                                       NSLog(@"image url is %@",imageURL);
                                       cell.imageURL = imageURL;
                                   }];
        
        return cell;
    }
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {

        picker = [[UIImagePickerController alloc] init];
        self->picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark <UICollectionViewDelegate>

- (void) loadNavController{
    
    UIButton *btn1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,0,25,25);
    [btn1 setBackgroundImage:[UIImage imageNamed:@"closeButtonIcon"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonOne = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    
    UIButton *btn2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0,0,75,25);
    [btn2 setAttributedTitle:[[NSAttributedString alloc] initWithString:@"N E X T" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:15.0];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"buttonGreenBackground"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonTwo = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    space.width = 55;
    
    NSArray *buttons = @[buttonOne, space, buttonTwo];
    
    self.navigationController.navigationBar.topItem.title = nil;
    self.navigationController.navigationBar.topItem.leftBarButtonItems = buttons;
}

-(IBAction)backButtonPressed:(UIButton*)btn {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)nextButtonPressed:(UIButton*)btn {
    if ([objectsArray.addPhotosObjectArray count] > 3) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Do less"
                                     message:@"You are only allowed to upload three photos at a time. Stop being a showoff."
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        _spinner = [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _spinner.hidesWhenStopped = YES;
        _spinner.center = self.collectionView.center;
        [self.collectionView addSubview:_spinner];
        [_spinner startAnimating];

        int i = [store.imagesArray count];
        
        for(NSURL *url in objectsArray.addPhotosObjectArray){
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];                          //Data from photo library URL
            UIImage *image = [[UIImage alloc] initWithData:data];
            
            CGSize newSize = CGSizeMake(500.0f, 500.0f);                                        //Resize photo library photo
            UIGraphicsBeginImageContext(newSize);
            [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *imagePathName = [[@"image" stringByAppendingString:[@(i++) stringValue]] stringByAppendingString:@".png"];
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imagePathName];

            [UIImagePNGRepresentation(newImage) writeToFile:filePath atomically:YES];           //Write resized image to library
            
            NSURL *imageURL = [[NSURL alloc] initFileURLWithPath:filePath];                     //NSURL with resized saved photo
            NSLog(@"iamge path is %@",filePath);
            NSLog(@"image url is %@",imageURL);
                                                                                                //Updating Firebase
            NSString *imageKey = [[[[firebaseRef.ref child:@"images"] child:@"stores"] child:store.storeKey] childByAutoId].key;
            NSString *imageName = [imageKey stringByAppendingString:@".jpg"];
            [[[[[firebaseRef.ref child:@"images"] child:@"stores"] child:store.storeKey] child:imageKey] setValue:imageName];
            [[[[[[firebaseRef.ref child:@"imageAddedByUser"] child:@"stores"] child:store.storeKey] child:imageKey] child:user.userKey] setValue:@"true"];

            FIRStorage *storage = [FIRStorage storage];
            FIRStorageReference *storageRef = [storage reference];
            FIRStorageReference *spaceRef = [[[storageRef child:@"stores"] child:store.storeKey] child:imageName];

            FIRStorageUploadTask *uploadTask = [spaceRef putFile:imageURL metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
                if (error != nil) {
                    // Uh-oh, an error occurred!
                } else {
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    //                                                      NSURL *downloadURL = metadata.downloadURL;
                }
                
                if ( url == [ objectsArray.addPhotosObjectArray lastObject] ) {
                    [_spinner stopAnimating];
                }
            }];
        }
        
        NSString *activityKey = [[firebaseRef.ref  child:@"activityType"] childByAutoId].key;
        [[[[firebaseRef.ref  child:@"activityType"]  child:activityKey] child:@"type"] setValue:@"storeAddPhotos"];
        [[[[firebaseRef.ref  child:@"activityKey"]  child:user.userKey] child:activityKey] setValue:@"true"];
        [[[[firebaseRef.ref  child:@"activityObject"]  child:activityKey] child:store.storeKey] setValue:@"true"];
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Thank you!"
                                     message:@"Thank you for helping the community thrive. Your photos will help other enthusiasts."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self dismissViewControllerAnimated:YES completion:^{}];
                                   }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
