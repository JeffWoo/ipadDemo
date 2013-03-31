//
//  MainViewController.h
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "RootViewController.h"

@interface MainViewController : RootViewController

@property (assign,nonatomic) RootViewController *currentPanelController;
@property (retain, nonatomic) IBOutlet UIButton *projectButton;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)projectManagerAction:(UIButton *)sender;
- (IBAction)resourceManagerAction:(UIButton *)sender;
- (IBAction)clientManagerAction:(UIButton *)sender;
- (IBAction)staticsManagerAction:(UIButton *)sender;
- (IBAction)notificationAction:(UIButton *)sender;
- (IBAction)docManagerAction:(UIButton *)sender;
- (IBAction)syncAction:(UIButton *)sender;
- (IBAction)settingAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)searchProjectAction:(UIButton *)sender;

@end
