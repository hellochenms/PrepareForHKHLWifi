//
//  AdjustCellViewController.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/8.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "AdjustCellViewController.h"
#import "AdjustTableViewACell.h"
#import "AdjustTableViewBCell.h"
#import "AdjustTableViewCCell.h"

static NSString * const s_cellIdentifierA = @"s_cellIdentifierA";
static NSString * const s_cellIdentifierB = @"s_cellIdentifierB";
static NSString * const s_cellIdentifierC = @"s_cellIdentifierC";

@interface AdjustCellViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *datas;
@property (nonatomic) NSMutableDictionary *heightDict;
@property (nonatomic) AdjustTableViewACell *heightACell;
@property (nonatomic) AdjustTableViewBCell *heightBCell;
@property (nonatomic) AdjustTableViewCCell *heightCCell;

@end

@implementation AdjustCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"AdjustTableViewACell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:s_cellIdentifierA];
    [self.tableView registerNib:[UINib nibWithNibName:@"AdjustTableViewBCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:s_cellIdentifierB];
    [self.tableView registerNib:[UINib nibWithNibName:@"AdjustTableViewCCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:s_cellIdentifierC];
    
    self.datas = @[
                   @[@"短标题",
                     @"https://www.baidu.com/img/bd_logo1.png",
                     @"长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容",
                     @"来源：某网",
                     ],
                   @[@"长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题",
                     @[@"https://www.baidu.com/img/bd_logo1.png", @"https://www.baidu.com/img/bd_logo1.png", @"https://www.baidu.com/img/bd_logo1.png"],
                     @"短内容",
                     @"来源：某网",
                     ],
                   @[@"长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题\n长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题\n长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题\n长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题",
                     @"https://www.baidu.com/img/bd_logo1.png",
                     @"长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容\n内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容\n内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容长内容",
                     @"来源：某网",
                     ],
                   ];
    
    [self.heightDict removeAllObjects];
    [self.tableView reloadData];
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

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    AdjustTableViewACell *cell = (AdjustTableViewACell *)[tableView dequeueReusableCellWithIdentifier:s_cellIdentifierA];
//    [cell reloadData: [self.datas objectAtIndex:indexPath.row]];
    
//    AdjustTableViewBCell *cell = (AdjustTableViewBCell *)[tableView dequeueReusableCellWithIdentifier:s_cellIdentifierB];
//    [cell reloadData: [self.datas objectAtIndex:indexPath.row]];
    
    AdjustTableViewCCell *cell = (AdjustTableViewCCell *)[tableView dequeueReusableCellWithIdentifier:s_cellIdentifierC];
    [cell reloadData: [self.datas objectAtIndex:indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [self calcHeightForACellAtIndexPath:indexPath];
    
//    return [self calcHeightForBCellAtIndexPath:indexPath];
    
    return [self calcHeightForCCellAtIndexPath:indexPath];
}

#pragma mark - tools A
- (double)calcHeightForACellAtIndexPath:(NSIndexPath *)indexPath {
    AdjustTableViewACell *cell = [self aCellForAdjust];
    
    cell.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(cell.bounds));
    
    double height = [[self.heightDict objectForKey:indexPath] doubleValue];
    if (height <= 0) {
        
        NSArray *data = [self.datas objectAtIndex:indexPath.row];
        [cell reloadData:data];

        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        height += 1;
        [self.heightDict setObject:@(height) forKey:indexPath];
        
    }
    
    return height;
}
- (AdjustTableViewACell *)aCellForAdjust {
    if (!self.heightACell) {
        self.heightACell = [[[NSBundle mainBundle] loadNibNamed:@"AdjustTableViewACell" owner:nil options:nil] firstObject];
    }
    
    return self.heightACell;
}

#pragma mark - tools B
- (double)calcHeightForBCellAtIndexPath:(NSIndexPath *)indexPath {
    AdjustTableViewBCell *cell = [self bCellForAdjust];
    
    cell.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(cell.bounds));
    
    double height = [[self.heightDict objectForKey:indexPath] doubleValue];
    if (height <= 0) {
        
        NSArray *data = [self.datas objectAtIndex:indexPath.row];
        [cell reloadData:data];
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        height += 1;
        [self.heightDict setObject:@(height) forKey:indexPath];
    }
    
    return height;
}
- (AdjustTableViewBCell *)bCellForAdjust {
    if (!self.heightBCell) {
        self.heightBCell = [[[NSBundle mainBundle] loadNibNamed:@"AdjustTableViewBCell" owner:nil options:nil] firstObject];
    }
    
    return self.heightBCell;
}

#pragma mark - tools C
- (double)calcHeightForCCellAtIndexPath:(NSIndexPath *)indexPath {
    AdjustTableViewCCell *cell = [self cCellForAdjust];
    
    cell.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(cell.bounds));
    
    double height = [[self.heightDict objectForKey:indexPath] doubleValue];
    if (height <= 0) {
        
        NSArray *data = [self.datas objectAtIndex:indexPath.row];
        [cell reloadData:data];
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        height += 1;
        [self.heightDict setObject:@(height) forKey:indexPath];
        
    }
    
    return height;
}
- (AdjustTableViewCCell *)cCellForAdjust {
    if (!self.heightCCell) {
        self.heightCCell = [[[NSBundle mainBundle] loadNibNamed:@"AdjustTableViewCCell" owner:nil options:nil] firstObject];
    }
    
    return self.heightCCell;
}



@end
