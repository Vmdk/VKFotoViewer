//
//  LogInView.h
//  VKFotoViewer
//
//  Created by robert on 7/3/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LogInView : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *myBrowser;

- (NSString*)stringBetweenString:(NSString*)start
                       andString:(NSString*)end
                     innerString:(NSString*)str;

@end


