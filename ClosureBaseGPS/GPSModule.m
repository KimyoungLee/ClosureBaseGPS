//
//  GPSModule.m
//  ClosureBaseGPS
//
//  Created by Logicplant02 on 12. 8. 17..
//  Copyright (c) 2012년 lkm. All rights reserved.
//

#import "GPSModule.h"

@implementation GPSModule

@synthesize callbackBlock;

- (id)initWithCallback:(GPSModuleCallbackBlock)block
{
    if (self = [super init])
    {
        //콜백 선언
        self.callbackBlock = block;
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(runLocationManager:) userInfo:nil repeats:NO];
//    //gps 모듈 생성
//    m_locManager = [[CLLocationManager alloc] init];
//    [m_locManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
//    m_locManager.distanceFilter = kCLDistanceFilterNone;
//    [m_locManager setDelegate:self];
//    [m_locManager startUpdatingLocation];
    
    //member variables 초기화
    m_firstTime = 0.0f;
    return self;
}

- (void)runLocationManager:(NSTimer *)a_timer
{
    //gps 모듈 생성
    m_locManager = [[CLLocationManager alloc] init];
    [m_locManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    m_locManager.distanceFilter = kCLDistanceFilterNone;
    [m_locManager setDelegate:self];
    [m_locManager startUpdatingLocation];
}

- (void)calibratedGPSLocationWithCallback:(GPSModuleCallbackBlock)block
{
    //콜백 선언
    self.callbackBlock = block;

    //gps 모듈 생성
    m_locManager = [[CLLocationManager alloc] init];
    [m_locManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    m_locManager.distanceFilter = kCLDistanceFilterNone;
    [m_locManager setDelegate:self];
    [m_locManager startUpdatingLocation];

    //member variables 초기화
    m_firstTime = 0.0f;
}

- (void)throwCalibratedLocation:(NSTimer *)a_timer
{
    NSLog(@"throw firsttime:%f, currentTime:%f", m_firstTime, [[NSDate date] timeIntervalSince1970]);
    
    //sec.milsec 형태이므로 1초간 수집.
    if (m_firstTime + 1 < [[NSDate date] timeIntervalSince1970])
    {
        //1초간 수집했으면 타이머를 정지하고.
        [a_timer invalidate];
        
        //블록으로 함수 결과를 보낸다.
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([m_lati doubleValue], [m_longi doubleValue]);
        self.callbackBlock(loc);
        
        //메모리를 해제하고.
        m_locManager = nil;
        m_lati = nil;
        m_longi = nil;
    }
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"updated location. isHeading:%d", [CLLocationManager headingAvailable]);
    NSString *location = [NSString stringWithFormat:@"lat:%f longi:%f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];
    NSLog(@"location: %@", location);
    
    //nil에 delegate를 보내지 않기 위해 미리 위치 수집을 중단한다.
    [m_locManager stopUpdatingLocation];
    
    // 처음 초기화 용도로 수집한다.
    if (m_firstTime == 0.0f)
    {
        m_firstTime = [[NSDate date] timeIntervalSince1970];
        [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(throwCalibratedLocation:) userInfo:nil repeats:YES];
    }
    
    m_lati = [[NSNumber alloc] initWithDouble:newLocation.coordinate.latitude];
    m_longi = [[NSNumber alloc] initWithDouble:newLocation.coordinate.longitude];
}

@end
