//
//  M7ShellPlayerView.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/27.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "M7ShellPlayerView.h"
#import "M2CorePlayerView.h"
#import <Masonry/Masonry.h>

@interface M7ShellPlayerView ()
@property (weak, nonatomic) IBOutlet UIView *playerArea;
@property (nonatomic) M2CorePlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *curLabel;
@property (weak, nonatomic) IBOutlet UIView *progressArea;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIProgressView *bufferProgressView;
@property (weak, nonatomic) IBOutlet UISlider *playProgressSlider;
@property (nonatomic) BOOL isFullScreen;
@property (nonatomic) BOOL isPlaying;
@end

@implementation M7ShellPlayerView

#pragma mark - 
- (void)awakeFromNib {
    [super awakeFromNib];
    
    __weak typeof(self) weakSelf = self;
    
    self.playerView = [M2CorePlayerView new];
    [self.playerArea addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([weakSelf.playerView superview]).with.insets(UIEdgeInsetsZero);
    }];
    self.playerView.onReadyToPlayHandler = ^{
        weakSelf.statusButton.enabled = YES;
        weakSelf.isPlaying = NO;
        [weakSelf onTapStatus:nil];
    };
    self.playerView.onBufferProgressChanged = ^(double progress){
        weakSelf.bufferProgressView.progress = progress;
    };
    self.playerView.onPlayProgressChanged = ^(double progress, NSTimeInterval cur, NSTimeInterval total) {
        weakSelf.playProgressSlider.value = progress;
        weakSelf.curLabel.text = [weakSelf dateStringFromTimeInterval:cur];
        weakSelf.totalLabel.text = [weakSelf dateStringFromTimeInterval:total];
    };
    self.playerView.onPlayFailHandler = ^{
        NSLog(@"失败  %s", __func__);
    };
    self.playerView.onPlayStallHandler = ^{
        NSLog(@"卡住  %s", __func__);
    };
    
    
    //
    [self.playProgressSlider addTarget:self action:@selector(onPlayProgressValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //
    self.bufferProgressView.progress = 0;
    self.playProgressSlider.value = 0;
    self.curLabel.text = [self dateStringFromTimeInterval:0];
    self.totalLabel.text = [self dateStringFromTimeInterval:0];
}

#pragma mark - 
- (void)reloadDataWithVideoURLString:(NSString *)videoURLString {
    [self.playerView reloadDataWithVideoURLString:videoURLString];
}

#pragma mark - user event
- (IBAction)onTapStatus:(id)sender {
    if (self.isPlaying) {
        [self.playerView pause];
        [self.statusButton setTitle:@"播放" forState:UIControlStateNormal];
    } else {
        [self.playerView play];
        [self.statusButton setTitle:@"暂停" forState:UIControlStateNormal];
    }
    self.isPlaying = !self.isPlaying;
}
- (IBAction)onTapNext:(id)sender {
#warning TODO:chenms
    [self.playerView reloadDataWithVideoURLString:@"http://img.iluokuang.cn:8080/video/Live_Free_or_Die_Hard_350K.mp4"];
    
    self.isPlaying = NO;
    self.statusButton.enabled = NO;
    [self.statusButton setTitle:@"播放" forState:UIControlStateNormal];
    self.bufferProgressView.progress = 0;
    self.playProgressSlider.value = 0;
    self.curLabel.text = [self dateStringFromTimeInterval:0];
    self.totalLabel.text = [self dateStringFromTimeInterval:0];
}

#pragma mark -
- (void)onPlayProgressValueChanged:(UISlider *)slider {
    [self.playerView seekToPlayProgress:slider.value];
}
- (IBAction)onTapChange:(id)sender {
    self.isFullScreen = !self.isFullScreen;
    if (self.isFullScreen) {
        self.nextButtonWidthConstraint.constant = 120;
//        self.leftMiddleConstraint.constant = 20;
//        self.rightMiddleConstraint.constant = 20;
    } else {
        self.nextButtonWidthConstraint.constant = 0;
//        self.leftMiddleConstraint.constant = 10;
//        self.rightMiddleConstraint.constant = 10;
    }
    
    //
    if (self.onFullScreenStatusChangedHandler) {
        self.onFullScreenStatusChangedHandler(self.isFullScreen);
    }
}

#pragma mark - tools
- (NSString *)dateStringFromTimeInterval:(NSTimeInterval)timeInterval {
    if (timeInterval > 3600) {
        NSInteger hours = timeInterval / 3600;
        NSInteger minutes = (timeInterval - 3600 * hours) / 60;
        NSInteger seconds = timeInterval - 3600 * hours - 60 * minutes;
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hours, minutes, seconds];
    } else {
        NSInteger minutes = timeInterval / 60;
        NSInteger seconds = timeInterval - 60 * minutes;
        return [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
    }
}

#pragma mark - dealloc
- (void)dealloc {
    [self.playerView clean];
}

@end
