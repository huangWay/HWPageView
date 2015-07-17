//
//  HWHeadView.h
//  滑动换页
//
//  Created by 黄伟 on 15/7/15.
//  Copyright (c) 2015年 huangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

//点击顶部滚动条上的按钮，切换到需要的页面
typedef void(^selectButton)(NSInteger index);

@interface HWHeadView : UIScrollView

//顶部滚动条上的标签
@property(nonatomic,strong) NSArray *titles;

//用户点击选中或者滑动页面选中的按钮
@property(nonatomic,strong,readonly) UIButton *selectBtn;

//上面声明的block
@property(nonatomic,copy)selectButton selectOperation;

//滑动页面时，顶部滚动条需要选中的按钮
-(void)scrollToSelectButtonAtOffset:(CGPoint)offset;

@end
