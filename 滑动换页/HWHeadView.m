//
//  HWHeadView.m
//  滑动换页
//
//  Created by 黄伟 on 14/11/15.
//  Copyright (c) 2014年 huangwei. All rights reserved.
//

#import "HWHeadView.h"
#define Item_Number 5//默认一页显示5个按钮
#define Default_ItemHeight 39//按钮默认的高度

//滚动条上按钮的可视区域，设计为保持当前选中按钮前后2个按钮宽度，总计5个按钮宽度的距离
#define Default_VisiableButtonNumber 5  

@interface HWHeadView()

//滚动条上的按钮
@property(nonatomic,strong) NSMutableArray *buttons;

//滚动条上红色的view，在按钮下面，
@property(nonatomic,strong) UIView *selectView;

//当前选中的按钮
@property(nonatomic,strong) UIButton *selectBtn;

//之前选中的按钮
@property(nonatomic,strong) UIButton *previousSelectBtn;

//按钮宽度
@property(nonatomic,assign) CGFloat itemWidth;
@end

@implementation HWHeadView


-(instancetype)init{
    if (self = [super init]) {
        //隐藏滚动条
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

#pragma mark -懒加载
-(NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

#pragma mark -布局子控件
//给标签数组赋值，在这里布局子控件
-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    
    //一共有多少个按钮
    NSInteger items = titles.count;
    
    //当外界设定的按钮个数大于默认的5个时
    if (items > Item_Number) {
        
        //按钮的宽度 ＝ 页面的宽度/5
        self.itemWidth = self.width/Item_Number;
    }else{
        
        //按钮个数小于默认时，按钮的宽度就是屏幕宽度/按钮数
       self.itemWidth = self.width/items;
    }
    
    //按照按钮个数布局滚动条上的按钮
    for (NSInteger i = 0; i < titles.count; i++) {
        
        //取到对应的标题
        NSString *title = titles[i];
        
        //创建按钮
        UIButton *button = [[UIButton alloc]init];
        
        //给按钮设置一个标签，用来标记按钮
        button.tag = i;
        
        //设置按钮标题
        [button setTitle:title forState:UIControlStateNormal];
        
        //设置按钮标题颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //监听按钮的点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置按钮的frame
        button.frame = CGRectMake(i*self.itemWidth, 0, self.itemWidth, Default_ItemHeight);
        
        //把按钮添加到滚动条
        [self addSubview:button];
        
        //把按钮存放到数组中
        [self.buttons addObject:button];
    }
    
    //创建红色的view
    UIView *selectView = [[UIView alloc]init];
    selectView.backgroundColor = [UIColor redColor];
    
    //这个红色的view在按钮的下面，宽度就是按钮的宽度
    selectView.frame = CGRectMake(self.selectBtn.x, Default_ItemHeight, self.itemWidth, self.height-Default_ItemHeight);
    self.selectView = selectView;
    
    //把view添加到滚动条上
    [self addSubview:selectView];
    
    //设置整个滚动条的contentSize,宽度就是按钮个数＊按钮宽度
    self.contentSize = CGSizeMake(self.itemWidth*items, self.height);

}

#pragma mark -按钮点击事件
//按钮的点击事件
-(void)buttonClick:(UIButton *)sender{
    
    //点击按钮，告诉外界当前点击的是哪个按钮，用来切换到相应的页面
    self.selectOperation(sender.tag);
    
    //选中某个按钮，滚动条要做的事
    [self selectButtonAtIndex:sender.tag];
}


#pragma mark -选中按钮要做的操作
//滑动页面时，顶部滚动条需要选中的按钮
-(void)scrollToSelectButtonAtOffset:(CGPoint)offset{
    
    //外界页面滑动超过一半时，就表示选中下一个页面
    CGFloat limit = offset.x + self.width*0.5;
    NSInteger index = limit/self.width;
    
    //滚动条底部红色的view的移动
     self.selectView.transform = CGAffineTransformMakeTranslation(self.itemWidth* offset.x/self.width, 0);
    
    //选中对应索引的按钮
    [self selectButtonAtIndex:index];   
    
}

//选中某个索引的按钮
-(void)selectButtonAtIndex:(NSInteger)index{
    
    //因为即将改变选中的按钮，所以这个方法调用之前选中的按钮就成为“之前”选中的按钮
    self.previousSelectBtn = self.selectBtn;
    
    //之前选中的按钮要变成普通的黑色
    [self.previousSelectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //根据索引取到对应的按钮
    UIButton *button = self.buttons[index];
    
    //当前选中的按钮，就是它
    self.selectBtn = button;
    
    //选中的按钮标题应该是红色
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
   //让一个区域可见，设计可视范围为选中的按钮前后2个按钮宽度
    CGRect visiableRect = CGRectMake(button.x-(Default_VisiableButtonNumber/2)*self.itemWidth, 0, Default_VisiableButtonNumber*self.itemWidth, self.selectBtn.height);
    
    if (index > Item_Number/2 || index < self.buttons.count -(Item_Number/2) ) {
        [self scrollRectToVisible:visiableRect animated:YES];
    }
 
}

@end
