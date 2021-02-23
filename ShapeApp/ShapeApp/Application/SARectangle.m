//
//  SARectangle.m
//  ShapeApp
// 
//  Created by Morgan Winer on 9/26/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "SARectangle.h"
#import "ViewController.h"
#define ORIGINAL_POSITION CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 150)
#define MOVED_POSITON CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 200)

@interface SARectangle ()
@property (nonatomic, strong) CALayer *rectangleLayer;
@property (assign) BOOL layerIsFlipped;

@end

@implementation SARectangle


+ (NSString *)displayName {
    return @"Rectangle Class Animation";
}




- (id)init {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ((self = [storyboard instantiateViewControllerWithIdentifier:@"SARectangle"])) {
        self.rectangleLayer = [CALayer layer];
        self.rectangleLayer.bounds = CGRectMake(0, 0, 150, 150);
        self.rectangleLayer.position = ORIGINAL_POSITION;
        self.rectangleLayer.backgroundColor = [UIColor blueColor].CGColor;
        self.rectangleLayer.borderColor = [UIColor blackColor].CGColor;
        self.rectangleLayer.opacity = 1.0f;
        [self.view.layer addSublayer:self.rectangleLayer];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [[self class] displayName];

    for (UIButton *button in self.buttons) {
        button.layer.cornerRadius = 5.0f;
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [UIColor colorWithRed:0.083 green:0.394 blue:0.979 alpha:1.000].CGColor;
    }
    
}



-(IBAction)changeColor:(id)sender {
    CGColorRef greenColor = [UIColor greenColor].CGColor;
    CGColorRef blueColor = [UIColor blueColor].CGColor;
    self.rectangleLayer.backgroundColor = (self.rectangleLayer.backgroundColor == greenColor) ? blueColor : greenColor;

}

-(IBAction)changeBorder:(id)sender {
    self.rectangleLayer.borderWidth = (self.rectangleLayer.borderWidth == 0.0f) ? 15.0f : 0.0f;
}

-(IBAction)changeBounds:(id)sender {
    
    [self  adjustWidthOfLayer:self.rectangleLayer by:self.rectangleLayer.bounds.size.width == self.rectangleLayer.bounds.size.height ? 100 : -100];}

- (void)adjustWidthOfLayer:(CALayer*)layer by:(CGFloat)value {
    layer.bounds = CGRectMake(layer.bounds.origin.x, layer.bounds.origin.y, layer.bounds.size.width + value, layer.bounds.size.height);
}


-(IBAction)changeOpacity:(id)sender {
    self.rectangleLayer.opacity = (self.rectangleLayer.opacity == 1.0f) ? 0.2f : 1.0f;
}

-(IBAction)changePosition:(id)sender {
    self.rectangleLayer.position = self.rectangleLayer.position.y == ORIGINAL_POSITION.y ? MOVED_POSITON : ORIGINAL_POSITION;
}

-(IBAction)changeCornerRadius:(id)sender {
    self.rectangleLayer.cornerRadius = (self.rectangleLayer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
}

-(IBAction)changeToPulse:(id)sender {
    
    if ([self.rectangleLayer animationForKey:@"pulseAnimation"]) {
        [self.rectangleLayer removeAllAnimations];
        self.rectangleLayer.transform = CATransform3DMakeScale(1, 1, 1);
        return;
    }
    self.rectangleLayer.transform = CATransform3DMakeScale(0.90, 0.90, 1);

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.autoreverses = YES;
    animation.duration = 0.35;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount =animation.repeatCount == 0 ? HUGE_VALF : 0;
    [self.rectangleLayer addAnimation:animation forKey:@"pulseAnimation"];
}



- (UIBezierPath*)bezierPathWithCurvedShadowForRect:(CGRect)rect {
    
    CGFloat offset = 15.0;
    CGFloat curve = 3.0;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint topLeft         = rect.origin;
    CGPoint bottomLeft     = CGPointMake(0.0, CGRectGetHeight(rect) + offset);
    CGPoint bottomMiddle = CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect) - curve);
    CGPoint bottomRight     = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) + offset);
    CGPoint topRight     = CGPointMake(CGRectGetWidth(rect), 0.0);
    
    [path moveToPoint:topLeft];
    [path addLineToPoint:bottomLeft];
    [path addQuadCurveToPoint:bottomRight controlPoint:bottomMiddle];
    [path addLineToPoint:topRight];
    [path addLineToPoint:topLeft];
    [path closePath];
    
    return path;
}

-(IBAction)changeShadow:(id)sender{
    self.rectangleLayer.shadowOffset = CGSizeMake(0, 3);
    self.rectangleLayer.shadowOpacity = 0.80;
    self.rectangleLayer.shadowRadius = 6.0f;
    self.rectangleLayer.shadowColor = [UIColor darkGrayColor].CGColor;
    
    self.rectangleLayer.shadowPath = (self.rectangleLayer.shadowPath) ? nil : [self bezierPathWithCurvedShadowForRect:self.rectangleLayer.bounds].CGPath;

}

-(IBAction)changeAngle:(id)sender{
    if (self.layerIsFlipped) {
        self.rectangleLayer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
    }
    else {
        self.rectangleLayer.transform = CATransform3DMakeRotation(-1, 0, 1, 0);
    }
    self.layerIsFlipped = !self.layerIsFlipped;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
