//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSDictionary *)createEmptyStrain{
    NSDictionary *dictionaryStrainCreate= @{@"strain_name": @"",
                                          @"strain_image":@"",
                                          @"THC":@"",
                                          @"species":@"",
                                          @"description":@"",
                                          @"rating_count":@"",
                                          @"rating_score":@"",
                                          @"stats":@"",
                                          @"grower":@"",
                                          @"available_at_venue":@""};
    return dictionaryStrainCreate;
}

- (NSDictionary *)strainStats{
    NSDictionary *strainStats= @{@"total_count":@"",
                                          @"monthly_count":@"",
                                          @"total_user_count":@""};
    return strainStats;
}

- (IBAction)AddStrainButton:(UIButton *)sender {
    self.ref = [[FIRDatabase database] reference];
    NSDictionary *dict = [self createEmptyStrain];
    _key = [[self.ref child:@"strain"] childByAutoId].key;
    [[[self.ref child:@"strain"] child:_key] setValue:dict];
    [self performSegueWithIdentifier:@"AddStrainSegue" sender:self];
    NSLog(@"%@", _key);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"AddStrainSegue"]){
        AddStrainController *controller = (AddStrainController *)segue.destinationViewController;
        controller.key = _key;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
