//
//  ViewController.h
//  ClosureBaseGPS
//
//  Created by Logicplant02 on 12. 8. 17..
//  Copyright (c) 2012년 lkm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSModule.h"

@interface ViewController : UIViewController
{
    GPSModule *gps;
}
@property (strong, nonatomic) IBOutlet UITextView *textview;
@end
