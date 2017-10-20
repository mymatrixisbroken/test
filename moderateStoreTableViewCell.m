//
//  moderateStoreTableViewCell.m
//  myProject
//
//  Created by Guy on 9/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "moderateStoreTableViewCell.h"

@implementation moderateStoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_approveButton addTarget:self
                    action:@selector(tappedApproveButton:)
          forControlEvents:UIControlEventTouchUpInside];

    [_deleteButton addTarget:self
                       action:@selector(tappedDeleteButton:)
             forControlEvents:UIControlEventTouchUpInside];

    // Initialization code
}

- (void) tappedApproveButton:(UIButton *) button{
    NSLog(@"tag is %ld", (long)self.tag);


    _myStore = [[storeClass alloc] init];
    _myStore = [objectsArray.moderateStoresObjectArray objectAtIndex:self.tag];

    NSLog(@"store name is %@", _myStore.storeName);
    NSLog(@"store key is %@", _myStore.storeKey);

    NSLog(@"tapped approve");
    NSString *lowerString = [_storeName.text lowercaseString];
    NSArray *strings = [_cityStateZip.text componentsSeparatedByString:@", "];

    
    [[[firebaseRef.ref child:@"storeKeys"] child:_myStore.storeKey] setValue:@"true"];
    [[[[firebaseRef.ref child:@"storeNames"] child:_myStore.storeKey] child:@"name"] setValue:_storeName.text];
    [[[[firebaseRef.ref child:@"storeNames"] child:_myStore.storeKey] child:@"lowerName"] setValue:lowerString];
    [[[[firebaseRef.ref child:@"phoneNumbers"] child:_myStore.storeKey] child:@"phoneNumber"] setValue:_phoneNumber.text];
    [[[[firebaseRef.ref child:@"location"] child:_myStore.storeKey] child:@"address"] setValue:_address.text];
    [[[[firebaseRef.ref child:@"location"] child:_myStore.storeKey] child:@"latitude"] setValue:_myStore.latitude];
    [[[[firebaseRef.ref child:@"location"] child:_myStore.storeKey] child:@"longitude"] setValue:_myStore.longitude];
    [[[[firebaseRef.ref child:@"storeApprovedByUser"] child:user.userKey] child:_myStore.storeKey] setValue:@"true"];
    [[[[firebaseRef.ref child:@"storeAddedByUser"] child:_myStore.storeAddedByUser] child:_myStore.storeKey] setValue:@"true"];


    if (strings.count > 2){                                   //check snapshot is null
        [[[[firebaseRef.ref child:@"location"] child:_myStore.storeKey] child:@"city"] setValue:[strings objectAtIndex:0]];
        [[[[firebaseRef.ref child:@"location"] child:_myStore.storeKey] child:@"state"] setValue:[strings objectAtIndex:1]];
        [[[[firebaseRef.ref child:@"location"] child:_myStore.storeKey] child:@"zipcode"] setValue:[strings objectAtIndex:2]];
    }
    
    [[[firebaseRef.ref child:@"toBeReviewedStoreNames"] child:_myStore.storeKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedPhoneNumbers"] child:_myStore.storeKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedLocation"] child:_myStore.storeKey] removeValue];
    [[[firebaseRef.ref  child:@"toBeReviewedStoreAddedByUser"]  child:_myStore.storeKey] removeValue];

    
    [objectsArray.moderateStoresObjectArray removeObjectAtIndex:self.tag];
    [self setNeedsDisplay];
}
- (void) tappedDeleteButton:(UIButton *) button{
    _myStore = [[storeClass alloc] init];
    _myStore = [objectsArray.moderateStoresObjectArray objectAtIndex:self.tag];
    
    NSLog(@"store name is %@", _myStore.storeName);
    NSLog(@"store key is %@", _myStore.storeKey);
    
    NSLog(@"tapped delete");
    [[[firebaseRef.ref child:@"toBeReviewedStoreNames"] child:_myStore.storeKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedPhoneNumbers"] child:_myStore.storeKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedLocation"] child:_myStore.storeKey] removeValue];
    [[[firebaseRef.ref  child:@"toBeReviewedStoreAddedByUser"]  child:_myStore.storeKey] removeValue];
    
    [objectsArray.moderateStoresObjectArray removeObjectAtIndex:self.tag];
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
