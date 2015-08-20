//
//  ViewController.m
//  DynamicTableViewCellHeight
//
//  Created by Khoa Pham on 11/23/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "ViewController.h"
#import "QuoteTableViewCell.h"

#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS8_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) QuoteTableViewCell *prototypeCell;
@property (nonatomic, strong) QuoteTableViewCell *prototypeCellRight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupTableView
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - Data
- (void)loadData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"];
    self.items = [[NSArray alloc] initWithContentsOfFile:plistPath];

    [self.tableView reloadData];
}

#pragma mark - PrototypeCell
- (QuoteTableViewCell *)prototypeCell
{
    if (!_prototypeCell) {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QuoteTableViewCell class])];
    }
    
    return _prototypeCell;
}

- (QuoteTableViewCell *)prototypeCellRight
{
    if (!_prototypeCellRight) {
        _prototypeCellRight = [self.tableView dequeueReusableCellWithIdentifier:@"QuoteTableViewCellRight"];
    }
    
    return _prototypeCellRight;
}

#pragma mark - Configure
- (void)configureCell:(QuoteTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *quote = self.items[indexPath.row];

    cell.numberLabel.text = [NSString stringWithFormat:@"Quote %ld", (long)indexPath.row];
    cell.quoteLabel.text = quote;
}

#pragma mark - UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellname = (indexPath.row&1)?@"QuoteTableViewCell":@"QuoteTableViewCellRight";
    QuoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellname];

    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;

    }

    QuoteTableViewCell *prototype = (indexPath.row & 1)?self.prototypeCell:self.prototypeCellRight;
    [self configureCell:prototype forRowAtIndexPath:indexPath];

    [prototype updateConstraintsIfNeeded];
    [prototype layoutIfNeeded];

    return [prototype.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

}

@end
