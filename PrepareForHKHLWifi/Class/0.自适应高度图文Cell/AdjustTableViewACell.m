//
//  AdjustTableViewACell.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/8.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "AdjustTableViewACell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface AdjustTableViewACell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *theImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *srcLabel;

@property (nonatomic, weak) IBOutlet UILabel *theTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *theSubtitleLabel;

@end

@implementation AdjustTableViewACell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
//    self.titleLabel.numberOfLines = 0;
//    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    
//    self.contentLabel.numberOfLines = 0;
//    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.titleLabel.bounds);
//    self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLabel.bounds);
}



#pragma mark - 
- (void)reloadData:(NSArray *)data {
//    self.titleLabel.text = data[0];
//    id imageObj = data[1];
//    if ([imageObj isKindOfClass:[NSString class]]) {
//        [self.theImageView sd_setImageWithURL:[NSURL URLWithString:imageObj]];
//    } else if ([imageObj isKindOfClass:[NSArray class]]) {
//        [self.theImageView sd_setImageWithURL:[NSURL URLWithString:[imageObj firstObject]]];
//    }
//    self.contentLabel.text = data[2];
//    self.srcLabel.text = data[3];
    
    self.theTitleLabel.text = data[0];
    self.theSubtitleLabel.text = data[2];
}

@end
