//
//  badgesViewController.m
//  myProject
//
//  Created by Guy on 9/22/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "badgesViewController.h"

@implementation badgesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([user.badges indexOfObject:@"fiveStevias"] != NSNotFound) {
        _badgeOne.text = @"fiveStevias";
    }
    if ([user.badges indexOfObject:@"fiveIndicas"] != NSNotFound) {
        _badgeTwo.text = @"fiveIndicas";
    }
    if ([user.badges indexOfObject:@"fiveFriends"] != NSNotFound) {
        _badgeThree.text = @"fiveFriends";
    }
    if ([user.badges indexOfObject:@"fiveReviews"] != NSNotFound) {
        _badgeFour.text = @"fiveReviews";
    }
    if ([user.badges indexOfObject:@"fiveWishList"] != NSNotFound) {
        _badgeFive.text = @"fiveWishList";
    }
    if ([user.badges indexOfObject:@"fiveStrainsTried"] != NSNotFound) {
        _badgeSix.text = @"fiveStrainsTried";
    }
    if ([user.badges indexOfObject:@"fiveStoresVisited"] != NSNotFound) {
        _badgeSeven.text = @"fiveStoresVisited";
    }
    if ([user.badges indexOfObject:@"fiveCheckIns"] != NSNotFound) {
        _badgeEight.text = @"fiveCheckIns";
    }

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
