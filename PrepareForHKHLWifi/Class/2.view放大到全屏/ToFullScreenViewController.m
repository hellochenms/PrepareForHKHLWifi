//
//  ToFullScreenViewController.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/27.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "ToFullScreenViewController.h"

@interface ToFullScreenViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenShowButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fullScreenShowButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMiddleConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightMiddleConstraint;
@property (nonatomic) BOOL isFullScreen;
@end

@implementation ToFullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fullScreenShowButton.hidden = YES;
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
- (IBAction)onTapChange:(id)sender {
    self.isFullScreen = !self.isFullScreen;
    if (self.isFullScreen) {
        self.fullScreenShowButton.hidden = NO;
        self.bottomHeightConstraint.constant = 0;
        self.rightWidthConstraint.constant = 0;
        self.fullScreenShowButtonWidthConstraint.constant = 120;
        self.leftMiddleConstraint.constant = 20;
        self.rightMiddleConstraint.constant = 20;
    } else {
        self.rightWidthConstraint.constant = 600;
        self.bottomHeightConstraint.constant = 300;
        self.fullScreenShowButtonWidthConstraint.constant = 0;
        self.leftMiddleConstraint.constant = 10;
        self.rightMiddleConstraint.constant = 10;
    }
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25
                     animations:^{
                         [weakSelf.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         if (!weakSelf.isFullScreen) {
                             weakSelf.fullScreenShowButton.hidden = YES;
                         }
                     }];
    
}

@end
