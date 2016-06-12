//
//  ViewController.m
//  TwoTableViewSlideDemo
//
//  Created by lanren on 16/6/7.
//  Copyright © 2016年 雷建民. All rights reserved.
//

#import "ViewController.h"
#import "JMSlideView.h"

@interface ViewController ()

{
    NSMutableArray *leftDataArray;
    NSMutableArray *rightDataArray;
}

@property (nonatomic ,strong)JMSlideView *slideView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    leftDataArray = [NSMutableArray arrayWithObjects:@"热销菜品",@"精选组合",@"粥类",@"东北小町米",@"特色佳肴",@"商务套餐",@"开胃冷菜",@"热菜大荤",@"汤类",@"酒水饮料", nil];
    
    rightDataArray = [NSMutableArray arrayWithObjects:@"米饭",@"小炒花菜",@"黑木耳炒山药",@"红烧鸡腿",@"农家小炒肉",@"板栗烧鸡", nil];
    
    
    [self.view addSubview:self.slideView];
    
    
}

- (JMSlideView *)slideView
{
    if (!_slideView) {
        _slideView = [[JMSlideView alloc]initWithFrame:self.view.bounds leftDataArray:leftDataArray rightDataArray:rightDataArray];
       
    }
    return _slideView;
}

@end
