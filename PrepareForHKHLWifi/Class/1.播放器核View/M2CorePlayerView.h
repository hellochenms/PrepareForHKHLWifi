//
//  M2NoControlPlayerView.h
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/26.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^M2NCPVVoidHandler) (void);
typedef void (^M2NCPVBufferProgressHandler) (double progress);
typedef void (^M2NCPVPlayProgressHandler) (double progress, NSTimeInterval cur, NSTimeInterval total);

@interface M2CorePlayerView : UIView
// callback
@property (nonatomic, copy) M2NCPVVoidHandler onReadyToPlayHandler;
@property (nonatomic, copy) M2NCPVVoidHandler onPlayFinishHandler;
@property (nonatomic, copy) M2NCPVVoidHandler onPlayFailHandler;
@property (nonatomic, copy) M2NCPVVoidHandler onPlayStallHandler;
@property (nonatomic, copy) M2NCPVBufferProgressHandler onBufferProgressChanged;
@property (nonatomic, copy) M2NCPVPlayProgressHandler onPlayProgressChanged;
//@property (nonatomic, readonly) double bufferProgress;
//@property (nonatomic, readonly) double playProgress;
// reload data
- (void)reloadDataWithVideoURLString:(NSString *)videoURLString;
// control
- (void)play;
- (void)pause;
- (void)stop;
- (void)seekToPlayProgress:(double)playProgress;
// clean
- (void)clean;
@end
