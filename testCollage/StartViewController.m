//
//  StartViewController.m
//  testCollage
//
//  Created by Serhii Kostiuk on 09.09.16.
//  Copyright © 2016 Serhii Kostiuk. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, retain)   UIImagePickerController         *imagePickerController;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)showGallery:(id)sender {
    self.imagePickerController.delegate = self;
    [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (UIImagePickerController *)imagePickerController {
    if (nil == _imagePickerController) {
        self.imagePickerController = [UIImagePickerController new];
    }
    return _imagePickerController;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.imageView removeFromSuperview];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.image = image;
    self.imageView = [[UIImageView alloc] initWithImage:image];
    
//    self.scrollView.contentMode = UIViewContentModeScaleAspectFill;
//    self.scrollView.contentOffset = CGPointZero;
//    self.scrollView.contentInset = UIEdgeInsetsZero;
//    
//    [self.scrollView addSubview:self.imageView];
//    
//    self.scrollView.contentSize = self.imageView.frame.size;
//    
//    [self configureZoomScale];
    
    //    UIView *subView = [self.scrollView.subviews objectAtIndex:0];
    //
    //    CGFloat offsetX = MAX((self.scrollView.bounds.size.width - self.scrollView.contentSize.width) * 0.5, 0.0);
    //    CGFloat offsetY = MAX((self.scrollView.bounds.size.height - self.scrollView.contentSize.height) * 0.5, 0.0);
    //
    //    subView.center = CGPointMake(self.scrollView.contentSize.width * 0.5 + offsetX,
    //                                 self.scrollView.contentSize.height * 0.5 + offsetY);
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
        [self.navigationController.navigationBar setHidden:NO];
    }];
}

@end
