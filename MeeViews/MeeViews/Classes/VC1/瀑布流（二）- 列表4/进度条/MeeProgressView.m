//
//  MeeProgressView.m
//  MeeViews
//
//  Created by liwei on 16/4/26.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeProgressView.h"

#define viewW self.frame.size.width
#define viewH self.frame.size.height


static CGFloat const startAngle  = - 5 * M_PI_4;
static CGFloat const endAngle = M_PI_4;

@interface MeeProgressView()

@property (nonatomic, assign) CGFloat changeNum;

@property (nonatomic,weak)NSTimer *timer;

@property (nonatomic, weak)  UIButton  * btn;
@property (nonatomic, weak)  UILabel  * label;

@end

@implementation MeeProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:1.00 green:0.64 blue:0.18 alpha:1.00];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"开始" forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor redColor];
        self.btn = btn;
        [btn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        
        UILabel *label  = [[UILabel alloc]init];
        label.backgroundColor = [UIColor redColor];
        self.label = label;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        self.label.text = @"0";
        [self addSubview:label];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.btn.width = 50;
    self.btn.height = 30;
    self.btn.centerX = viewW * 0.5;
    self.btn.y = viewH - self.btn.height - 10;
    
    self.label.width = 50;
    self.label.height = 30;
    self.label.centerX = viewW * 0.5;
    self.label.centerY = viewH * 0.5;
    

}

// 画线必须在drawRect方法中实现
// 因为只有drawRct方法中才能获得根view相关联上下文
// 作用：绘制内容到控件上去
// 什么时候调用：当控件即将显示的时候调用
// rect： 当前控件的bounds值
- (void)drawRect:(CGRect)rect {
   
    // 画刻度底层(这个会话只需要调用一次)
    [self drawBottomView];

    // 画进度
    [self drawProView];
    
    //[self drawHu1];
}

- (void)drawBottomView
{
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    

    
    // NSLog(@"打印 ---》");
    
    // 设置线条宽度
    CGContextSetLineWidth(ctx, 10);
    // 设置线条两端的样式    // 设置线条两端样式 kCGLineCapButt(平角), kCGLineCapRound(圆角),kCGLineCapSquare(平角？)
    CGContextSetLineCap(ctx, kCGLineCapButt);
    
    CGFloat lenght[] = {4, 8};
    // lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复，
    // 如果把lengths值改为｛10, 20, 10｝，则表示先绘制10个点，跳过20个点，绘制10个点，跳过10个点，再绘制20个点，如此反复
    
    /** CGContextSetLineDash 函数画虚线 */
    // 第 1 个参数 ： 上下文
    // 第 2 个参数 ： CGFloat phase 表示在第一个虚线绘制的时候跳过多少个点
    // 第 3 个参数 ：lenghts 指明虚线是如何交替绘制
    // 第 4 个参数 ：size_t count 数组的长度
    CGContextSetLineDash(ctx, 0, lenght, 2);
    
    // 设置颜色
    [[UIColor redColor]set];

    // 设置路径  CGContextAddArc 圆弧
    // radius 半径
    // startAngle 起始的角度
    // endAngle 结束的角度
    // clockwise YES (0) 顺时针，NO (1)逆时针
    CGContextAddArc(ctx, viewW * 0.5, viewH * 0.5, viewW * 0.5 - 10, startAngle, endAngle, 0);
    
    // 绘制
    CGContextStrokePath(ctx);
}

- (void)drawProView
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 10);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGFloat lenght[] = {4 , 8};
    CGContextSetLineDash(ctx, 0, lenght, 2);
    [[UIColor whiteColor]set];
    NSLog(@"self.changeNum====> %1.0f ", self.changeNum);
    
    // kvc 监听
    [self addObserver:self forKeyPath:@"changeNum" options:NSKeyValueObservingOptionNew|  NSKeyValueObservingOptionOld context:nil];
    CGFloat end = -5 * M_PI_4+( 6 * M_PI_4 * self.changeNum/60);
    CGContextAddArc(ctx, viewW * 0.5, viewH * 0.5, viewW * 0.5 - 10, startAngle, end , 0);
    CGContextStrokePath(ctx);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat new = [change[NSKeyValueChangeNewKey] doubleValue];
    // 打印NSLog比较消耗性能
    // NSLog(@"new -----> %1.0f",new);
    self.label.text = [NSString stringWithFormat:@"%1.0f",new];
}

- (void)startClick
{
    NSLog(@"按钮点击");
    // 开启定时器
    if(_timer == nil){
        _timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
        // 默认添加到默认模式，可以重新这句话，修改 模式
        // 将timer 添加到 运行循环中，此时强引用,当 132行结束，timer对象还是存在的，没有被销毁，多次点击按钮，不会进入
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    }else{
      // 暂停
        [_timer invalidate];
    }
}

- (void)changeTime
{
    self.changeNum += 0.1;
    if(_changeNum >= 60){
        _changeNum = 0;
    }
    
    // 重绘
    // drawRect不能手动调用,
    // drawRect只能系统调用,每次系统调用drawRect方法之前,都会给drawRect方法传递一个跟当前view相关联上下文
    [self setNeedsDisplay];
}

//- (void)drawHu1
//{
//    //1.获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    //1.1 设置线条的宽度
//    CGContextSetLineWidth(ctx, 10);
//    //1.2 设置线条的起始点样式
//    CGContextSetLineCap(ctx,kCGLineCapButt);
//    //1.3  虚实切换 ，实线5虚线10
//    CGFloat length[] = {4,8};
//    CGContextSetLineDash(ctx, 0, length, 2);
//    //1.4 设置颜色
//    [[UIColor blackColor] set];
//    //2.设置路径
//    CGContextAddArc(ctx, viewW/2 , viewH * 0.5, 80, -5*M_PI_4, M_PI_4, 0);
//    //3.绘制
//    CGContextStrokePath(ctx);
//    
//}


@end
