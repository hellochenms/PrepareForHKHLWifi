//
//  M7ShellPlayerView.h
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/27.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M7ShellPlayerView : UIView
@property (nonatomic, copy) void (^onFullScreenStatusChangedHandler)(BOOL isFullScreen);
- (void)reloadDataWithVideoURLString:(NSString *)videoURLString;
@end
