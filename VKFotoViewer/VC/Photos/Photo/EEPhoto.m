//
//  EEPhoto.m
//  VKFotoViewer
//
//  Created by robert on 8/12/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEPhoto.h"

@implementation EEPhoto {
    NSDictionary* _photoInfo;
}
/*
 GestureRecognizers:
 * swipe        | change photo
 * tap          | zoom(?)
 * pan          | move
 * pinches      | zoom(?)
 * rotation
 * long press
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    _photoView.image = _photo;
    _photoView.userInteractionEnabled = YES;
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureDetected:)];
    [pinchGestureRecognizer setDelegate:self];
    [_photoView addGestureRecognizer:pinchGestureRecognizer];
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [panGestureRecognizer setDelegate:self];
    [_photoView addGestureRecognizer:panGestureRecognizer];
}


//zooming
- (void)pinchGestureDetected:(UIPinchGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat scale = [recognizer scale];
        [recognizer.view setTransform:CGAffineTransformScale(recognizer.view.transform, scale, scale)];
        [recognizer setScale:1.0];
    }
}

//touch, move
- (void)panGestureDetected:(UIPanGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
}

@end
