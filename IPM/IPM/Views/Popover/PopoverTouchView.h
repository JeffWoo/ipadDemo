//
//  PopoverTouchView.h
//  Namecard
//
//  Created by Vincent Tam on 12-9-4.
//  Copyright (c) 2012年 Neon Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverViewController.h"

@interface PopoverTouchView : UIView

@property (assign, nonatomic) id<PopoverTouchesDelegate> delegate;

@end
