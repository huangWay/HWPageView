//
//  ViewController.m
//  滑动换页
//
//  Created by 黄伟 on 14/11/15.
//  Copyright (c) 2014年 huangwei. All rights reserved.
//

#import "ViewController.h"
#import "HWDragBackgroundView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.edgesForExtendedLayout = UIRectEdgeNone;
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
    
}



@end
