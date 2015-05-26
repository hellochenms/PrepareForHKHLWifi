//
//  AdjustTableViewCCell.m
//  PrepareForHKHLWifi
//
//  Created by thatsoul on 15/5/8.
//  Copyright (c) 2015年 chenms.m2. All rights reserved.
//

#import "AdjustTableViewCCell.h"

@interface AdjustTableViewCCell ()
@property (nonatomic, weak) IBOutlet UILabel *theTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *theSubtitleLabel;
@end

@implementation AdjustTableViewCCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
- (void)reloadData:(NSArray *)data {
    self.theTitleLabel.text = data[0];
    self.theSubtitleLabel.text = data[2];
}


@end
