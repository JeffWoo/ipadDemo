//
//  PopoverView.h
//  Namecard
//
//  Created by Vincent Tam on 12-9-4.
//  Copyright (c) 2012年 Neon Studio. All rights reserved.
//

#import "PopoverView.h"

#define kMargin    5
#define kArrowSize 10

@implementation PopoverView
@synthesize cornerRadius;
@synthesize arrowPoint;
@synthesize arrowDirection;
@synthesize arrowPosition;
@synthesize baseColor;
@synthesize isGradient;


- (id)init
{
    self = [super init];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.baseColor = [UIColor blackColor];
        self.isGradient = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{    
    UIImage *backgroundImage = [self backgroundImage];
    [backgroundImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) blendMode:kCGBlendModeNormal alpha:1];
    
}

- (UIImage *)backgroundImage
{
    // Color
    CGFloat myRed=0,myGreen=0,myBlue=0,myWhite=0,alpha=1;
    UIColor *gradientBaseColor = self.baseColor;
    UIColor* gradientTopColor;
    UIColor* gradientMiddleColor;
    UIColor* gradientBottomColor;
    
    BOOL s = [gradientBaseColor getRed:&myRed green:&myGreen blue:&myBlue alpha:&alpha ];
    if(!s) {
        [gradientBaseColor getWhite:&myWhite alpha:&alpha];
    }

    if(myRed < 0) myRed = 0;
    if(myGreen < 0) myGreen = 0;
    if(myBlue < 0) myBlue = 0;
    if(myWhite < 0) myWhite = 0;
    
    if(myWhite > 0.0f){
        gradientTopColor = [UIColor colorWithWhite:myWhite+0.35f alpha:1];
        gradientMiddleColor = [UIColor colorWithWhite:myWhite+0.13f alpha:1];
        gradientBottomColor = [UIColor colorWithWhite:myWhite alpha:1];
    } else {
        gradientTopColor = [UIColor colorWithRed:myRed+0.35f green:myGreen+0.35f blue:myBlue+0.35f alpha: 1];
        gradientMiddleColor = [UIColor colorWithRed:myRed+0.13f green:myGreen+0.13f blue:myBlue+0.13f alpha: 1];
        gradientBottomColor = [UIColor colorWithRed:myRed green:myGreen blue:myBlue alpha: 1];
    }
    
    UIColor *arrowColor = gradientBottomColor;
    if(self.arrowDirection == PopoverArrowDirectionTop && self.isGradient){
        arrowColor = gradientTopColor;
    }
    
    // Size
    float bgSizeWidth = self.frame.size.width;
    float bgSizeHeight = self.frame.size.height;
    float bgRectSizeWidth = 0;
    float bgRectSizeHeight = 0;
    float bgRectPositionX = 0;
    float bgRectPositionY = 0;
    float arrowHead = 0;
    float arrowBase = kArrowSize+1;
    float arrowFirst =0;
    float arrowLast = 0;
    
    //CGPoint senderLocationInViewPoint = [self convertPoint:self.arrowPoint fromView:[[UIApplication sharedApplication] keyWindow]];
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    CGPoint senderLocationInViewPoint = [self convertPoint:self.arrowPoint fromView:appWindow.rootViewController.view];

    if(self.arrowPosition == PopoverArrowPositionVertical){
        bgRectSizeWidth = bgSizeWidth;
        bgRectSizeHeight = bgSizeHeight - kArrowSize;
        
        if(self.arrowDirection == PopoverArrowDirectionTop){
            bgRectPositionY = kArrowSize;
        }
        
        if(self.arrowDirection == PopoverArrowDirectionBottom){
            arrowHead = bgRectSizeHeight + kArrowSize;
            arrowBase = bgRectSizeHeight - 1;
        }
    }else if(self.arrowPosition == PopoverArrowPositionHorizontal){
        bgRectSizeWidth = bgSizeWidth - kArrowSize;
        bgRectSizeHeight = bgSizeHeight;
        
        if(self.arrowDirection == PopoverArrowDirectionLeft){
            bgRectPositionX = kArrowSize;
        }
        
        if(self.arrowDirection == PopoverArrowDirectionRight){
            arrowHead = bgRectSizeWidth + kArrowSize;
            arrowBase = bgRectSizeWidth - 1;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(bgSizeWidth, bgSizeHeight), NO, 0);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    

    
    NSArray* bgGradientColors = [NSArray arrayWithObjects: 
                                 (id)gradientBottomColor.CGColor, 
                                 (id)gradientBottomColor.CGColor, 
                                 (id)gradientMiddleColor.CGColor, 
                                 (id)gradientTopColor.CGColor, nil];
    CGFloat bgGradientLocations[] = {0,0.4, 0.5, 1};
    CGGradientRef bgGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)bgGradientColors, bgGradientLocations);
    
    
    // Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(bgRectPositionX, bgRectPositionY, bgRectSizeWidth, bgRectSizeHeight) cornerRadius: self.cornerRadius+kMargin];

    
    // Polygon Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    if(self.arrowPosition == PopoverArrowPositionVertical){
        
        arrowFirst = senderLocationInViewPoint.x-kArrowSize/2;
        arrowLast = senderLocationInViewPoint.x+kArrowSize/2;
        if(arrowFirst < bgRectPositionX + (self.cornerRadius+kMargin)){
            arrowFirst = bgRectPositionX + (self.cornerRadius+kMargin);
            arrowLast = arrowFirst + kArrowSize;
        }
        if(arrowLast > (bgRectPositionX + bgRectSizeWidth) - (self.cornerRadius+kMargin)){
            arrowLast = (bgRectPositionX + bgRectSizeWidth) - (self.cornerRadius+kMargin);
            arrowFirst = arrowLast -  kArrowSize;
        }
        [bezierPath moveToPoint: CGPointMake(arrowFirst, arrowBase)];
        [bezierPath addLineToPoint: CGPointMake(senderLocationInViewPoint.x, arrowHead)];
        [bezierPath addLineToPoint: CGPointMake(arrowLast, arrowBase)];
        
    }else if(self.arrowPosition == PopoverArrowPositionHorizontal){
        
        arrowFirst = senderLocationInViewPoint.y-kArrowSize/2;
        arrowLast = senderLocationInViewPoint.y+kArrowSize/2;
        
        if(arrowFirst < bgRectPositionY + (self.cornerRadius+kMargin)){
            arrowFirst = bgRectPositionY + (self.cornerRadius+kMargin);
            arrowLast = arrowFirst + kArrowSize;
        }

        if(arrowLast > (bgRectPositionY + bgRectSizeHeight) - (self.cornerRadius+kMargin)){
            arrowLast = (bgRectPositionY + bgRectSizeHeight) - (self.cornerRadius+kMargin);
            arrowFirst = arrowLast - kArrowSize;
        }

        [bezierPath moveToPoint: CGPointMake(arrowBase, arrowFirst)];
        [bezierPath addLineToPoint: CGPointMake(arrowHead, senderLocationInViewPoint.y)];
        [bezierPath addLineToPoint: CGPointMake(arrowBase, arrowLast)];
    }

    CGContextSaveGState(context);
    [arrowColor setFill];
    [bezierPath fill];
    [roundedRectanglePath appendPath:bezierPath];

    [roundedRectanglePath addClip];  
    
    [gradientBottomColor setFill];
    [roundedRectanglePath fill];
    if(self.arrowDirection == PopoverArrowDirectionTop){
        [arrowColor setFill];
        [bezierPath fill];
    }
    if(self.isGradient){
        CGContextDrawLinearGradient(context, bgGradient, CGPointMake(0, bgRectPositionY+20), CGPointMake(0, bgRectPositionY), 0);
    }
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(bgGradient);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
   
    return output;
}

@end
