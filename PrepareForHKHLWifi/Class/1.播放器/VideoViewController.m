//
//  VideoViewController.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/26.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "VideoViewController.h"
#import "M2NoControlPlayerView.h"
#import <Masonry/Masonry.h>

@interface VideoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UIView *playerArea;
@property (nonatomic) M2NoControlPlayerView *playerView;
@property (nonatomic) BOOL isPlaying;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.statusButton setBackgroundImage:[UIImage littleImageForColor:[UIColor brownColor]] forState:UIControlStateNormal];
    [self.statusButton setBackgroundImage:[UIImage littleImageForColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
    self.statusButton.enabled = NO;
    [self.statusButton setTitle:@"播放" forState:UIControlStateNormal];
    
    __weak typeof(self) weakSelf = self;
    
    //
    self.playerView = [M2NoControlPlayerView new];
    [self.playerArea addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = [weakSelf.playerView superview];
        make.edges.equalTo(superView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    self.playerView.onReadyToPlayHandler = ^{
        weakSelf.statusButton.enabled = YES;
    };
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

@end
