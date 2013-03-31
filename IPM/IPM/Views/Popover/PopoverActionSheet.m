//
//  PopoverActionSheet.m
//  Namecard
//
//  Created by Vincent Tam on 12-9-7.
//  Copyright (c) 2012年 Neon Studio. All rights reserved.
//

#import "PopoverActionSheet.h"
#import "PopoverViewController.h"

#define kCornerRaduis         5
#define kBorder               5
#define kTitleShadowOffset    CGSizeMake(0, -1)
#define kButtonHeight         35

@implementation PopoverActionSheet
@synthesize cornerRadius = _cornerRadius;
@synthesize titleColor = _titleColor;
@synthesize titleFont = _titleFont;
@synthesize popoverBaseColor = _popoverBaseColor;
@synthesize popoverGradient = _popoverGradient;
@synthesize buttonGradient = _buttonGradient;
@synthesize titleShadow = _titleShadow;
@synthesize titleShadowColor = _titleShadowColor;
@synthesize titleShadowOffset = _titleShadowOffset;

- (id)initWithTitle:(NSString *)title 
{
    if ((self = [super init]))
    {
        self.frame = CGRectMake(0,0, 200, 300);
        buttonsMutableArray = [[NSMutableArray alloc] init];
        self.cornerRadius = kCornerRaduis;
        self.buttonGradient = YES;
        self.titleShadow = YES;
        self.titleColor = [UIColor whiteColor];
        self.titleShadowOffset = kTitleShadowOffset;
        self.titleShadowColor = [UIColor blackColor];
        
        popoverController = [[PopoverViewController alloc] init];
        popoverController.titleText = title;
        popoverController.titleFont = [UIFont boldSystemFontOfSize:14];
        popoverController.popoverBaseColor = [UIColor blackColor];
        popoverController.popoverGradient = YES;
    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title 
                     color:(UIColor*)color 
                titleColor:(UIColor*)titleColor 
               borderWidth:(NSUInteger)borderWidth 
               borderColor:(UIColor*)borderColor 
                     block:(void (^)())block
{
    [buttonsMutableArray addObject:[NSArray arrayWithObjects:
                                    block ? [block copy] : [NSNull null],
                                    title,
                                    color,
                                    titleColor,
                                    [NSNumber numberWithInteger:borderWidth],
                                    borderColor,
                                    nil]];
}

- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block 
{
    [self addButtonWithTitle:title
                       color:[UIColor grayColor]
                  titleColor:[UIColor whiteColor]
                 borderWidth:0
                 borderColor:[UIColor blackColor]
                       block:block];
}

- (void)destructiveButtonWithTitle:(NSString *)title block:(void (^)())block
{
    [self addButtonWithTitle:title
                       color:[UIColor redColor]
                  titleColor:[UIColor whiteColor]
                 borderWidth:0
                 borderColor:[UIColor blackColor]
                       block:block];
}

- (void)cancelButtonWithTitle:(NSString *)title block:(void (^)())block
{
    [self addButtonWithTitle:title
                       color:[UIColor blackColor]
                  titleColor:[UIColor whiteColor]
                 borderWidth:0
                 borderColor:[UIColor blackColor]
                       block:block];
}


- (void) showWithTouch:(UIEvent*)senderEvent
{
    [self buildButtons];
    [popoverController showPopoverWithTouch:senderEvent];
}

- (void) showWithView:(UIView *)touchView
{
    [self buildButtons];
    [popoverController showPopoverWithView:touchView];
}

- (void) showWithCell:(UITableViewCell*)senderCell
{
    [self buildButtons];
    [popoverController showPopoverWithCell:senderCell];
}

- (void) showWithRect:(CGRect)senderRect
{
    [self buildButtons];
    [popoverController showPopoverWithRect:senderRect];
    
}

- (void) buildButtons
{
    NSUInteger i = 1;
    NSUInteger buttonHeight = kButtonHeight;
    NSUInteger buttonY = kBorder;
    for (NSArray *button in buttonsMutableArray)
    {
        NSString *title = [button objectAtIndex:1];
        UIColor *color = [button objectAtIndex:2];
        UIColor *titleColor = [button objectAtIndex:3];
        NSUInteger borderWidth = [[button objectAtIndex:4]intValue];
        UIColor *borderColor = [button objectAtIndex:5];
        
        UIImage *image = [self buttonImage:color borderWidth:borderWidth borderColor:borderColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kBorder, buttonY, self.bounds.size.width-kBorder*2, buttonHeight);
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        button.titleLabel.minimumFontSize = 6;
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.titleLabel.textAlignment = UITextAlignmentCenter;
        button.backgroundColor = [UIColor clearColor];
        button.tag = i++;
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        button.accessibilityLabel = title;
        
        if(self.titleShadow){
            [button setTitleShadowColor:self.titleShadowColor forState:UIControlStateNormal];
            button.titleLabel.shadowOffset = self.titleShadowOffset;
        }
        
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        buttonY += buttonHeight + kBorder;
        
    }
    CGRect frame = self.frame;
    frame.size.height = buttonY;
    self.frame = frame;
    
    popoverController.contentView = self;
    popoverController.cornerRadius = self.cornerRadius;
    popoverController.popoverBaseColor = self.popoverBaseColor;
    popoverController.popoverGradient = self.popoverGradient;
    popoverController.titleColor = self.titleColor;
}


- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated 
{
    if (buttonIndex >= 0 && buttonIndex < [buttonsMutableArray count])
    {
        id obj = [[buttonsMutableArray objectAtIndex: buttonIndex] objectAtIndex:0];
        if (![obj isEqual:[NSNull null]])
        {
            ((void (^)())obj)();
        }
    }
    
    if (animated)
    {
        [popoverController dismissPopoverAnimatd:YES];
        [self removeFromSuperview];
    }
    else
    {
        [popoverController dismissPopoverAnimatd:NO];
        [self removeFromSuperview];
    }
}

#pragma mark - Action

- (void)buttonClicked:(id)sender 
{
    int buttonIndex = [sender tag] - 1;
    [self dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

#pragma mark - UIImage

-(UIImage*)buttonImage:(UIColor*)color borderWidth:(NSUInteger)borderWidth borderColor:(UIColor*)borderColor
{
    
    float buttonWidth = self.frame.size.width - (kBorder*2);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(buttonWidth, kButtonHeight), NO, 0);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray* gradientColors = [NSArray arrayWithObjects: 
                               (id)[UIColor colorWithWhite:1.0 alpha:0.4].CGColor, 
                               (id)[UIColor colorWithWhite: 1.0 alpha: 0.3].CGColor, 
                               (id)[UIColor colorWithWhite: 1.0 alpha: 0.2].CGColor, 
                               (id)[UIColor clearColor].CGColor, 
                               (id)[UIColor colorWithWhite: 1.0 alpha: 0.1].CGColor, 
                               (id)[UIColor colorWithWhite:1.0 alpha:0.2].CGColor, nil];
    CGFloat gradientLocations[] = {0, 0.1, 0.49, 0.5, 0.51, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, ( CFArrayRef)gradientColors, gradientLocations);
    
    
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, buttonWidth, kButtonHeight) cornerRadius: self.cornerRadius];
    [color setFill];
    [roundedRectanglePath fill];
    
    
    if(self.buttonGradient){

        UIBezierPath* gradientPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, buttonWidth, kButtonHeight) cornerRadius: self.cornerRadius];
        CGContextSaveGState(context);
        [gradientPath addClip];
        CGContextDrawLinearGradient(context, gradient, CGPointMake(buttonWidth/2, 0), CGPointMake(buttonWidth/2, kButtonHeight), 0);
        CGContextRestoreGState(context);
    }
    
    
    if(borderWidth >0)
    {
        if(!borderColor) borderColor = [UIColor blackColor];
        [borderColor setStroke];
        roundedRectanglePath.lineWidth = borderWidth;
        [roundedRectanglePath stroke];
    }
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return output;
}

@end
