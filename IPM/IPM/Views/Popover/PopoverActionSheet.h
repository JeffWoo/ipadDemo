//
//  PopoverActionSheet.h
//  Namecard
//
//  Created by Vincent Tam on 12-9-7.
//  Copyright (c) 2012年 Neon Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PopoverViewController;

@interface PopoverActionSheet : UIView
{
    PopoverViewController *popoverController ;
    NSMutableArray *buttonsMutableArray;
}

@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIFont *titleFont;
@property (strong, nonatomic) UIColor *popoverBaseColor;
@property (nonatomic) int cornerRadius;
@property (nonatomic) BOOL popoverGradient; 
@property (nonatomic) BOOL buttonGradient;
@property (nonatomic) BOOL titleShadow;
@property (strong, nonatomic) UIColor *titleShadowColor;
@property (nonatomic) CGSize titleShadowOffset;

- (id)initWithTitle:(NSString *)title;
- (void)cancelButtonWithTitle:(NSString *) title block:(void (^)()) block;
- (void)destructiveButtonWithTitle:(NSString *) title block:(void (^)()) block;
- (void)addButtonWithTitle:(NSString *) title block:(void (^)()) block;
- (void)addButtonWithTitle:(NSString *)title 
                     color:(UIColor*)color 
                titleColor:(UIColor*)titleColor 
               borderWidth:(NSUInteger)borderWidth 
               borderColor:(UIColor*)borderColor 
                     block:(void (^)())block;
- (void) showWithTouch:(UIEvent*)senderEvent;
- (void) showWithView:(UIView *)touchView;
- (void) showWithRect:(CGRect)senderRect;
- (void) showWithCell:(UITableViewCell*)senderCell;

@end
