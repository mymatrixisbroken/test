//
//  photoCollectionViewCell.m
//  myProject
//
//  Created by Guy on 9/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "photoCollectionViewCell.h"

@implementation photoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tappedCell:)];
    [self.contentView addGestureRecognizer:singleFingerTap];
}

-(void)tappedCell:(UITapGestureRecognizer *)tapGesture{
    _selectButton.selected = !_selectButton.selected;
    if (_selectButton.selected) {
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"selectPhotoIcon"] forState:UIControlStateSelected];
        [_selectButton setHighlighted:NO];
        //Add to objects array
        
        NSLog(@"Cell image url is %@",self.imageURL);
        NSLog(@"Array count is %lu",[objectsArray.addPhotosObjectArray count]);

        [objectsArray.addPhotosObjectArray addObject:self.imageURL];
    } else {
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"unselectPhotoIcon"] forState:UIControlStateNormal];
        //Remove from objects array
        
        NSLog(@"Remove Array count is %lu",[objectsArray.addPhotosObjectArray count]);
        [objectsArray.addPhotosObjectArray removeObject:self.imageURL];
    }
}

@end
