//
//  selectPhotosCollectionView.h
//  myProject
//
//  Created by Guy on 9/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "takePhotoCollectionViewCell.h"
#import "photoCollectionViewCell.h"
#import "storeClass.h"
#import "userClass.h"
#import "FirebaseReferenceClass.h"
#import "AssetsLibrary/AssetsLibrary.h"
@import Firebase;

@interface selectPhotosCollectionView : UICollectionViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController *picker;}

@property (copy, nonatomic) NSMutableArray *assets;

@end
