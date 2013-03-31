//
//  ResourceDetailViewController.m
//  IPM
//
//  Created by Vincent on 13-3-25.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ResourceDetailViewController.h"
#import "ResourceDetailView.h"
#import "ResourceDocView.h"
#import "ProjectClientView.h"
#import "ResourceStatusView.h"
#import "ResourceMapView.h"

@interface ResourceDetailViewController ()
{
    ResourceDetailView *_resourceDetailView;
    ProjectClientView *_projectClientView;
    ResourceDocView *_resourceDocView;
    ResourceStatusView *_resourceStatusView;
    ResourceMapView *_mapView;
}
@end

@implementation ResourceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"资源详情",@"资源文档",@"项目/客户关联",@"跟进情况",@"地图位置",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 6, 600, 32);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedAction:)forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentedControl;
    
    _resourceDetailView = [[[NSBundle mainBundle] loadNibNamed:@"ResourceDetailView" owner:self options:nil] objectAtIndex:0];
    [_resourceDetailView setupViews];
    _resourceDetailView.hidden = YES;
    [self.view addSubview:_resourceDetailView];
    
    _resourceDocView = [[[NSBundle mainBundle] loadNibNamed:@"ResourceDocView" owner:self options:nil] objectAtIndex:0];
    _resourceDocView.hidden = YES;
    [self.view addSubview:_resourceDocView];

    _projectClientView = [[[NSBundle mainBundle] loadNibNamed:@"ProjectClientView" owner:self options:nil] objectAtIndex:0];
    _projectClientView.hidden = YES;
    [self.view addSubview:_projectClientView];

    _resourceStatusView = [[[NSBundle mainBundle] loadNibNamed:@"ResourceStatusView" owner:self options:nil] objectAtIndex:0];
    _resourceStatusView.hidden = YES;
    [self.view addSubview:_resourceStatusView];

    _mapView = [[[NSBundle mainBundle] loadNibNamed:@"ResourceMapView" owner:self options:nil] objectAtIndex:0];
    _mapView.hidden = YES;
    [self.view addSubview:_mapView];
    
    self.currentView = _resourceDetailView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

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
            self.currentView = _resourceDetailView;
            break;
            
        case 1:
            self.currentView = _resourceDocView;
            break;
            
        case 2:
            self.currentView = _projectClientView;
            break;
            
        case 3:
            self.currentView = _resourceStatusView;
            break;
            
        case 4:
            self.currentView = _mapView;
            [_mapView updateCurrentLocation];
            [_mapView updateMapLocation];
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
