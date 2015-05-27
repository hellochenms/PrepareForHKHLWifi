//
//  SliderViewController.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/27.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISlider *vSlider;
@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.slider setMinimumTrackImage:[UIImage littleImageForColor:[UIColor redColor]] forState:UIControlStateNormal];
    
    [self.slider setMaximumTrackTintColor:[UIColor clearColor]];
    [self.slider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:UIControlStateNormal];
}

@end
