//
//  RightClildViewController.m
//  TwoTableViewSlideDemo
//
//  Created by lanren on 16/6/7.
//  Copyright © 2016年 雷建民. All rights reserved.
//

#import "RightClildViewController.h"

@interface RightClildViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 *  结束滚动时的偏移量
 */
@property(nonatomic, assign)CGFloat endScrollOffset_Y;

/**
 *   是否可以向上滚动
 */
@property (nonatomic ,assign)BOOL isUpScroll;
/**
 *  右边的tableView
 */
@property (nonatomic ,strong)UITableView *rightTableView;

@end

@implementation RightClildViewController

static NSString *const rightIdentifier = @"rightIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    _isUpScroll = NO;
    _endScrollOffset_Y = 0;
     self.view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.25, 64, self.view.frame.size.width * 0.75, self.view.frame.size.height-64)];
    [self.view addSubview:self.rightTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _headerArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    
    return _rightArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return _headerArray[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIdentifier];
    
    cell.textLabel.text = _rightArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(willDisplayHeaderView:)] != _isUpScroll ) {
        [self.delegate willDisplayHeaderView:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (self.delegate  && [self.delegate respondsToSelector:@selector(didEndDisplayingHeaderView:)] && _isUpScroll) {
        [self.delegate didEndDisplayingHeaderView:section];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    _isUpScroll = _endScrollOffset_Y < scrollView.contentOffset.y;
    _endScrollOffset_Y = scrollView.contentOffset.y;
   
}

//点击左边tableView 滚动 时右边tableView一起滚动
- (void)leftTableViewToSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    [self.rightTableView selectRowAtIndexPath:([NSIndexPath indexPathForRow:0 inSection:indexPath.row]) animated:YES scrollPosition:UITableViewScrollPositionTop];
}
#pragma mark - 懒加载
- (UITableView *)rightTableView
{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rightIdentifier];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
    }
    return _rightTableView;
}

- (NSMutableArray *)rightArray
{
    if (!_rightArray) {
        _rightArray = [NSMutableArray array];
    }
    return _rightArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
