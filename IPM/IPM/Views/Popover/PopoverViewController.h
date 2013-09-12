//
//  PopoverViewController.h
//  Namecard
//
//  Created by Vincent Tam on 12-9-4.
//  Copyright (c) 2012年 Neon Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverTouchesDelegate <NSObject>
- (void)view:(UIView *)view touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end


typedef enum PopoverArrowDirection{
    PopoverArrowDirectionTop = 0,
	PopoverArrowDirectionRight,
    PopoverArrowDirectionBottom,
    PopoverArrowDirectionLeft
}PopoverArrowDirection;

typedef enum PopoverArrowPosition{
    PopoverArrowPositionVertical = 0,
    PopoverArrowPositionHorizontal
}PopoverArrowPosition;

@protocol PopoverViewControllerDelegate <NSObject>
- (void)dismissPopover;
@end

@class PopoverView;

@interface PopoverViewController : UIViewController<PopoverTouchesDelegate>
{
    PopoverView * popoverView;
    PopoverArrowDirection arrowDirection;
    CGRect screenRect;
    int titleLabelheight;
}

@property (retain, nonatomic) UIViewController *contentViewController;
@property (retain, nonatomic) UIView *contentView;
@property (retain, nonatomic) NSString *titleText;
@property (retain, nonatomic) UIColor *titleColor;
@property (retain, nonatomic) UIFont *titleFont;
@property (retain, nonatomic) UIColor *popoverBaseColor;
@property (assign, nonatomic) int cornerRadius;
@property (assign, nonatomic) PopoverArrowPosition arrowPosition;
@property (assign, nonatomic) BOOL popoverGradient;
@property (assign, nonatomic) id<PopoverViewControllerDelegate> delegate;

- (id)initWithContentViewController:(UIViewController *)viewController;
- (id)initWithView:(UIView *)view;
- (void)showPopoverWithTouch:(UIEvent *)senderEvent;
- (void)showPopoverWithView:(UIView *)senderView;
- (void)showPopoverWithCell:(UITableViewCell *)senderCell;
- (void)showPopoverWithRect:(CGRect)senderRect;
- (void)showPopoverWithPoint:(CGPoint)senderPoint;
- (void)view:(UIView *)view touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)dismissPopoverAnimatd:(BOOL)animated;

@end
