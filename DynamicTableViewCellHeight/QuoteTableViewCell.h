//
//  QuoteTableViewCell.h
//  DynamicTableViewCellHeight
//
//  Created by Khoa Pham on 11/23/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;

@end
