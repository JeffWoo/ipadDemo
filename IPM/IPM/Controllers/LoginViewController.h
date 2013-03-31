//
//  LoginViewController.h
//  IPM
//
//  Created by Vincent on 13-3-23.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface LoginViewController : RootViewController

@property (retain, nonatomic) IBOutlet UIView *inputFrameView;
@property (retain, nonatomic) IBOutlet UITextField *usernameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)rememberPwdSwitchAction:(UISwitch *)sender;
- (IBAction)autoLoginSwitchAction:(UISwitch *)sender;
- (IBAction)loginButtonAction:(UIButton *)sender;

@end
