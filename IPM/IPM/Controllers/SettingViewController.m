//
//  SettingViewController.m
//  IPM
//
//  Created by apple on 13-9-3.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)toggleLogoutButton:(UIButton *)sender
{
    [self.holderViewController.mypopoverController dismissPopoverAnimated:NO];
    [self.holderViewController.navigationController popViewControllerAnimated:YES];
}

@end
