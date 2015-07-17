//
//  HWDragBackgroundView.h
//  滑动换页
//
//  Created by 黄伟 on 15/7/15.
//  Copyright (c) 2015年 huangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWHeadView.h"
@interface HWDragBackgroundView : UIView

//底部滑动页面的view，使用时根据需要添加
@property(nonatomic,strong) NSArray *views;

//顶部滚动条上的标签，一定要设置
@property(nonatomic,strong) NSArray *headTitles;

//顶部滚动条
@property(nonatomic,strong) HWHeadView *headView;

//底部滑动页面添加在collectionView里
@property(nonatomic,strong) UICollectionView *dragView;
@end
