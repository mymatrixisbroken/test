//
//  priceStrainTableViewCell.h
//  myProject
//
//  Created by Guy on 10/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface priceStrainTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *strainNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *oneGramPrice;
@property (strong, nonatomic) IBOutlet UITextField *twoGramPrice;
@property (strong, nonatomic) IBOutlet UITextField *oneEigthPrice;
@property (strong, nonatomic) IBOutlet UITextField *oneFourthPrice;
@property (strong, nonatomic) IBOutlet UITextField *oneHalfPrice;
@property (strong, nonatomic) IBOutlet UITextField *oneOuncePrice;

@end
