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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
