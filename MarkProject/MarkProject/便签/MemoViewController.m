//
//  MemoViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MemoViewController.h"
#import "WMDragView.h"
#import "MemoCell.h"

#define kCloseCellHeight    110.f
#define kOpenCellHeight     310.f
#define kRowsCount          5

@interface MemoViewController () < UITableViewDelegate, UITableViewDataSource >

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *cellHeights;

@property (nonatomic, assign) NSInteger selectRow;///<<#注释#>

@end

@implementation MemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    
    [self createCellHeightsArray];
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.tableView.backgroundColor = GrayWhiteColor;
    [self AddButton];
}
-(void)AddButton
{
    WMDragView *dragView = [[WMDragView alloc] init];
    dragView.backgroundColor = rgba(85, 85, 85, 1);
    dragView.layer.masksToBounds = YES;
    dragView.layer.cornerRadius = 25;
    dragView.clickDragViewBlock = ^(WMDragView *dragView) {
//        [self newBill];
    };
    [self.view addSubview:dragView];
    [dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(self.view).offset(-25);
        make.bottom.mas_equalTo(self.view).offset(-25);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"增加"]];
    [dragView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(dragView);
    }];
    
    
}
- (void)setNav
{
    [super setNav];
    [self.navigationView setTitle:@"便签"];
    
}
- (void)createCellHeightsArray
{
    for (int i = 0; i < kRowsCount; i ++) {
        [self.cellHeights addObject:@(kCloseCellHeight)];
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kRowsCount;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(MemoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![cell isKindOfClass:[MemoCell class]]) return;
    
    cell.backgroundColor = [UIColor clearColor];
    
    CGFloat cellHeight = self.cellHeights[indexPath.row].floatValue;
    if (cellHeight == kCloseCellHeight) {
        [cell selectedAnimationByIsSelected:NO animated:NO completion:nil];
    }else
    {
        [cell selectedAnimationByIsSelected:YES animated:NO completion:nil];
    }
    
    [cell setNumber:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemoCell" forIndexPath:indexPath];
    WeakBlock(self, weak_self);
    cell.callSelectRowBlock = ^(NSInteger row) {
        weak_self.selectRow = row;
    };
    switch (indexPath.row) {
        case 0:
            cell.DataLabel.text = @"2020年4月23号";
            cell.timeLabel.text = @"06:20 PM";
            cell.titleLabel.text = @"欢迎使用微笔记";
            cell.detailLabel.text = @"字数统计：200字";
            break;
            case 1:
            cell.DataLabel.text = @"2020年4月30号";
            cell.timeLabel.text = @"08:20 AM";
            cell.titleLabel.text = @"欢迎使用微笔记";
            cell.detailLabel.text = @"字数统计：200字";
            break;
            case 2:
            cell.DataLabel.text = @"2020年5月3号";
            cell.timeLabel.text = @"06:20 PM";
            cell.titleLabel.text = @"欢迎使用微笔记";
            cell.DataLabel.text = @"字数统计：200字";
            break;
            case 3:
            cell.DataLabel.text = @"2020年5月6号";
            cell.timeLabel.text = @"04:20 AM";
            cell.titleLabel.text = @"欢迎使用微笔记";
            cell.detailLabel.text = @"字数统计：200字";
            break;
            case 4:
            cell.DataLabel.text = @"2020年4月7号";
            cell.timeLabel.text = @"06:20 PM";
            cell.titleLabel.text = @"欢迎使用微笔记";
            cell.detailLabel.text = @"字数统计：200字";
            break;
            
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeights[indexPath.row].floatValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (![cell isKindOfClass:[MemoCell class]]) return;
    
    if (cell.isAnimating) return;
    
    NSTimeInterval duration = 0.f;
    
    CGFloat cellHeight = self.cellHeights[indexPath.row].floatValue;
    
    if (cellHeight == kCloseCellHeight) {
        self.cellHeights[indexPath.row] = @(kOpenCellHeight);
        [cell selectedAnimationByIsSelected:YES animated:YES completion:nil];
        duration = 1.f;
    }else
    {
        self.cellHeights[indexPath.row] = @(kCloseCellHeight);
        [cell selectedAnimationByIsSelected:NO animated:YES completion:nil];
        duration = 1.f;
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [tableView beginUpdates];
        [tableView endUpdates];
    } completion:nil];
    
}

#pragma mark - Getter && Setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_Height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerNib:[UINib nibWithNibName:@"MemoCell" bundle:nil] forCellReuseIdentifier:@"MemoCell"];
//        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
//        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    }
    return _tableView;
}

- (NSMutableArray<NSNumber *> *)cellHeights
{
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
    }
    return _cellHeights;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selectRow inSection:0];

    CGRect rectInTable = [_tableView rectForRowAtIndexPath:indexPath];

    CGRect rectInSelfview = [_tableView convertRect:rectInTable toView:self.view];

    CGFloat cellBottomY = rectInSelfview.origin.y + rectInSelfview.size.height;

    if (cellBottomY > keyboardFrame.origin.y ) { //键盘是否会挡住点击cell的判断

        CGFloat delta = _tableView.frame.origin.y - (cellBottomY - keyboardFrame.origin.y);
        delta = delta<_tableView.y-keyboardFrame.size.height?_tableView.y-keyboardFrame.size.height:delta;

        _tableView.frame =CGRectMake(0, delta,SCREEN_WIDTH,_tableView.frame.size.height);

    }
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    _tableView.frame =CGRectMake(0, NavigationBar_Height,SCREEN_WIDTH,_tableView.frame.size.height);
}
@end
