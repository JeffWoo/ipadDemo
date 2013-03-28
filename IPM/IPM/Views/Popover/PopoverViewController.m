//
//  PopoverViewController.m
//  Namecard
//
//  Created by Vincent Tam on 12-9-4.
//  Copyright (c) 2012年 Neon Studio. All rights reserved.
//

#import "PopoverViewController.h"
#import "PopoverTouchView.h"
#import "PopoverView.h"
#import <QuartzCore/QuartzCore.h>


#define kCornerRadius        5
#define kMargin              5
#define kOuterMargin         5
#define kTitleLabelHeight    25
#define kArrowSize           10
#define kArrowMagin          2

@interface PopoverViewController ()

- (CGPoint)senderPointFromSenderRect:(CGRect)senderRect;
- (CGRect)contentFrameRect:(CGRect)contentFrame senderPoint:(CGPoint)senderPoint;
- (CGRect)popoverFrameRect:(CGRect)contentFrame senderPoint:(CGPoint)senderPoint;
@end

@implementation PopoverViewController
@synthesize contentViewController;
@synthesize contentView;
@synthesize cornerRadius;
@synthesize titleText;
@synthesize titleColor;
@synthesize titleFont;
@synthesize arrowPosition;
@synthesize popoverBaseColor;
@synthesize popoverGradient;
@synthesize delegate;

- (id)init
{
    self = [super init];
	if (self) {

        self.cornerRadius = kCornerRadius;
        self.titleColor = [UIColor whiteColor];
        self.titleFont = [UIFont boldSystemFontOfSize:14];
        self.view.backgroundColor = [UIColor clearColor];
        self.arrowPosition = PopoverArrowPositionVertical;
        self.popoverBaseColor = [UIColor blackColor];
        self.popoverGradient = YES;
        
        screenRect = [[UIScreen mainScreen] bounds];
        self.view.frame = screenRect;
        screenRect.origin.y = 0;
        screenRect.size.height = screenRect.size.height-20;   
        
        titleLabelheight = 0;
	}
	return self;
}

- (id)initWithContentViewController:(UIViewController *)viewController
{
    self = [self init];
    
    self.contentViewController = viewController;
    self.contentView = viewController.view;
    
    return self;
}

- (id)initWithView:(UIView *)view
{
    self = [self init];
    self.contentView = view;
    
    return self;   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Public Methods 

- (void)showPopoverWithTouch:(UIEvent *)senderEvent
{    
    UIView *senderView = [[senderEvent.allTouches anyObject] view];
    CGPoint applicationFramePoint = CGPointMake(screenRect.origin.x,0-screenRect.origin.y);
    //CGPoint senderLocationInWindowPoint = [[[UIApplication sharedApplication] keyWindow] convertPoint:applicationFramePoint fromView:senderView];
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    CGPoint senderLocationInWindowPoint = [appWindow.rootViewController.view convertPoint:applicationFramePoint fromView:senderView];
    CGRect senderFrame = [[[senderEvent.allTouches anyObject] view] frame];
    senderFrame.origin.x = senderLocationInWindowPoint.x;
    senderFrame.origin.y = senderLocationInWindowPoint.y;
    CGPoint senderPoint = [self senderPointFromSenderRect:senderFrame];
//    CGPoint senderPoint = [self senderPointFromSenderRect:senderFrame];
    [self showPopoverWithPoint:senderPoint];
}

- (void)showPopoverWithView:(UIView *)senderView
{
    CGPoint applicationFramePoint = CGPointMake(screenRect.origin.x,0-screenRect.origin.y);
    //CGPoint senderLocationInWindowPoint = [[[UIApplication sharedApplication] keyWindow] convertPoint:applicationFramePoint fromView:senderView];
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    CGPoint senderLocationInWindowPoint = [appWindow.rootViewController.view convertPoint:applicationFramePoint fromView:senderView];
    CGRect senderFrame = [senderView frame];
    senderFrame.origin.x = senderLocationInWindowPoint.x;
    senderFrame.origin.y = senderLocationInWindowPoint.y;
    CGPoint senderPoint = [self senderPointFromSenderRect:senderFrame];
    //    CGPoint senderPoint = [self senderPointFromSenderRect:senderFrame];
    [self showPopoverWithPoint:senderPoint];
}

- (void)showPopoverWithCell:(UITableViewCell *)senderCell
{
    UIView *senderView = senderCell.superview;
    CGPoint applicationFramePoint = CGPointMake(screenRect.origin.x,0-screenRect.origin.y);
    CGPoint senderLocationInWindowPoint = [[[UIApplication sharedApplication] keyWindow] convertPoint:applicationFramePoint fromView:senderView];
    CGRect senderFrame = senderCell.frame;
    senderFrame.origin.x = senderLocationInWindowPoint.x;
    senderFrame.origin.y = senderLocationInWindowPoint.y + senderFrame.origin.y;
    CGPoint senderPoint = [self senderPointFromSenderRect:senderFrame];
    [self showPopoverWithPoint:senderPoint];
}

- (void)showPopoverWithRect:(CGRect)senderRect
{

    CGPoint senderPoint = [self senderPointFromSenderRect:senderRect];
    [self showPopoverWithPoint:senderPoint];
}

- (void)showPopoverWithPoint:(CGPoint)senderPoint
{
    if(self.titleText && self.titleText.length > 0){
        titleLabelheight = kTitleLabelHeight;
    }
    PopoverTouchView *touchView = [[PopoverTouchView alloc] init];
    touchView.frame = self.view.frame;
    [touchView setDelegate:self];
    
    [self.view addSubview:touchView];
    CGRect contentViewFrame = [self contentFrameRect:self.contentView.frame senderPoint:senderPoint];
    
    int backgroundPositionX = 0;
    int backgroundPositionY = 0;
    if(arrowDirection == PopoverArrowDirectionLeft){
        backgroundPositionX = kArrowSize;
    }
    if(arrowDirection == PopoverArrowDirectionTop){
        backgroundPositionY = kArrowSize;
    }
    
    UILabel *titleLabel = nil;
    if(self.titleText && self.titleText.length > 0){
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(backgroundPositionX, backgroundPositionY, contentViewFrame.size.width+kMargin*2, kTitleLabelHeight+kMargin)];
        titleLabel.textColor = self.titleColor;
        titleLabel.text = self.titleText;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.font = self.titleFont;
    }
    contentViewFrame.origin.x = backgroundPositionX+kMargin;
    contentViewFrame.origin.y = backgroundPositionY+titleLabelheight+kMargin;


    self.contentView.frame = contentViewFrame;
    CALayer * contentViewLayer = [self.contentView layer];
    [contentViewLayer setMasksToBounds:YES];
    [contentViewLayer setCornerRadius:self.cornerRadius];
    
    popoverView = [[PopoverView alloc] init];
    popoverView.arrowDirection = arrowDirection;
    popoverView.arrowPosition = self.arrowPosition;
    popoverView.arrowPoint = senderPoint;
    popoverView.alpha = 0;
    popoverView.frame = [self popoverFrameRect:contentViewFrame senderPoint:senderPoint];
    popoverView.cornerRadius = self.cornerRadius;
    popoverView.baseColor = self.popoverBaseColor;
    popoverView.isGradient = self.popoverGradient;
    [popoverView addSubview:self.contentView];
    
    if (titleLabel) {
        [popoverView addSubview:titleLabel];
    }

    CALayer* layer = popoverView.layer;
    layer.shadowOffset = CGSizeMake(0, 2);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowOpacity = 0.5;
    
    [self.view addSubview:popoverView];
    
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    //[appWindow addSubview:self.view];

    [appWindow.rootViewController.view addSubview:self.view];

    
    [UIView animateWithDuration:0.0
                          delay:0.0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         popoverView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                     }
     ];

}

- (void)view:(UIView *)view touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (delegate && [delegate respondsToSelector:@selector(dismissPopover)]) {
        [delegate dismissPopover];
    }
    [self dismissPopoverAnimatd:YES];
}


- (void)dismissPopoverAnimatd:(BOOL)animated
{
    if (self.view) {
        if(animated) {
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options:UIViewAnimationOptionAllowAnimatedContent
                             animations:^{
                                 popoverView.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 [self.contentViewController viewDidDisappear:animated];
                                 popoverView=nil;
                                 [self.view removeFromSuperview];
                                 self.contentViewController = nil;
                                 self.titleText = nil;
                                 self.titleColor = nil;
                                 self.titleFont = nil;
                             }
             ];
        }else{
            [self.contentViewController viewDidDisappear:animated];
            popoverView=nil;
            [self.view removeFromSuperview];
            self.contentViewController = nil;
            self.titleText = nil;
            self.titleColor = nil;
            self.titleFont = nil;
        }
        
    }
}

- (CGRect)contentFrameRect:(CGRect)contentFrame senderPoint:(CGPoint)senderPoint
{
    CGRect contentFrameRect = contentFrame;
    float screenWidth = screenRect.size.width;
    float screenHeight = screenRect.size.height - screenRect.origin.y;

    contentFrameRect.origin.x = kMargin;
    contentFrameRect.origin.y = kMargin;
    
    float statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;


    if(self.arrowPosition == PopoverArrowPositionVertical){
        if(contentFrameRect.size.width > self.view.frame.size.width - (kOuterMargin*2+kMargin*2)){
            contentFrameRect.size.width = self.view.frame.size.width - (kOuterMargin*2+kMargin*2);
        }
        
        float popoverY;
        float popoverHeight = contentFrameRect.size.height+titleLabelheight+(kArrowSize+kMargin*2);
        
        if(arrowDirection == PopoverArrowDirectionTop){
            popoverY = senderPoint.y+kArrowMagin;
            if((popoverY+popoverHeight) > screenHeight){
                contentFrameRect.size.height = screenHeight - (screenRect.origin.y + popoverY + titleLabelheight + (kOuterMargin*2+kMargin*2));
            }
        }
        
        if(arrowDirection == PopoverArrowDirectionBottom){
            popoverY = senderPoint.y - kArrowMagin;
            if((popoverY-popoverHeight) < statusBarHeight){
                contentFrameRect.size.height = popoverY - (statusBarHeight + kArrowSize + screenRect.origin.y + titleLabelheight + (kOuterMargin+kMargin*2));
            }
        }
    }else if(self.arrowPosition == PopoverArrowPositionHorizontal){
        if(contentFrameRect.size.height > screenHeight - (kOuterMargin*2+kMargin*2)){
            contentFrameRect.size.height = screenHeight - (kOuterMargin*2+kMargin*2);
        }
        
        float popoverX;
        float popoverWidth = contentFrameRect.size.width+(kArrowSize+kMargin*2);
        
        if(arrowDirection == PopoverArrowDirectionLeft){
            popoverX = senderPoint.x + kArrowMagin;
            if((popoverX+popoverWidth)> screenWidth - (kOuterMargin*2+kMargin*2)){
                contentFrameRect.size.width = screenWidth - popoverX - kArrowSize - (kOuterMargin*2+kMargin*2);
            }
        }
        
        if(arrowDirection == PopoverArrowDirectionRight){
            popoverX = senderPoint.x - kArrowMagin;
            if((popoverX-popoverWidth) < screenRect.origin.x+(kOuterMargin*2+kMargin*2)){
                contentFrameRect.size.width = popoverX - kArrowSize - (kOuterMargin*2+kMargin*2);
            }
        }
        
    }
    
    return contentFrameRect;
}


- (CGRect)popoverFrameRect:(CGRect)contentFrame senderPoint:(CGPoint)senderPoint
{
    CGRect popoverRect;
    float popoverWidth;
    float popoverHeight;
    float popoverX;
    float popoverY;

    if(self.arrowPosition == PopoverArrowPositionVertical){
        
        popoverWidth = contentFrame.size.width+kMargin*2;
        popoverHeight = contentFrame.size.height+titleLabelheight+(kArrowSize+kMargin*2);

        popoverX = senderPoint.x - (popoverWidth/2);
        if(popoverX < kOuterMargin) {
            popoverX = kOuterMargin;
        } else if((popoverX + popoverWidth)>self.view.frame.size.width) {
            popoverX = self.view.frame.size.width - (popoverWidth+kOuterMargin);
        }
        
        if(arrowDirection == PopoverArrowDirectionBottom){
            popoverY = senderPoint.y - popoverHeight - kArrowMagin;
        }else{
            popoverY = senderPoint.y + kArrowMagin;
        }
        
        popoverRect = CGRectMake(popoverX, popoverY, popoverWidth, popoverHeight);
        
    }else if(self.arrowPosition = PopoverArrowPositionHorizontal){
        
        popoverWidth = contentFrame.size.width+kArrowSize+kMargin*2;
        popoverHeight = contentFrame.size.height+titleLabelheight+kMargin*2;

        if(arrowDirection == PopoverArrowDirectionRight){
            popoverX = senderPoint.x - popoverWidth - kArrowMagin;
        }else{
            popoverX = senderPoint.x + kArrowMagin;
        }
        
        popoverY = senderPoint.y - (popoverHeight/2);
        if(popoverY < kOuterMargin){
            popoverY = kOuterMargin;
        }else if((popoverY + popoverHeight)>self.view.frame.size.height){
            popoverY = self.view.frame.size.height - (popoverHeight+kOuterMargin);
        }
        
        popoverRect = CGRectMake(popoverX, popoverY, popoverWidth, popoverHeight);

    }


    return popoverRect;
    
}

- (CGPoint)senderPointFromSenderRect:(CGRect)senderRect
{
    CGPoint senderPoint;
    [self checkArrowPosition:senderRect];
    
    if(arrowDirection == PopoverArrowDirectionTop){
        senderPoint = CGPointMake(senderRect.origin.x + (senderRect.size.width/2), senderRect.origin.y + senderRect.size.height);
    }else if(arrowDirection == PopoverArrowDirectionBottom){
        senderPoint = CGPointMake(senderRect.origin.x + (senderRect.size.width/2), senderRect.origin.y);
    }else if(arrowDirection == PopoverArrowDirectionRight){
        senderPoint = CGPointMake(senderRect.origin.x, senderRect.origin.y + (senderRect.size.height/2));
        senderPoint.y = senderPoint.y + screenRect.origin.y;
    }else if(arrowDirection == PopoverArrowDirectionLeft){
        senderPoint = CGPointMake(senderRect.origin.x + senderRect.size.width, senderRect.origin.y + (senderRect.size.height/2));
        senderPoint.y = senderPoint.y + screenRect.origin.y;
    }

    return senderPoint;
}

- (void)checkArrowPosition:(CGRect)senderRect
{
    float clearSpaceA=0;
    float clearSpaceB=0;
    if(self.arrowPosition == PopoverArrowPositionVertical){
        if(!arrowDirection){
            clearSpaceA = screenRect.origin.y + senderRect.origin.y;
            clearSpaceB = screenRect.size.height - (senderRect.origin.y+senderRect.size.height);
            if(clearSpaceA> clearSpaceB){
                if(clearSpaceA < titleLabelheight+10){
                    self.arrowPosition = PopoverArrowPositionHorizontal;
                    [self checkArrowPosition:senderRect];
                }else{
                    arrowDirection = PopoverArrowDirectionBottom;
                }
            }else{
                if(clearSpaceB < titleLabelheight+10){
                    self.arrowPosition = PopoverArrowPositionHorizontal;
                    [self checkArrowPosition:senderRect];
                }else{
                    arrowDirection = PopoverArrowDirectionTop;
                }
            }
        }
        
        
    }else if(self.arrowPosition == PopoverArrowPositionHorizontal){
        
        if(!arrowDirection){
            clearSpaceA = screenRect.origin.x + senderRect.origin.x;
            clearSpaceB = screenRect.size.width - (senderRect.origin.x+senderRect.size.width);
            if(clearSpaceA> clearSpaceB){
                if(clearSpaceA < 40){
                    self.arrowPosition = PopoverArrowPositionVertical;
                    [self checkArrowPosition:senderRect];
                }else{
                    arrowDirection = PopoverArrowDirectionRight;
                }
            }else{
                if(clearSpaceB < 40){
                    self.arrowPosition = PopoverArrowPositionVertical;
                    [self checkArrowPosition:senderRect];
                }else{
                    arrowDirection = PopoverArrowDirectionLeft;
                }
            }
        }
        
    }
}

@end
