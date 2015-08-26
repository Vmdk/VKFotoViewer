//
//  EEPhotoScrollView.m
//  VKFotoViewer
//
//  Created by robert on 8/26/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEPhotoScrollView.h"

@implementation EEPhotoScrollView {
    UIImageView* _currentImage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _currentImage = [[UIImageView alloc] initWithImage:_photo];
    _currentImage.frame = _photoScroller.frame;
    [_photoScroller addSubview:_currentImage];
    
    //_photoScroller.contentSize = _photo.size;
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [_photoScroller addGestureRecognizer:doubleTapRecognizer];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureDetected:)];
    [_currentImage addGestureRecognizer:pinchGestureRecognizer];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 4
    CGRect scrollViewFrame = _photoScroller.frame;
                NSLog([NSString stringWithFormat:@"%f %f",scrollViewFrame.size.width, scrollViewFrame.size.height]);
    CGFloat scaleWidth = scrollViewFrame.size.width / _photoScroller.contentSize.width;
                NSLog([NSString stringWithFormat:@"%f %f",_photoScroller.contentSize.width, _photoScroller.contentSize.height]);
    CGFloat scaleHeight = scrollViewFrame.size.height / _photoScroller.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    _photoScroller.minimumZoomScale = minScale;
    
    // 5
    _photoScroller.maximumZoomScale = 1.0f;
    _photoScroller.zoomScale = minScale;
    
    // 6
    [self centerScrollViewContents];
}
//
- (void)centerScrollViewContents {
    CGSize boundsSize = _photoScroller.bounds.size;
    CGRect contentsFrame = _currentImage.frame;
    
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
    
    _currentImage.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    CGPoint pointInView = [recognizer locationInView:_currentImage];

    CGFloat newZoomScale = _photoScroller.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, _photoScroller.maximumZoomScale);
    
    CGSize scrollViewSize = _photoScroller.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [_photoScroller zoomToRect:rectToZoomTo animated:YES];
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


#pragma mark - Scroll delegates
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return _currentImage;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}

#pragma mark - inits

- (instancetype)initPhoto:(UIImage*)img {
    self = [self init];
    _photo = img;
    return self;
}
@end
