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
    //[self syncronizeFrames];
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [_scrollView addGestureRecognizer:doubleTapRecognizer];
    
}
- (void)syncronizeFrames {
    
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
    //CGSize SVContentSize = _scrollView.contentSize;
    //NSLog([NSString stringWithFormat:@"%f %f %f",SVContentSize.height/ SVContentSize.width, SVContentSize.height, SVContentSize.width ]);
    // The scroll view has zoomed, so we need to re-center the contents
    if (_scrollView.zoomScale > 1.0f) {
        _isZoomed = YES;
        [self setFrameWhileZoomed];
    }
    else {
        _isZoomed = NO;
    }
}

- (void)setFrameWhileZoomed {
    //offset
    CGPoint currOfs = _scrollView.contentOffset;
    //size of the device's screen
    CGSize boundsSize = _scrollView.bounds.size;
    //size of current ScrollView
    CGSize SVContentSize = _scrollView.contentSize;
    NSLog([NSString stringWithFormat:@"%f %f %f",SVContentSize.height/ SVContentSize.width, SVContentSize.height, SVContentSize.width ]);
    //real photoSize
    CGSize contentsFrame = _image.image.size;
    float photoCoef = (contentsFrame.height / contentsFrame.width);
    float screenCoef = boundsSize.height / boundsSize.width;
    BOOL lFullHight = ( photoCoef - screenCoef) > 0;
    
    
    // a2 = (x1*y2)/y1 - x1
    if (lFullHight) {
        float coefByHeight = contentsFrame.height / boundsSize.height;
        float lWidthDiffer = (boundsSize.width * coefByHeight) - contentsFrame.width;
        float lCoef = boundsSize.width / (lWidthDiffer + contentsFrame.width);
        _scrollView.contentSize = CGSizeMake(contentsFrame.width * lCoef * _scrollView.zoomScale, _scrollView.contentSize.height);
    }
    else {
        float coefByWidth = contentsFrame.width / boundsSize.width;
        float lHightDiffer = (boundsSize.height * coefByWidth) - contentsFrame.width;
        float lCoef = boundsSize.height / (lHightDiffer + contentsFrame.height);
        _scrollView.contentSize = CGSizeMake(SVContentSize.width, lCoef * contentsFrame.height * _scrollView.zoomScale);
        //_scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x, _scrollView.contentOffset.y + lCoef * contentsFrame.height);
        SVContentSize = _scrollView.contentSize;
        NSLog([NSString stringWithFormat:@"%f %f %f",SVContentSize.height/ SVContentSize.width, SVContentSize.height, SVContentSize.width ]);
        currOfs = _scrollView.contentOffset;
        NSLog([NSString stringWithFormat:@"%f %f",currOfs.x,currOfs.y ]);
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _image;
}
@end
