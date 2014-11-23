//
//  QuoteTableViewCell.m
//  DynamicTableViewCellHeight
//
//  Created by Khoa Pham on 11/23/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "QuoteTableViewCell.h"

@implementation QuoteTableViewCell

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];

    self.contentView.frame = self.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.contentView updateConstraintsIfNeeded];
    [self.contentView layoutIfNeeded];

    self.quoteLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.quoteLabel.frame);
}

@end
