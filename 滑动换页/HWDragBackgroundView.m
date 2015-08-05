//
//  HWDragBackgroundView.m
//  滑动换页
//
//  Created by 黄伟 on 14/11/15.
//  Copyright (c) 2014年 huangwei. All rights reserved.
//

#import "HWDragBackgroundView.h"

#define Default_Height 44//顶部滚动条默认高度44
@interface HWDragBackgroundView()<UICollectionViewDataSource,UICollectionViewDelegate>
//顶部滚动条
@property(nonatomic,strong) HWHeadView *headView;
@end


//重用标识符
static NSString *ID = @"collectionCell";
@implementation HWDragBackgroundView


//添加要滑动切换的view
-(void)setViews:(NSArray *)views{
    _views = views;
    
    //创建顶部滚动条
    [self setUpHeadView];
    
    //创建底部用来滑动换页的collectionView
    [self setUpDragView];

}

//创建顶部滚动条
-(void)setUpHeadView{
    
    //创建滚动条
    HWHeadView *headView = [[HWHeadView alloc]init];
    
    headView.frame = CGRectMake(0, 0, self.width, Default_Height);
    //设置滚动条的titles属性(在HWHeadView类中，titles的setter方法里布局了所有的子控件)
    headView.titles = self.headTitles;
    
    //顶部滚动条block，选中某个按钮
    headView.selectOperation = ^(NSInteger index){
        
        //告诉换页的collectionView，根据对应的索引，切换到相应的页面
        [self.dragView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    };
    //把顶部滚动条添加到view上
    [self addSubview:headView];
    self.headView = headView;
}

//创建底部用来滑动换页的collectionView
-(void)setUpDragView{
    
    //collectionView的流水布局
    CGRect frm = CGRectMake(0, Default_Height, self.width, self.height - Default_Height);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //滚动方向为水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = frm.size;
    
    //页与页之间不需要间距
    layout.minimumLineSpacing = 0;
    
    //创建用语换页的collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frm collectionViewLayout:layout];
    
    //注册collectionViewCell，因为以后我们具体需要的view是添加在cell的view上，所以就用默认的
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    //分页
    collectionView.pagingEnabled = YES;
    
    //隐藏滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    
    //设置代理和数据源
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    
    //把用来换页的collectionView添加到view上
    [self addSubview:collectionView];
    
    self.dragView = collectionView;
    
    //刚创建时默认让顶部滚动条选择0索引
    [self.headView scrollToSelectButtonAtOffset:CGPointZero];
}

#pragma mark -UICollectionView数据源
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //页数
    return self.views.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell采用默认的
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //根据索引取出view
    UIView *view = self.views[indexPath.item];
    //view的大小与cell一致，整个覆盖
    view.frame = cell.bounds;
    
    //添加到cell上
    [cell addSubview:view];
    return cell;
}

#pragma mark -UIScrollView代理


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    //根据collectionView滚动的offset，去让顶部滚动条做相应的事（让顶部滚动条滚动到相应位置）
    [self.headView scrollToSelectButtonAtOffset:scrollView.contentOffset];

}


@end
