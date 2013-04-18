//
//  MainViewController.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "MainViewController.h"
#import "ProjectManagerViewController.h"
#import "ResourceManagerViewController.h"
#import "ClientManagerViewController.h"
#import "StaticsManagerViewController.h"
#import "DocManagerViewController.h"
#import "ProjectSearchView.h"
#import "PopoverViewController.h"

@interface MainViewController () <PopoverViewControllerDelegate,ProjectSearchViewDelegate>
{
    ProjectManagerViewController *_projectManagerController;
    ResourceManagerViewController *_resourceManagerController;
    ClientManagerViewController *_clientManagerController;
    StaticsManagerViewController *_staticsManagerController;
    DocManagerViewController *_docManagerController;
    
    PopoverViewController *_popover;
    ProjectSearchView *_searchView;
    
    UIButton *_currentSelectedButton;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_projectManagerController release];
    [_resourceManagerController release];
    [_clientManagerController release];
    [_staticsManagerController release];
    [_docManagerController release];
    
    [_popover release];
    
    [_projectButton release];
    [_titleLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _currentSelectedButton = self.projectButton;
    
    _projectManagerController = [[ProjectManagerViewController alloc] initWithNibName:@"ProjectManagerViewController" bundle:nil];
    _projectManagerController.view.frame = CGRectMake(72, 50, 952, 698);
    _projectManagerController.containerController = self;

    _resourceManagerController = [[ResourceManagerViewController alloc] initWithNibName:@"ResourceManagerViewController" bundle:nil];
    _resourceManagerController.view.frame = CGRectMake(72, 50, 952, 698);
    _resourceManagerController.containerController = self;

    _clientManagerController = [[ClientManagerViewController alloc] initWithNibName:@"ClientManagerViewController" bundle:nil];
    _clientManagerController.view.frame = CGRectMake(72, 50, 952, 698);
    _clientManagerController.containerController = self;
    
    _staticsManagerController = [[StaticsManagerViewController alloc] initWithNibName:@"StaticsManagerViewController" bundle:nil];
    _staticsManagerController.view.frame = CGRectMake(72, 50, 952, 698);
    _staticsManagerController.containerController = self;
    
    _docManagerController = [[DocManagerViewController alloc] initWithNibName:@"DocManagerViewController" bundle:nil];
    _docManagerController.view.frame = CGRectMake(72, 50, 952, 698);
    _docManagerController.containerController = self;
    
    self.currentPanelController = _projectManagerController;
    
}

- (void)setCurrentPanelController:(RootViewController *)currentPanelController
{
    [_currentPanelController.view removeFromSuperview];
    _currentPanelController = currentPanelController;
    
    [self.view addSubview:_currentPanelController.view];
}

- (IBAction)projectManagerAction:(UIButton *)sender
{
    self.titleLabel.text = @"项目管理";
    
    _currentSelectedButton.selected = NO;
    sender.selected = YES;
    _currentSelectedButton = sender;
    self.currentPanelController = _projectManagerController;
}

- (IBAction)resourceManagerAction:(UIButton *)sender
{
    self.titleLabel.text = @"资源管理";
    
    _currentSelectedButton.selected = NO;
    sender.selected = YES;
    _currentSelectedButton = sender;
    self.currentPanelController = _resourceManagerController;
}

- (IBAction)clientManagerAction:(UIButton *)sender
{
    self.titleLabel.text = @"客户管理";
    
    _currentSelectedButton.selected = NO;
    sender.selected = YES;
    _currentSelectedButton = sender;
    self.currentPanelController = _clientManagerController;
}

- (IBAction)staticsManagerAction:(UIButton *)sender
{
    self.titleLabel.text = @"统计分析";
    
    _currentSelectedButton.selected = NO;
    sender.selected = YES;
    _currentSelectedButton = sender;
    self.currentPanelController = _staticsManagerController;
}

- (IBAction)docManagerAction:(UIButton *)sender
{
    self.titleLabel.text = @"文档管理";
    
    _currentSelectedButton.selected = NO;
    sender.selected = YES;
    _currentSelectedButton = sender;
    self.currentPanelController = _docManagerController;
}

- (IBAction)notificationAction:(UIButton *)sender
{
//    _currentSelectedButton.selected = NO;
//    sender.selected = YES;
//    _currentSelectedButton = sender;
}

- (IBAction)syncAction:(UIButton *)sender
{
}

- (IBAction)settingAction:(UIButton *)sender forEvent:(UIEvent *)event
{
//    UIView *tagPopoverView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 160, 100)];
//    tagPopoverView.backgroundColor = [UIColor lightGrayColor];
//    
//    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    logoutButton.frame = CGRectMake(20,40, 120, 36);
//    [logoutButton setTitle:@"注销登录" forState:UIControlStateNormal];
//    [logoutButton setBackgroundImage:[UIImage imageNamed:@"btn_bg_grey"] forState:UIControlStateNormal];
//    [logoutButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
//    [tagPopoverView addSubview:logoutButton];
//    
//    [_popover release];
//    _popover = [[PopoverViewController alloc] initWithView:tagPopoverView];
//    [tagPopoverView release];
//    _popover.delegate = self;
//    [_popover showPopoverWithTouch:event];
}

- (void)logout:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)searchProjectAction:(UIButton *)sender forEvent:(UIEvent *)event
{
    if (self.currentPanelController == _projectManagerController) {
        
        if (_searchView) {
            [_searchView removeFromSuperview];
            _searchView = nil;
        } else {
            
            UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
            dismissButton.frame = self.view.bounds;
            [dismissButton addTarget:self action:@selector(dismissSearchViewAction:) forControlEvents:UIControlEventTouchUpInside];
            dismissButton.tag = 99;
            [self.view addSubview:dismissButton];
            
            _searchView = [[[NSBundle mainBundle] loadNibNamed:@"ProjectSearchView" owner:self options:nil] objectAtIndex:0];
            _searchView.delegate = self;
            [_searchView fillOptions];
            _searchView.frame = CGRectMake(94, 70, 908, 200);
            _searchView.layer.cornerRadius = 12.0;
            _searchView.layer.borderWidth = 1;
            _searchView.layer.borderColor = [UIColor darkGrayColor].CGColor;
            [self.view addSubview:_searchView];
        }
    }
}

- (void)dismissSearchViewAction:(UIButton *)sender
{
    if (_searchView) {
        [_searchView removeFromSuperview];
        _searchView = nil;
    }
    
    [sender removeFromSuperview];
}

#pragma mark - ProjectSearchViewDelegate
- (void)searchWithText:(NSString *)text
{
    if (_searchView) {
        [_searchView removeFromSuperview];
        _searchView = nil;
    }
    
    [[self.view viewWithTag:99] removeFromSuperview];
}


- (void)viewDidUnload
{
    [self setProjectButton:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
}
@end