//
//  FillCaptionViewController.m
//  testCollage
//
//  Created by Serhii Kostiuk on 09.09.16.
//  Copyright © 2016 Serhii Kostiuk. All rights reserved.
//

#import "FillCaptionViewController.h"

@interface FillCaptionViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UITextField *bottomCaptionTextField;
@property (weak, nonatomic) IBOutlet UIView *captionBackgroundView;

@end

@implementation FillCaptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bottomCaptionTextField becomeFirstResponder];
    [self registerForKeyboardNotifications];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    
}

#pragma mark -
#pragma mark Keyboard

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification object:nil];
}


- (void)keyboardDidChangeFrame:(NSNotification *)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat captionBackgroundViewHeight = self.captionBackgroundView.frame.size.height;
    CGFloat newCaptionOriginY = screenHeight-kbSize.height-captionBackgroundViewHeight;

    [UIView animateWithDuration:0.2 animations:^{
        self.captionBackgroundView.frame = CGRectMake(self.captionBackgroundView.frame.origin.x,
                                                      newCaptionOriginY,
                                                      self.captionBackgroundView.frame.size.width,
                                                      self.captionBackgroundView.frame.size.height);
    }];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.contentScrollView.contentInset = contentInsets;
    self.contentScrollView.scrollIndicatorInsets = contentInsets;
}
@end
