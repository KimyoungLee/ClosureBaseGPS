//
//  ViewController.m
//  ClosureBaseGPS
//
//  Created by Logicplant02 on 12. 8. 17..
//  Copyright (c) 2012년 lkm. All rights reserved.
//
//githubdyd 네 추가.
#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize textview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    __block NSInteger a = 1;
    NSLog(@"a : %d", a);
	// Do any additional setup after loading the view, typically from a nib.
    //gps = [[GPSModule alloc] initWithCallback:^(NSString *title)
    //GPSModule *
    gps = [[GPSModule alloc] initWithCallback:^(CLLocationCoordinate2D loc)
    //[[GPSModule alloc] calibratedGPSLocationWithCallback:^(CLLocationCoordinate2D loc)
    {
        //NSLog(@"module callback : %@", title);
        //self.textview.text = [self.textview.text stringByAppendingString:title];

        //메모리 해제
        //gps = nil;
        NSLog(@"send!!!! loc lat:%f, longi:%f", loc.latitude, loc.longitude);
        a = 3;
        NSLog(@"a : %d", a);
    }];
    a = 2;
    NSLog(@"a : %d", a);
    NSLog(@"viewDidLoad()");
    //[gps logGPS:@"show me the money"];
}

- (void)viewDidUnload
{
    [self setTextview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)getGPSCoordinate:(id)sender {
    __block GPSModule *gpsm = [[GPSModule alloc] initWithCallback:^(CLLocationCoordinate2D loc)
           {
               self.textview.text = [self.textview.text stringByAppendingString:[NSString stringWithFormat:@"lat:%f, longi:%f\n", loc.latitude, loc.longitude]];
               NSLog(@"send!!!! loc lat:%f, longi:%f", loc.latitude, loc.longitude);
               //메모리 해제
               gpsm = nil;
           }];

}
@end
