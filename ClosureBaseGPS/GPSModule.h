//
//  GPSModule.h
//  ClosureBaseGPS
//
//  Created by Logicplant02 on 12. 8. 17..
//  Copyright (c) 2012년 lkm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^GPSModuleCallbackBlock)(CLLocationCoordinate2D);

@interface GPSModule : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *m_locManager;
    
    NSTimeInterval m_firstTime;
    NSNumber *m_lati, *m_longi;
}

@property (nonatomic, copy) GPSModuleCallbackBlock callbackBlock;

- (void)calibratedGPSLocationWithCallback:(GPSModuleCallbackBlock)block;

- (id)initWithCallback:(GPSModuleCallbackBlock)block;

@end
