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
}

-(void) viewWillAppear:(BOOL)animated{
    //self.arrowAngle = M_PI;
}
-(void) setArrowAngle:(CGFloat)arrowAngle{
    CABasicAnimation* rotationAnimation = nil;
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

    [_compasArrow.layer addAnimation:rotationAnimation forKey:@"transform.rotation.z"];
    
    _arrowAngle=arrowAngle;
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];

    self.arrowAngle=angle[i++];
}
@end
