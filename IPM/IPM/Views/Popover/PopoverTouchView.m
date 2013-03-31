//
//  PopoverTouchView.h
//  Namecard
//
//  Created by Vincent Tam on 12-9-4.
//  Copyright (c) 2012年 Neon Studio. All rights reserved.
//

#import "PopoverTouchView.h"

@implementation PopoverTouchView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate view:self touchesBegan:touches withEvent:event];
}

@end
