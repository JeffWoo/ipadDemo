//
//  LocationService.h
//  HappyEveryday
//
//  Created by Vincent on 13-2-17.
//  Copyright (c) 2013年 TeamX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MJGeocodingServices.h"

@protocol LocationServiceDelegate <NSObject>

- (void)locateCurrentAddress:(NSString *)address city:(NSString *)city;
- (void)locateCurrentLatitude:(NSString *)lat longitude:(NSString *)longit;
- (void)failedToLocate:(NSError *)error;
- (void)failedFindPlace:(NSError *)error;

@end

@interface LocationService : NSObject<CLLocationManagerDelegate, MJReverseGeocoderDelegate, MJGeocoderDelegate, MJPlacesFinderDelegate>
{
    CLLocationManager *locationManager;
	MJReverseGeocoder *reverseGeocoder;
	MJGeocoder *forwardGeocoder;
    MJPlacesFinder *placesfinder;
}



@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) MJReverseGeocoder *reverseGeocoder;
@property (nonatomic, retain) MJGeocoder *forwardGeocoder;
@property (nonatomic, retain) MJPlacesFinder *placesfinder;
@property (nonatomic, assign) id<LocationServiceDelegate> delegate;

+ (id)sharedService;

- (void)locate;

- (void)stop;

@end
