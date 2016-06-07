//
//  RightClildViewController.h
//  TwoTableViewSlideDemo
//
//  Created by lanren on 16/6/7.
//  Copyright © 2016年 雷建民. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollAtSectionDelegate <NSObject>

- (void)willDisplayHeaderView:(NSInteger)section;
- (void)didEndDisplayingHeaderView:(NSInteger)section;

@end


@interface RightClildViewController : UIViewController

@property (nonatomic ,strong) NSMutableArray *rightArray;

@property (nonatomic ,strong) NSMutableArray *headerArray;

@property(nonatomic, weak) id<ScrollAtSectionDelegate> delegate;

/**
 *  当左边tableView滚动时,右边tableView跟随滚动至指定section
 */
- (void)leftTableViewToSelectedAtIndexPath:(NSIndexPath *)indexPath;


@end
