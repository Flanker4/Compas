//
//  LLViewController.m
//  Compas
//
//  Created by flanker on 07.08.13.
//  Copyright (c) 2013 LOL. All rights reserved.
//

#import "LLViewController.h"
#import <QuartzCore/QuartzCore.h>

static double TEMP_ANGLE = 0;
static int i = 0;
static double angle[] = {M_PI_4,M_PI_2,M_PI,M_PI_4,3*M_PI_4};
@interface LLViewController (){
    
    IBOutlet UIView *_compasArrow;
}

@end

@implementation LLViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self locationManager];
}

-(void) viewWillAppear:(BOOL)animated{
    //self.arrowAngle = M_PI;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
//
// MARK: - Setters|Getters
//

-(void) setArrowAngle:(CGFloat)arrowAngle{
    /*CABasicAnimation* rotationAnimation = nil;
    rotationAnimation = (CABasicAnimation*)[_compasArrow.layer animationForKey:@"transform.rotation.z"];
    CGFloat currentAngle = 0;
    if (rotationAnimation!=nil) {
        CALayer *currentLayer = (CALayer *)[_compasArrow.layer presentationLayer];
        
        currentAngle = [(NSNumber *)[currentLayer  valueForKeyPath:@"transform.rotation.z"] floatValue];
        
        [_compasArrow.layer removeAnimationForKey:@"transform.rotation.z"];
       
    }
    arrowAngle=fmodf(arrowAngle, 2*M_PI);
    CGFloat duration =fabsf((arrowAngle-currentAngle)/M_PI_4);
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(arrowAngle );
    rotationAnimation.fromValue = @(currentAngle);
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;

    rotationAnimation.additive = YES;
    rotationAnimation.removedOnCompletion=NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    [_compasArrow.layer addAnimation:rotationAnimation forKey:@"transform.rotation.z"];*/
    _compasArrow.transform = CGAffineTransformMakeRotation(arrowAngle);
    _arrowAngle=arrowAngle;
}


-(CLLocationManager*) locationManager{
    if (_locationManager) {
        return _locationManager;
    }
    if ([CLLocationManager headingAvailable]==NO) {
        return nil;
    }
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
    _locationManager.distanceFilter=500;
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    _locationManager.headingFilter = 5;
    [_locationManager startUpdatingHeading];
    return _locationManager;
}



//
// MARK: - location delegate
//
-(void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    if (newHeading.headingAccuracy<0) {
        return;
    }
    CLLocationDirection theHeading = ((newHeading.trueHeading>0)?newHeading.trueHeading:newHeading.magneticHeading);
    NSLog(@"Heading = %f",theHeading);
    self.arrowAngle=-(((double)theHeading)*M_PI)/180.0f;
}
@end
