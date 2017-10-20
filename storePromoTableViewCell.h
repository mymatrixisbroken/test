//
//  storePromoTableViewCell.h
//  myProject
//
//  Created by Guy on 8/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface storePromoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *promoLikesLabel;
@property (strong, nonatomic) IBOutlet UILabel *promoDateLabel;
@property (strong, nonatomic) IBOutlet UITextView *promoTextLabel;

@end
