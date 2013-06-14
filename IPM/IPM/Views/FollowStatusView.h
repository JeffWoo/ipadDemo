//
//  FollowStatusView.h
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownList.h"
#import "ProjectManagerViewController.h"

@interface FollowStatusView : UIView

@property (retain, nonatomic) IBOutlet UIView *mainView;

@property (retain, nonatomic) IBOutlet DropDownList *hrFollowDropdownList;
@property (retain, nonatomic) IBOutlet DropDownList *stageDropdownList;
@property (retain, nonatomic) IBOutlet DropDownList *investDropdownList;
@property (retain, nonatomic) IBOutlet UIView *stageView;
@property (retain, nonatomic) IBOutlet UIView *stageView2;
@property (retain, nonatomic) IBOutlet UIView *attachView;

@property (assign, nonatomic) UIViewController *viewController;

- (void)setupViews;
- (IBAction)replyButtonAction:(UIButton *)sender;
- (IBAction)toggleViewDoc:(id)sender;

@end
