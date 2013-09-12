//
//  ResourceMapView.m
//  IPM
//
//  Created by Vincent on 13-3-24.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "ResourceMapView.h"

@implementation AddressAnnotation

- (NSString *)subtitle
{
	return nil;
}

- (NSString *)title
{
	return nil;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c
{
	self.coordinate=c;
	return self;
}

@end

@implementation ResourceMapView

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


- (void)dealloc
{
    [_mapView release];
    [_locationLabel release];
    [super dealloc];
}

- (void)updateCurrentLocation
{

}

#pragma mark - Pubic Methods

- (void)updateMapLocation
{
    self.mapView.userTrackingMode = MKUserTrackingModeNone;
//    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D theCoordinate;

    theCoordinate.latitude = 23.12781;
    theCoordinate.longitude = 113.344831;
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta = 0.01;
    theSpan.longitudeDelta = 0.01;
    
    MKCoordinateRegion theRegion;
    theRegion.center = theCoordinate;
    theRegion.span = theSpan;
    [self.mapView setRegion:theRegion];
    
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:theCoordinate];
    [self.mapView addAnnotation:addAnnotation];
    
    self.mapView.delegate = self;
    
    self.locationLabel.text = @"黄埔大道广东农信大厦";
    
//    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
//    self.locationManager.delegate = self;
//    
//    if([CLLocationManager locationServicesEnabled]) {
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        self.locationManager.distanceFilter = 1000.0f;
//        [self.locationManager startUpdatingLocation];
//        
//    } else {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法定位" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
//        [alert show];
//        [alert release];
//        
//    }
}

#pragma mark - CLLocationManager Delegate

//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//
//    CLLocationCoordinate2D theCoordinate;
//    
//    theCoordinate.latitude = newLocation.coordinate.latitude;
//    theCoordinate.longitude = newLocation.coordinate.longitude;
//    
//    if(theCoordinate.latitude < 22 || theCoordinate.latitude > 23)
//    {
//        theCoordinate.latitude = 22.299683;
//        theCoordinate.longitude = 114.172164;
//    }
//    MKCoordinateSpan theSpan;
//    theSpan.latitudeDelta = 0.05;
//    theSpan.longitudeDelta = 0.05;
//    
//    MKCoordinateRegion theRegion;
//    theRegion.center = theCoordinate;
//    theRegion.span = theSpan;
//    [self.mapView setRegion:theRegion];
//    
//    self.mapView.delegate = self;
//
//    
//}
//
//- (void)locationManager: (CLLocationManager *)manager
//       didFailWithError: (NSError *)error
//{
//    [self.locationManager stopUpdatingLocation];
//}

#pragma mark - LocationServiceDelegate
- (void)locateCurrentAddress:(NSString *)address city:(NSString *)city
{
    
}

- (void)failedFindPlace:(NSError *)error
{
    
}


- (void)locateCurrentLatitude:(NSString *)lat longitude:(NSString *)longit
{
    self.locationLabel.text = [NSString stringWithFormat:@"你当前的经纬坐标为:(%@,%@)",lat,longit];
}

- (void)failedToLocate:(NSError *)error
{

}

@end
