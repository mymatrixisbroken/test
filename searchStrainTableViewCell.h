//
//  searchStrainTableViewCell.h
//  myProject
//
//  Created by Guy on 10/8/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchStrainTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *strainNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *familyLabel;
@property (strong, nonatomic) IBOutlet UILabel *cbnPercentLabel;
@property (strong, nonatomic) IBOutlet UILabel *cbdPercentLabel;
@property (strong, nonatomic) IBOutlet UILabel *thcPercentLabel;

@end
