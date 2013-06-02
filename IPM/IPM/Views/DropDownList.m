//
//  DropDownList.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "DropDownList.h"

@implementation DropDownList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *dropdownButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dropdownButton.frame = self.bounds;
        [dropdownButton setBackgroundImage:[UIImage imageNamed:@"dropdown_bg"] forState:UIControlStateNormal];
//        [dropdownButton setTitle:@"--请选择--" forState:UIControlStateNormal];
        dropdownButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//        dropdownButton.titleLabel.textColor = [UIColor blackColor];
        [dropdownButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [dropdownButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [dropdownButton addTarget:self action:@selector(toggleDropdown:forEvent:) forControlEvents:UIControlEventTouchUpInside];
        dropdownButton.tag = 123;
        [self addSubview:dropdownButton];
        
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *dropdownButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dropdownButton.frame = self.bounds;
        [dropdownButton setBackgroundImage:[UIImage imageNamed:@"dropdown_bg"] forState:UIControlStateNormal];
//        [dropdownButton setTitle:@"--请选择--" forState:UIControlStateNormal];
        dropdownButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//        dropdownButton.titleLabel.textColor = [UIColor blackColor];
        [dropdownButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [dropdownButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [dropdownButton addTarget:self action:@selector(toggleDropdown:forEvent:) forControlEvents:UIControlEventTouchUpInside];
        dropdownButton.tag = 123;
        [self addSubview:dropdownButton];
        
        
        //test
//        self.options = [NSMutableArray arrayWithObjects:@"测试选项1", @"测试选项2", @"测试选项3", @"测试选项4",nil];
        
    }
    
    return self;
}

- (void)dealloc
{
    [_options release];
    [_optionTitle release];
    
    [super dealloc];
}

- (void)setOptions:(NSMutableArray *)options
{
    _options = [options retain];
    if (_options && [_options isKindOfClass:[NSMutableArray class]] && _options.count > 0) {
        self.optionTitle = [_options objectAtIndex:0];
    }
}
- (void)setOptionTitle:(NSString *)optionTitle
{
    _optionTitle = [optionTitle copy];
    
     [(UIButton *)[self viewWithTag:123] setTitle:_optionTitle forState:UIControlStateNormal];
}

- (void)toggleDropdown:(UIButton *)sender forEvent:(UIEvent *)event
{
//    int senderY = 0;
//    UIView *iterView = sender;
//    while (iterView.superview) {
//        senderY += iterView.superview.frame.origin.y;
//        iterView = iterView.superview;
//    }
//    senderY += sender.frame.origin.y;
//    
//    int height = senderY > 600 ? 80 : 120;
    UIView *tagPopoverView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.bounds.size.width, 150)];
    tagPopoverView.backgroundColor = [UIColor lightGrayColor];
    
    UITableView *optionTable = [[UITableView alloc] initWithFrame:tagPopoverView.bounds style:UITableViewStylePlain];
    optionTable.delegate = self;
    optionTable.dataSource = self;
    [tagPopoverView addSubview:optionTable];
    [optionTable release];
    
    [_popover release];
    _popover = [[PopoverViewController alloc] initWithView:tagPopoverView];
    [tagPopoverView release];
    _popover.delegate = self;
    [_popover showPopoverWithTouch:event];
}

#pragma mark - PopoverViewControllerDelegate
- (void)dismissPopover
{
    
}

#pragma mark - UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.textLabel.text = [self.options objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [(UIButton *)[self viewWithTag:123] setTitle:[self.options objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [(UIButton *)[self viewWithTag:123] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_popover dismissPopoverAnimatd:YES];
}

@end
