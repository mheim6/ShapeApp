//
//  SAPinchGesture.m
//  ShapeApp
//
//  Created by Monica on 2/22/21.
//

#import <Foundation/Foundation.h>
#import "SAShapeView.h"
#import "SAPinchGesture.h"
#import "SARectangle.h"

@interface SAPinchGesture () <UIScrollViewDelegate> {
    
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIImageView *imgView;
}
@end

@implementation SAPinchGesture

- (void)viewDidLoad {
    [super viewDidLoad];
    
    scrollView.minimumZoomScale = 1;
    scrollView.maximumZoomScale = 6.0;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Setup Image view frame
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        CGRect photoImageViewFrame;
        photoImageViewFrame.size = imgView.image.size;
        imgView.frame = photoImageViewFrame;
        scrollView.contentSize = photoImageViewFrame.size;
        
        // Set zoom to minimum zoom, Every time updateZoom method when you change image
        [self updateZoom];
    });
}

-(void)updateZoom {
    scrollView.minimumZoomScale = MIN(scrollView.bounds.size.width / imgView.image.size.width, scrollView.bounds.size.height / imgView.image.size.height);
    scrollView.zoomScale = scrollView.minimumZoomScale;
}

- (void)centerScrollViewContents {
    
    CGSize boundsSize = scrollView.bounds.size;
    CGRect contentsFrame = imgView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    imgView.frame = contentsFrame;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView1 {
    NSLog(@"scrollViewDidZoom");
    [self centerScrollViewContents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
