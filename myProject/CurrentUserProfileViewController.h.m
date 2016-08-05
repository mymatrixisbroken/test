//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "CurrentUserProfileViewController.h"

@interface CurrentUserProfileViewController ()

@end

@implementation CurrentUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _usernameLabel.text = user.username;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedFriendsButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"currentUserProfileToFriendsListSegue" sender:self];
}

- (IBAction)tappedImageView:(UITapGestureRecognizer *)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped.
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        picker2 = [[UIImagePickerController alloc] init];
        self->picker2.delegate = self;
        [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:picker2 animated:YES completion:NULL];
        // Distructive button tapped.[self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        picker = [[UIImagePickerController alloc] init];
        self->picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:picker animated:YES completion:NULL];
        // OK button tapped. [self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.contentMode  = UIViewContentModeScaleAspectFit;
    [self.imageView setImage:image];
    
    
    CGSize size = CGSizeMake(500, 500);
    UIImage *sizedImage = [[self class] imageWithImage:self.imageView.image scaledToSize:size];
    NSData *encodedString = UIImagePNGRepresentation(sizedImage);
    NSLog(@"image encoded= %@", encodedString);
    
    NSURL *theURL = [NSURL URLWithString:@"https://api.imgur.com/3/image"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
    //Specify method of request(Get or Post)
    [theRequest setHTTPMethod:@"POST"];
    
    //Pass some default parameter(like content-type etc.)
    [theRequest setValue:@"Client-ID bceb6364428afba" forHTTPHeaderField:@"Authorization"];
    [theRequest setHTTPBody:encodedString];
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    
    
    NSDictionary *dataDictionaryResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:0 error:&theError];
    NSLog(@"url to send request= %@",theURL);
    NSLog(@"%@",dataDictionaryResponse);
    
    
    NSDictionary *output = [dataDictionaryResponse valueForKey:@"data"];
    user.image_name = [output valueForKey:@"link"];
    NSLog(@"url is %@", user.image_name);
    
    [[[firebaseRef.usersRef child:user.user_key] child:@"image_name"] setValue:user.image_name];

    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



@end
