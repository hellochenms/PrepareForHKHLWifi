//
//  ShellVideoViewController.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/27.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "ShellVideoViewController.h"
#import "M7ShellPlayerView.h"
#import <Masonry/Masonry.h>

@interface ShellVideoViewController ()
@property (weak, nonatomic) IBOutlet UIView *playerArea;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidthConstraint;
@property (nonatomic) M7ShellPlayerView *playerView;

@end

@implementation ShellVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    __weak typeof(self) weakSelf = self;
    
    self.playerView = [[[NSBundle mainBundle] loadNibNamed:@"M7ShellPlayerView" owner:nil options:nil] firstObject];
    [self.playerArea addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([weakSelf.playerView superview]).with.insets(UIEdgeInsetsZero);
    }];
    self.playerView.onFullScreenStatusChangedHandler = ^(BOOL isFullScreen) {
        if (isFullScreen) {
//            self.fullScreenShowButton.hidden = NO;
            weakSelf.bottomHeightConstraint.constant = 0;
            weakSelf.rightWidthConstraint.constant = 0;
        } else {
            weakSelf.rightWidthConstraint.constant = 600;
            weakSelf.bottomHeightConstraint.constant = 300;
        }
        [UIView animateWithDuration:0.25
                         animations:^{
                             [weakSelf.view layoutIfNeeded];
                         } completion:^(BOOL finished) {
//                             if (!weakSelf.isFullScreen) {
//                                 weakSelf.fullScreenShowButton.hidden = YES;
//                             }
                         }];
    };
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.playerView reloadDataWithVideoURLString:@"http://img.iluokuang.cn:8080/video/Live_Free_or_Die_Hard_350K.mp4"];
    });
}

@end
