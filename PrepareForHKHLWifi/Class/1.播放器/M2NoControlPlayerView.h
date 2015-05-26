//
//  M2NoControlPlayerView.h
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/26.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^M2NCPVVoidHandler) (void);

@interface M2NoControlPlayerView : UIView
// callback
@property (nonatomic, copy) M2NCPVVoidHandler onReadyToPlayHandler;
@property (nonatomic, copy) M2NCPVVoidHandler onPlayFinishHandler;
@property (nonatomic, copy) M2NCPVVoidHandler onPlayFailHandler;
@property (nonatomic, copy) M2NCPVVoidHandler onPlayStallHandler;
// reload data
- (void)reloadDataWithVideoURLString:(NSString *)videoURLString;
// control
- (void)play;
- (void)pause;
- (void)stop;
@end
