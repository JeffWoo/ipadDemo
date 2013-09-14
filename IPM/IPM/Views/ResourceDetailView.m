//
//  ResourceDetailView.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ResourceDetailView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ResourceDetailView

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

- (void)setupViews
{
    self.authView.layer.borderWidth = 1;
    self.authView.layer.borderColor = [UIColor greenColor].CGColor;
    self.rentView.layer.borderWidth = 1;
    self.rentView.layer.borderColor = [UIColor redColor].CGColor;
    
//    UIImage *image = [self.photoBgImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
//    self.photoBgImageView.image = image;
    
    self.imageView.image = [UIImage imageNamed:@"pic1.jpg"];
    
    int xPos = 0;
    for (int i = 0; i < 6; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xPos, 0, 90, 90);
        
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pic%d.jpg",i+1]] forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleToFill;
        button.tag = i+1;
        [button addTarget:self action:@selector(touchImageButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:button];
        
        xPos += 90;
    }
    
    [self.scrollView setContentSize:CGSizeMake(640, self.scrollView.frame.size.height)];
}

- (void)touchImageButton:(UIButton *)sender
{
    int tag = sender.tag;
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%d.jpg",tag]];
}

- (void)dealloc
{

    [_authView release];
    [_rentView release];
    [_imageView release];
    [_scrollView release];
    [_photoBgImageView release];
    [super dealloc];
}
@end
