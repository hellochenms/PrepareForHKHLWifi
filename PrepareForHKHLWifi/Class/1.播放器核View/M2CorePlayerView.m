//
//  M2NoControlPlayerView.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/26.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "M2CorePlayerView.h"
#import <AVFoundation/AVFoundation.h>

static NSString * const s_M2NCPVKeyPathStatus = @"status";

@interface M2CorePlayerView ()
//@property (nonatomic) AVPlayerLayer *playerLayer;
@property (nonatomic) AVPlayer *player;
@property (nonatomic) AVPlayerItem *curPlayerItem;
@property (nonatomic) NSTimer *progressTimer;
@end

@implementation M2CorePlayerView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        
        self.player = [AVPlayer playerWithPlayerItem:nil];
        ((AVPlayerLayer *)self.layer).player = self.player;
        
        [self addNotifications];
    }
    
    return self;
}

#pragma mark -
+ (Class)layerClass {
    return [AVPlayerLayer class];
}

#pragma mark - reload data
- (void)reloadDataWithVideoURLString:(NSString *)videoURLString {
    //
    [self stop];
    
    // TODO: clear old
    [self.curPlayerItem removeObserver:self forKeyPath:s_M2NCPVKeyPathStatus];
    [self.curPlayerItem cancelPendingSeeks];
    [self.player cancelPendingPrerolls];

    // new
    self.curPlayerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:videoURLString]];
    [self.curPlayerItem addObserver:self forKeyPath:s_M2NCPVKeyPathStatus options:NSKeyValueObservingOptionNew context:nil];
    [self.player replaceCurrentItemWithPlayerItem:self.curPlayerItem];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqual:s_M2NCPVKeyPathStatus]) {
        if (self.curPlayerItem.status == AVPlayerItemStatusFailed) {
            if (self.onPlayFailHandler) {
                self.onPlayFailHandler();
            }
        } else if (self.curPlayerItem.status == AVPlayerItemStatusReadyToPlay) {
            if (self.onReadyToPlayHandler) {
                self.onReadyToPlayHandler();
            }
        }
    }
}

#pragma mark - control
- (void)play {
    [self scheduleProgressTimer];
    [self.player play];
}
- (void)pause {
    [self.progressTimer invalidate];
    [self.player pause];
}
- (void)stop {
    [self.progressTimer invalidate];
    [self.player pause];
    [self.player seekToTime:kCMTimeZero];
}

- (void)seekToPlayProgress:(double)playProgress {
    int timescale = self.curPlayerItem.asset.duration.timescale;
    float time = playProgress * (self.curPlayerItem.asset.duration.value / timescale);
    [self.player seekToTime:CMTimeMakeWithSeconds(time, timescale)];
}

- (void)scheduleProgressTimer {
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                          target:self
                                                        selector:@selector(onProgressTimerFire)
                                                        userInfo:nil
                                                         repeats:YES];
}

#pragma mark - timer event
- (void)onProgressTimerFire {
    NSTimeInterval duration = CMTimeGetSeconds(self.curPlayerItem.asset.duration);
    
    // buffer progress
    NSArray *loadedTimeRanges = [self.curPlayerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    double startSeconds = CMTimeGetSeconds(timeRange.start);
    double durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval bufferDuration = startSeconds + durationSeconds;
    double bufferProgress = bufferDuration / duration;
    if (self.onBufferProgressChanged) {
        self.onBufferProgressChanged(bufferProgress);
    }
    
    // play progress
    NSTimeInterval current = CMTimeGetSeconds(self.player.currentTime);
    if (duration <= 0) {
        return;
    }
    double playProgress = current / duration;
    if (self.onPlayProgressChanged) {
        self.onPlayProgressChanged(playProgress, current, duration);
    }
}

#pragma mark - 
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidFinishPlaying:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFailedToPlayToEnd:)
                                                 name:AVPlayerItemFailedToPlayToEndTimeNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerStalled:)
                                                 name:AVPlayerItemPlaybackStalledNotification object:self];
}
- (void)removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:nil];
}

#pragma mark - notification
- (void)playerDidFinishPlaying:(NSNotification *)notification {
    if (notification.object != self) {
        return;
    }
    if (self.onPlayFinishHandler) {
        self.onPlayFinishHandler();
    }
}
- (void)playerFailedToPlayToEnd:(NSNotification *)notification {
    if (notification.object != self) {
        return;
    }
    if (self.onPlayFailHandler) {
        self.onPlayFailHandler();
    }
}
- (void)playerStalled:(NSNotification *)notification {
    if (notification.object != self) {
        return;
    }
    if (self.onPlayStallHandler) {
        self.onPlayStallHandler();
    }
}

#pragma mark -
- (void)clean {
    [self.progressTimer invalidate];
}

#pragma mark - dealloc
- (void)dealloc {
    [self removeNotifications];
    [self.curPlayerItem removeObserver:self forKeyPath:s_M2NCPVKeyPathStatus];
}

@end
