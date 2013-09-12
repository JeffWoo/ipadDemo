//
//  PopoverView.h
//  Namecard
//
//  Created by Vincent Tam on 12-9-4.
//  Copyright (c) 2012年 Neon Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverViewController.h"

@interface PopoverView : UIView

@property (assign, nonatomic) int cornerRadius;
@property (assign, nonatomic) CGPoint arrowPoint;
@property (assign, nonatomic) BOOL isGradient;
@property (retain, nonatomic) UIColor *baseColor;
@property (assign, nonatomic) PopoverArrowDirection arrowDirection;
@property (assign, nonatomic) PopoverArrowPosition arrowPosition;

- (UIImage *)backgroundImage;

@end
