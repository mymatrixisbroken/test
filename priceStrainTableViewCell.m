//
//  priceStrainTableViewCell.m
//  myProject
//
//  Created by Guy on 10/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "priceStrainTableViewCell.h"

@implementation priceStrainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _oneGramPrice.attributedText = [[NSAttributedString alloc] initWithString:@"$--" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]}];
    _twoGramPrice.attributedText = [[NSAttributedString alloc] initWithString:@"$--" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]}];
    _oneEigthPrice.attributedText = [[NSAttributedString alloc] initWithString:@"$--" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]}];
    _oneFourthPrice.attributedText = [[NSAttributedString alloc] initWithString:@"$--" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]}];
    _oneHalfPrice.attributedText = [[NSAttributedString alloc] initWithString:@"$--" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]}];
    _oneOuncePrice.attributedText = [[NSAttributedString alloc] initWithString:@"$--" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]}];

    [_oneGramPrice addTarget:self
                      action:@selector(attributeDidChange:)
            forControlEvents:UIControlEventEditingDidBegin];
    
    [_twoGramPrice addTarget:self
                      action:@selector(attributeDidChange:)
            forControlEvents:UIControlEventEditingDidBegin];
    
    [_oneEigthPrice addTarget:self
                       action:@selector(attributeDidChange:)
             forControlEvents:UIControlEventEditingDidBegin];
    
    [_oneFourthPrice addTarget:self
                      action:@selector(attributeDidChange:)
            forControlEvents:UIControlEventEditingDidBegin];
    
    [_oneHalfPrice addTarget:self
                      action:@selector(attributeDidChange:)
            forControlEvents:UIControlEventEditingDidBegin];
    
    [_oneOuncePrice addTarget:self
                       action:@selector(attributeDidChange:)
             forControlEvents:UIControlEventEditingDidBegin];

    //********************************************************************************
    
    [_oneGramPrice addTarget:self
                      action:@selector(attributeDidEndEditing:)
            forControlEvents:UIControlEventEditingDidEnd];
    
    [_twoGramPrice addTarget:self
                      action:@selector(attributeDidEndEditing:)
            forControlEvents:UIControlEventEditingDidEnd];
    
    [_oneEigthPrice addTarget:self
                       action:@selector(attributeDidEndEditing:)
             forControlEvents:UIControlEventEditingDidEnd];
    
    [_oneFourthPrice addTarget:self
                        action:@selector(attributeDidEndEditing:)
              forControlEvents:UIControlEventEditingDidEnd];
    
    [_oneHalfPrice addTarget:self
                      action:@selector(attributeDidEndEditing:)
            forControlEvents:UIControlEventEditingDidEnd];
    
    [_oneOuncePrice addTarget:self
                       action:@selector(attributeDidEndEditing:)
             forControlEvents:UIControlEventEditingDidEnd];
}

-(void) attributeDidChange:(UITextField *) textField{
    if ([textField.text isEqualToString:@"$--"]) {
        textField.font = [UIFont fontWithName:@"NEXA LIGHT" size:15.0];
        textField.attributedText = [[NSAttributedString alloc] initWithString:@"$" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]}];
        
        NSInteger i = +1;
        UITextPosition *beginning = [textField beginningOfDocument];
        UITextPosition *newPosition = [textField positionFromPosition:beginning offset:i];
        [textField setSelectedTextRange:[textField textRangeFromPosition:newPosition
                                                              toPosition:newPosition]];

    }
    else{
        UITextPosition *end =  [textField endOfDocument];
        [textField setSelectedTextRange:[textField textRangeFromPosition:end
                                                              toPosition:end]];
    }
}

-(void) attributeDidEndEditing:(UITextField *) textField{
    if ([textField.text isEqualToString:@"$"]) {
        textField.attributedText = [[NSAttributedString alloc] initWithString:@"$--" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]}];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
