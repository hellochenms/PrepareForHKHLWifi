//
//  M7ShellPlayerView.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/27.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "M7ShellPlayerView.h"

@interface M7ShellPlayerView ()
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *curLabel;
@property (weak, nonatomic) IBOutlet UIView *progressArea;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@end

@implementation M7ShellPlayerView

#pragma mark - user event
- (IBAction)onTapStatus:(id)sender {
}
- (IBAction)onTapNext:(id)sender {
}
- (IBAction)onTapChange:(id)sender {
}


@end
