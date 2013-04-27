//
//  CustomTextField.m
//  IPM
//
//  Created by Vincent on 13-4-23.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

//- (CGRect)textRectForBounds:(CGRect)bounds
//{
//    return CGRectInset(bounds, 10, 5);
//}
//
//- (CGRect)editingRectForBounds:(CGRect)bounds
//{
//    return CGRectInset(bounds, 10, 5);
//}

- (void)drawRect:(CGRect)rect
{
    UIImage *textFieldBackground = [[UIImage imageNamed:@"textview_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(15.0, 5.0, 15.0, 5.0)];
    [textFieldBackground drawInRect:[self bounds]];
}


@end

