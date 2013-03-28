//
//  ResourceMapView.h
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationService.h"

@interface ResourceMapView : UIView<CLLocationManagerDelegate,MKMapViewDelegate>


@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, retain) CLLocationManager *locationManager;

- (void)updateMapLocation;
- (void)updateCurrentLocation;

@end
