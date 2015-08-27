//
//  EEFullPhotoCell.m
//  VKFotoViewer
//
//  Created by robert on 8/26/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEFullPhotoCell.h"

@implementation EEFullPhotoCell {
    BOOL _isZoomed;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _isZoomed = NO;
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [_scrollView addGestureRecognizer:doubleTapRecognizer];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setPhoto:(NSString *)photoURL {
    _image.image = [self createPhoto:photoURL];
}

- (UIImage *)createPhoto:(NSString*)photo {
    NSData *data =[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:photo]];
    return [UIImage imageWithData:data];
}

#pragma Gesture Recognizers` selectors
/*
 GestureRecognizers:
 * swipe        | change photo
 * tap          | zoom / rezoom
 * pan          | move
 * pinches      | zoom
 * rotation
 * long press
 */

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    if (_isZoomed) {
        CGPoint pointInView = [recognizer locationInView:_image];
        CGFloat newZoomScale = _scrollView.minimumZoomScale;
        CGSize scrollViewSize = _scrollView.bounds.size;
        
        CGFloat w = scrollViewSize.width / newZoomScale;
        CGFloat h = scrollViewSize.height / newZoomScale;
        CGFloat x = pointInView.x - (w / 2.0f);
        CGFloat y = pointInView.y - (h / 2.0f);
        
        CGRect rectToZoomTo = CGRectMake(x, y, w, h);
        _isZoomed = NO;
        [_scrollView zoomToRect:rectToZoomTo animated:YES];
    }
    else {
        CGPoint pointInView = [recognizer locationInView:_image];
        CGFloat newZoomScale = _scrollView.zoomScale * 2.0f;
        newZoomScale = MIN(newZoomScale, _scrollView.maximumZoomScale);
        CGSize scrollViewSize = _scrollView.bounds.size;
        
        CGFloat w = scrollViewSize.width / newZoomScale;
        CGFloat h = scrollViewSize.height / newZoomScale;
        CGFloat x = pointInView.x - (w / 2.0f);
        CGFloat y = pointInView.y - (h / 2.0f);
        
        CGRect rectToZoomTo = CGRectMake(x, y, w, h);
        _isZoomed = YES;
        [_scrollView zoomToRect:rectToZoomTo animated:YES];
    }
}

#pragma ZoomControllingMethods

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents {
    if (_scrollView.zoomScale > 1.0f) {
        _isZoomed = YES;
    }
    CGSize boundsSize = _scrollView.bounds.size;
    CGRect contentsFrame = _image.frame;
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
    _image.frame = contentsFrame;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _image;
}
@end
