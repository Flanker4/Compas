//
//  LLViewController.h
//  Compas
//
//  Created by flanker on 07.08.13.
//  Copyright (c) 2013 LOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LLViewController : UIViewController<CLLocationManagerDelegate>
@property (nonatomic) CGFloat arrowAngle;
@property (nonatomic,strong) CLLocationManager * locationManager;
@end
