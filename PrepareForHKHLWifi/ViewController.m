//
//  ViewController.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/7.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "ViewController.h"
#import "AdjustCellViewController.h"
#import "CoreVideoViewController.h"

static NSString *const s_cellIdentifier = @"s_cellIdentifier";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *datas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;  
    //
    self.datas = @[@[@"自适应高度图文Cell", @"AdjustCellViewController"],
                   @[@"播放器核View", @"CoreVideoViewController"],
                   @[@"view放大到全屏", @"ToFullScreenViewController"],
                   @[@"Slider", @"SliderViewController"],
                   @[@"播放器壳View", @"ShellVideoViewController"],
                   ];
    
    //
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:s_cellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:s_cellIdentifier];
    NSArray *data = [self.datas objectAtIndex:indexPath.row];
    cell.textLabel.text = data[0];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *data = [self.datas objectAtIndex:indexPath.row];
    UIViewController *controller = [NSClassFromString(data[1]) new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
