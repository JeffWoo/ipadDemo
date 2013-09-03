//
//  ProjectInfoViewController.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ProjectInfoViewController.h"
#import "ProjectBaseInfoView.h"
#import "ClientInfoView.h"
#import "ResourceInfoView.h"
#import "ProjectDocView.h"
#import "FollowStatusView.h"
#import "ProjectConcludeView.h"

@interface ProjectInfoViewController ()
{
    ProjectBaseInfoView *_projectBaseInfoView;
    ClientInfoView *_clientInfoView;
    ResourceInfoView *_resourceInfoView;
    ProjectDocView *_projectDocView;
    FollowStatusView *_followStatusView;
    ProjectConcludeView *_projectConcludeView;
}
@end

@implementation ProjectInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"项目信息",@"客户信息",@"资源信息",@"项目文档",@"跟进情况",@"项目总结",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 6, 600, 32);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedAction:)forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentedControl;
    
    _projectBaseInfoView = [[[NSBundle mainBundle] loadNibNamed:@"ProjectBaseInfoView" owner:self options:nil] objectAtIndex:0];
    [_projectBaseInfoView setupView];
    _projectBaseInfoView.hidden = YES;
    [self.view addSubview:_projectBaseInfoView];
    
    _clientInfoView = [[[NSBundle mainBundle] loadNibNamed:@"ClientInfoView" owner:self options:nil] objectAtIndex:0];
    _clientInfoView.hidden = YES;
    [self.view addSubview:_clientInfoView];
    
    _resourceInfoView = [[[NSBundle mainBundle] loadNibNamed:@"ResourceInfoView" owner:self options:nil] objectAtIndex:0];
    _resourceInfoView.hidden = YES;
    [self.view addSubview:_resourceInfoView];
    
    _projectDocView = [[[NSBundle mainBundle] loadNibNamed:@"ProjectDocView" owner:self options:nil] objectAtIndex:0];
    [_projectDocView setupView];
    _projectDocView.containerController = self;
    _projectDocView.hidden = YES;
    [self.view addSubview:_projectDocView];
    
    _followStatusView = [[[NSBundle mainBundle] loadNibNamed:@"FollowStatusView" owner:self options:nil] objectAtIndex:0];
    [_followStatusView setupViews];
    _followStatusView.viewController = self;
    _followStatusView.hidden = YES;
    [self.view addSubview:_followStatusView];
    
    _projectConcludeView = [[[NSBundle mainBundle] loadNibNamed:@"ProjectConcludeView" owner:self options:nil] objectAtIndex:0];
    _projectConcludeView.hidden = YES;
    [self.view addSubview:_projectConcludeView];
    
    self.currentView = _projectBaseInfoView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)segmentedAction:(UISegmentedControl *)segmentedControl
{
    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
            self.currentView = _projectBaseInfoView;
            break;
            
        case 1:
            self.currentView = _clientInfoView;
            break;
            
        case 2:
            self.currentView = _resourceInfoView;
            break;
            
        case 3:
            self.currentView = _projectDocView;
            break;
            
        case 4:
            self.currentView = _followStatusView;
            break;
            
        case 5:
            self.currentView = _projectConcludeView;
            break;
            
        default:
            break;
    }
}

- (void)setCurrentView:(UIView *)currentView
{
    _currentView.hidden = YES;
    _currentView = currentView;
    _currentView.hidden = NO;
}

@end
