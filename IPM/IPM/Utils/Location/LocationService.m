//
//  LocationService.m
//  HappyEveryday
//
//  Created by Vincent on 13-2-17.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import "LocationService.h"

static LocationService *instance = nil;

@implementation LocationService
@synthesize locationManager, reverseGeocoder, forwardGeocoder, placesfinder;
@synthesize delegate;


+ (id)sharedService
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[LocationService alloc] init];
        }
    }
    
    return instance;
}


- (id)init
{
    self = [super init];
    if (self) {
        ;
    }
    
    return self;
}


- (void)dealloc
{
	[locationManager release];
	[reverseGeocoder release];
	[forwardGeocoder release];

    [super dealloc];
}

- (void)locate
{
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	locationManager.delegate = self;
	[locationManager startUpdatingLocation];
}

- (void)stop
{
    [locationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (delegate && [delegate respondsToSelector:@selector(locateCurrentLatitude:longitude:)]) {
        [delegate locateCurrentLatitude:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] longitude:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude]];
    }
    
    [locationManager stopUpdatingLocation];
    
	//show network indicator
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	//reverse-geocode location
	self.reverseGeocoder = [[[MJReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate] autorelease];
	reverseGeocoder.delegate = self;
	[reverseGeocoder start];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [locationManager stopUpdatingLocation];
    
    if (delegate && [delegate respondsToSelector:@selector(failedToLocate:)]) {
        [delegate failedToLocate:error];
    }
}


#pragma mark -
#pragma mark MJReverseGeocoderDelegate

- (void)reverseGeocoder:(MJReverseGeocoder *)geocoder didFindAddress:(Address *)addressComponents
{
	//hide network indicator
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	NSString *address = [NSString stringWithFormat:@"%@%@%@%@",
                        addressComponents.stateCode,
                        addressComponents.city,
                        addressComponents.route,
                        addressComponents.streetNumber];
    
    if (delegate && [delegate respondsToSelector:@selector(locateCurrentAddress:city:)]) {
        [delegate locateCurrentAddress:address city:addressComponents.city];
    }
}


- (void)reverseGeocoder:(MJReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
	//show network indicator
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (delegate && [delegate respondsToSelector:@selector(failedFindPlace:)]) {
        [delegate failedFindPlace:error];
    }
}


#pragma mark -
#pragma mark MJGeocoderDelegate

- (void)geocoder:(MJGeocoder *)geocoder didFindLocations:(NSArray *)locations
{
	//hide network indicator
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)geocoder:(MJGeocoder *)geocoder didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSLog(@"GEOCODE ERROR CODE: %d", [error code]);
    
    if([error code] == 1){
        NSLog(@"NO GEOCODE RESULTS");
    }
}


#pragma mark -
#pragma mark MJGeocoderDelegate

- (void)placesFinder:(MJPlacesFinder *)placesFinder didFindPlaces:(NSArray *)places
{
    //hide network indicator
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}

- (void)placesFinder:(MJPlacesFinder *)placesFinder didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSLog(@"PLACE SEARCH ERROR CODE: %d", [error code]);
    
    if([error code] == 1){
        NSLog(@"NO PLACE RESULTS");
        
        
    }else if([error code] == 6){
        NSLog(@"%@", [error localizedDescription]);
        
        
    }
}

@end
