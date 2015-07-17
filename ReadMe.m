//
//  ReadMe.m
//  滑动换页
//
//  Created by 黄伟 on 15/7/16.
//  Copyright (c) 2015年 huangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
1.使用时，HWDragBackgroundView作为一个view，添加到需要的控制器

2.设置需要切换的view，放入一个数组
  设置滚动条上的标签，放入一个数组

3.给HWDragBackgroundView对象的属性headTitles，views赋值



HWDragBackgroundView *dragBackground = [[HWDragBackgroundView alloc]init];
dragBackground.frame = self.view.bounds;
dragBackground.y = 64;
dragBackground.height = self.view.height - dragBackground.y;
[self.view addSubview:dragBackground];

NSMutableArray *temp = [NSMutableArray array];
NSMutableArray *titles = [NSMutableArray array];

for (NSInteger i=0; i<12; i++) {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1];
    [temp addObject:view];
    NSString *str = [NSString stringWithFormat:@"标题%ld",(long)i];
    [titles addObject:str];
}
dragBackground.headTitles = titles;
dragBackground.views = temp;