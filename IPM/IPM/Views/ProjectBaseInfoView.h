//
//  ProjectBaseInfoView.h
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "BaseView.h"

@interface ProjectBaseInfoView : BaseView

@property (retain, nonatomic) IBOutlet RadioButton *signStatusSwitch;

- (void)setupView;

@end
