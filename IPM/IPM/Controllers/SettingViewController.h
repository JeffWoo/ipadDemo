//
//  SettingViewController.h
//  IPM
//
//  Created by apple on 13-9-3.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface SettingViewController : UIViewController

@property (nonatomic, assign) MainViewController *holderViewController;

- (IBAction)toggleLogoutButton:(UIButton *)sender;

@end
