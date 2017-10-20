//
//  ModerateStrainTableViewCell.m
//  myProject
//
//  Created by Guy on 10/1/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "ModerateStrainTableViewCell.h"

@implementation ModerateStrainTableViewCell

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
    
    
    _myStrain = [[strainClass alloc] init];
    _myStrain = [objectsArray.moderateStrainsObjectArray objectAtIndex:self.tag];
    
    NSLog(@"store name is %@", _myStrain.strainName);
    NSLog(@"store key is %@", _myStrain.strainKey);
    
    NSLog(@"tapped approve");
    NSString *lowerString = [_strainNameField.text lowercaseString];
//    NSArray *strings = [_cityStateZip.text componentsSeparatedByString:@", "];
    NSString *cbdWithoutPercent = [_myStrain.cbd
                                     stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSString *thcWithoutPercent = [_myStrain.thc
                                     stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSString *cbnWithoutPercent = [_myStrain.cbn
                                     stringByReplacingOccurrencesOfString:@"%" withString:@""];

    
    
    [[[firebaseRef.ref child:@"strainKeys"] child:_myStrain.strainKey] setValue:@"true"];
    [[[[firebaseRef.ref child:@"strainNames"] child:_myStrain.strainKey] child:@"name"] setValue:_strainNameField.text];
    [[[[firebaseRef.ref child:@"strainNames"] child:_myStrain.strainKey] child:@"lowerName"] setValue:lowerString];
    [[[[firebaseRef.ref child:@"strainFamily"] child:_myStrain.strainKey] child:@"family"] setValue:_myStrain.family];
    [[[[firebaseRef.ref child:@"CBD"] child:_myStrain.strainKey] child:@"CBD"] setValue:cbdWithoutPercent];
    [[[[firebaseRef.ref child:@"THC"] child:_myStrain.strainKey] child:@"THC"] setValue:thcWithoutPercent];
    [[[[firebaseRef.ref child:@"CBN"] child:_myStrain.strainKey] child:@"CBN"] setValue:cbnWithoutPercent];
    [[[[firebaseRef.ref child:@"strainApprovedByUser"] child:user.userKey] child:_myStrain.strainKey] setValue:@"true"];
    [[[[firebaseRef.ref child:@"strainAddedByUser"] child:_myStrain.strainAddedByUser] child:_myStrain.strainKey] setValue:@"true"];


    
//    if (strings.count > 2){                                   //check snapshot is null
//        [[[[firebaseRef.ref child:@"location"] child:_myStrain.strainKey] child:@"city"] setValue:[strings objectAtIndex:0]];
//        [[[[firebaseRef.ref child:@"location"] child:_myStrain.strainKey] child:@"state"] setValue:[strings objectAtIndex:1]];
//        [[[[firebaseRef.ref child:@"location"] child:_myStrain.strainKey] child:@"zipcode"] setValue:[strings objectAtIndex:2]];
//    }
    
    [[[firebaseRef.ref child:@"toBeReviewedStrainNames"] child:_myStrain.strainKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedCBD"] child:_myStrain.strainKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedTHC"] child:_myStrain.strainKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedCBN"] child:_myStrain.strainKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedStrainFamily"] child:_myStrain.strainKey] removeValue];
    [[[firebaseRef.ref  child:@"toBeReviewedStrainAddedByUser"]  child:_myStrain.strainKey] removeValue];
    
    [objectsArray.moderateStrainsObjectArray removeObjectAtIndex:self.tag];
    [self setNeedsDisplay];
}
- (void) tappedDeleteButton:(UIButton *) button{
    _myStrain = [[strainClass alloc] init];
    _myStrain = [objectsArray.moderateStrainsObjectArray objectAtIndex:self.tag];

    NSLog(@"store name is %@", _myStrain.strainName);
    NSLog(@"store key is %@", _myStrain.strainKey);

    NSLog(@"tapped delete");
    [[[firebaseRef.ref child:@"toBeReviewedStrainNames"] child:_myStrain.strainKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedCBD"] child:_myStrain.strainKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedTHC"] child:_myStrain.strainKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedCBN"] child:_myStrain.strainKey] removeValue];
    [[[firebaseRef.ref child:@"toBeReviewedStrainFamily"] child:_myStrain.strainKey] removeValue];
    [[[firebaseRef.ref  child:@"toBeReviewedStrainAddedByUser"]  child:_myStrain.strainKey] removeValue];

    [objectsArray.moderateStrainsObjectArray removeObjectAtIndex:self.tag];
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
