//
//  LoginViewController.m
//  IPM
//
//  Created by Vincent on 13-3-23.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"登录";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)dealloc
{
    [_inputFrameView release];
    [_usernameTextField release];
    [_passwordTextField release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setInputFrameView:nil];
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [super viewDidUnload];
}

- (IBAction)rememberPwdSwitchAction:(UISwitch *)sender
{
}

- (IBAction)autoLoginSwitchAction:(UISwitch *)sender
{
}

- (IBAction)loginButtonAction:(UIButton *)sender
{
    MainViewController *controller = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


@end
