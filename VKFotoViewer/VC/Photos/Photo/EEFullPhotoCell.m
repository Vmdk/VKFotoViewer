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
    
    UITapGestureRecognizer *oneTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewOnceTapped:)];
    oneTapRecognizer.numberOfTapsRequired = 1;
    oneTapRecognizer.numberOfTouchesRequired = 1;
    [_scrollView addGestureRecognizer:oneTapRecognizer];
    
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

-(void)scrollViewOnceTapped:(UITapGestureRecognizer*)recognizer {
    if (_shareButton.isEnabled) {
        [UIView animateWithDuration:0.3f animations: ^{
            _buttonView.alpha = 0.0f;
            _shareButton.enabled = false;
            _likeButton.enabled = false;
            _commentButton.enabled = false;
        }];
    }
    else {
        [UIView animateWithDuration:0.3f animations: ^{
            _buttonView.alpha = 0.5f;
            _shareButton.enabled = true;
            _likeButton.enabled = true;
            _commentButton.enabled = true;
        }];
    }
}
#pragma ZoomControllingMethods

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    //CGSize SVContentSize = _scrollView.contentSize;
    //NSLog([NSString stringWithFormat:@"%f %f %f",SVContentSize.height/ SVContentSize.width, SVContentSize.height, SVContentSize.width ]);
    // The scroll view has zoomed, so we need to re-center the contents
    if (_scrollView.zoomScale > 1.0f) {
        _isZoomed = YES;
    }
    else {
        _isZoomed = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    CGSize SVContentSize = _scrollView.contentSize;
    //real photoSize
    CGSize contentsFrame = _image.image.size;
    float coefByWidth = contentsFrame.width / SVContentSize.width;
    CGFloat newHight = contentsFrame.height / coefByWidth;
    CGSize newSize = CGSizeMake(SVContentSize.width, newHight);
    [_image setFrame:(CGRect){CGPointZero,newSize}];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    CGSize SVContentSize = _scrollView.contentSize;
    //real photoSize
    CGSize contentsFrame = _image.image.size;
    float coefByWidth = contentsFrame.width / SVContentSize.width;
    CGFloat newHight = contentsFrame.height / coefByWidth;
    CGSize newSize = CGSizeMake(SVContentSize.width, newHight);
    [_image setFrame:(CGRect){CGPointZero,newSize}];
}

- (void)setFrameWhileZoomed {
    CGRect selfSize = self.contentView.frame;
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
    
    
    if (lFullHight) {
        float coefByHeight = contentsFrame.height / SVContentSize.height;
        CGFloat newWidth = contentsFrame.width / coefByHeight;
        _scrollView.contentSize = CGSizeMake(newWidth, _scrollView.contentSize.height);
    }
    else {
        float coefByWidth = contentsFrame.width / SVContentSize.width;
        CGFloat newHight = contentsFrame.height / coefByWidth;
        CGSize newSize = CGSizeMake(SVContentSize.width, newHight);
        [_scrollView setContentSize:newSize];
        //[_scrollView setFrame:(CGRect){CGPointZero,newSize}];
        //[_scrollView setBounds:self.bounds];
        
        
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

#pragma mark - Buttons

-(IBAction)commentButtonClicked:(id)sender {
    NSLog(@"clicked");
}
-(IBAction)likeButtonClicked:(id)sender {
    NSLog(@"liked");
}
-(IBAction)shareButtonClicked:(id)sender {
    NSLog(@"sharing");
}
@end
