//
//  SARectangle.h
//  ShapeApp
// 
//  Created by Morgan Winer on 9/26/19.
//  Copyright © 2019 Apple. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface SARectangle : UIViewController

@property (strong, nonatomic) IBOutletCollection(id) NSArray *buttons;
- (IBAction)changeCornerRadius:(id)sender;
- (IBAction)changeBorder:(id)sender;
- (IBAction)changeOpacity:(id)sender;
- (IBAction)changeColor:(id)sender;
- (IBAction)changeBounds:(id)sender;
- (IBAction)changePosition:(id)sender;
- (IBAction)changeToPulse:(id)sender;
- (IBAction)changeShadow:(id)sender;
- (IBAction)changeAngle:(id)sender;


@end
