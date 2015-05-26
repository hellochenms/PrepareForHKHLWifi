//
//  ViewController.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/7.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "ViewController.h"
#import "AdjustCellViewController.h"
#import "VideoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (IBAction)onTapAdjustCell:(id)sender {
    AdjustCellViewController *controller = [AdjustCellViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)onTapVideo:(id)sender {
    VideoViewController *controller = [VideoViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
