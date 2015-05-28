//
//  VideoViewController.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/26.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "CoreVideoViewController.h"
#import "M2CorePlayerView.h"
#import <Masonry/Masonry.h>

@interface CoreVideoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UIView *playerArea;
@property (nonatomic) M2CorePlayerView *playerView;
@property (nonatomic) BOOL isPlaying;
@property (weak, nonatomic) IBOutlet UIProgressView *bufferProgressView;
@property (weak, nonatomic) IBOutlet UISlider *playProgressSlider;
@property (weak, nonatomic) IBOutlet UILabel *curLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@end

@implementation CoreVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.statusButton setBackgroundImage:[UIImage littleImageForColor:[UIColor brownColor]] forState:UIControlStateNormal];
    [self.statusButton setBackgroundImage:[UIImage littleImageForColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
    self.statusButton.enabled = NO;
    [self.statusButton setTitle:@"播放" forState:UIControlStateNormal];
    
    __weak typeof(self) weakSelf = self;
    
    //
    self.playerView = [M2CorePlayerView new];
    [self.playerArea addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = [weakSelf.playerView superview];
        make.edges.equalTo(superView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.playerView reloadDataWithVideoURLString:@"http://img.iluokuang.cn:8080/video/Live_Free_or_Die_Hard_350K.mp4"];
    });
}

#pragma mark -
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
    [self.playerView reloadDataWithVideoURLString:@"http://img.iluokuang.cn:8080/video/Live_Free_or_Die_Hard_350K.mp4"];
    
    self.isPlaying = NO;
    self.statusButton.enabled = NO;
    [self.statusButton setTitle:@"播放" forState:UIControlStateNormal];
    self.bufferProgressView.progress = 0;
    self.playProgressSlider.value = 0;
    self.curLabel.text = [self dateStringFromTimeInterval:0];
    self.totalLabel.text = [self dateStringFromTimeInterval:0];
}

- (void)onPlayProgressValueChanged:(UISlider *)slider {
    [self.playerView seekToPlayProgress:slider.value];
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
