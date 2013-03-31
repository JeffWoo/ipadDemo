//
//  RootViewController.m
//  IPM
//
//  Created by Vincent on 13-3-23.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    UITapGestureRecognizer *_gestureRecognizer;
}
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)setEnableForTextInput:(BOOL)enableForTextInput
{
    _enableForTextInput = enableForTextInput;
    if (_enableForTextInput) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillHideNotification object:nil];
            
        } else {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        }
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *notificationDic = [notification userInfo];
    NSTimeInterval animationDuration = [[notificationDic objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardRect = [[notificationDic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat offset = 0;
    BOOL keyboarDispayed;
    if (keyboardRect.origin.y >= self.view.frame.size.height) {
        offset = 0;
        keyboarDispayed = NO;
    } else {
        offset = -keyboardRect.size.height;
        keyboarDispayed = YES;
    }
    
    if (keyboarDispayed) {
        
        _gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        _gestureRecognizer.cancelsTouchesInView = YES;
        [self.view addGestureRecognizer:_gestureRecognizer];
    }
    
    CGRect frame = self.view.frame;
    frame.origin.y = offset;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    return YES;
}


@end
