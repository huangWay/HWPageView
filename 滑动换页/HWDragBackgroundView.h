//
//  HWDragBackgroundView.h
//  滑动换页
//
//  Created by 黄伟 on 14/11/15.
//  Copyright (c) 2014年 huangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWHeadView.h"
@interface HWDragBackgroundView : UIView

//底部滑动页面的view，使用时根据需要添加
@property(nonatomic,strong) NSArray *views;

//顶部滚动条上的标签，一定要设置
@property(nonatomic,strong) NSArray *headTitles;



//底部滑动页面添加在collectionView里
@property(nonatomic,strong) UICollectionView *dragView;
@end
