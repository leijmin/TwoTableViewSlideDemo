//
//  JMSlideView.m
//  TwoTableViewSlideDemo
//
//  Created by lanren on 16/6/7.
//  Copyright © 2016年 雷建民. All rights reserved.
//

#import "JMSlideView.h"
#import "RightClildViewController.h"
@interface JMSlideView ()<UITableViewDelegate,UITableViewDataSource,ScrollAtSectionDelegate>

/**
 *   该View对应所在的控制器
 */
@property (nonatomic ,strong)UIViewController *parentVC;

/**
 *  右边 子控制器
 */
@property (nonatomic ,strong)RightClildViewController *rightVC;
/**
 *  左边 tableView
 */
@property (nonatomic ,strong)UITableView    *tableView;
/**
 *  左边tableView 数据源
 */
@property (nonatomic ,strong)NSMutableArray *dataArray;
/**
 *  右边tableView 数据源
 */
@property (nonatomic ,strong)NSMutableArray *rightArray;

@end

@implementation JMSlideView

static NSString *const   leftIdentifier = @"leftIdentifier";

- (instancetype)initWithFrame:(CGRect)frame
                leftDataArray:(NSMutableArray *)leftDataArray
               rightDataArray:(NSMutableArray *)rightDataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = leftDataArray;
        
        self.rightArray = rightDataArray;
        
        [self addChildViewController];
        
        [self addSubview:self.tableView];
        
    }
    return self;
}

//添加子视图控制器
- (void)addChildViewController
{
    self.rightVC = [[RightClildViewController alloc]init];
    [self.parentVC addChildViewController:_rightVC];
    self.rightVC.headerArray = self.dataArray;
    self.rightVC.rightArray  = self.rightArray;
    self.rightVC.delegate = self;
    [self addSubview:_rightVC.view];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIdentifier];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_rightVC) {
        
        [_rightVC leftTableViewToSelectedAtIndexPath:indexPath];
    }
}

#pragma mark - ScrollAtSectionDelegate
- (void)willDisplayHeaderView:(NSInteger)section {
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)didEndDisplayingHeaderView:(NSInteger)section {
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section + 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - 懒加载 tableView

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.frame.size.width * 0.25, self.frame.size.height) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)rightArray
{
    if (!_rightArray) {
        _rightArray = [NSMutableArray array];
    }
    return _rightArray;
}
- (RightClildViewController *)rightVC
{
    if (!_rightVC) {
        _rightVC = [[RightClildViewController alloc]init];
    }
    return _rightVC;
}
@end
