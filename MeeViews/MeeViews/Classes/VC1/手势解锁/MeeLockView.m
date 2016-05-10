//
//  MeeLockView.m
//  MeeViews
//
//  Created by liwei on 16/5/9.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeLockView.h"
#import "GesturePasswordButton.h"

@interface MeeLockView()

@property (nonatomic, strong)  NSMutableArray<GesturePasswordButton *>  * buttons;
@property (nonatomic, assign) CGPoint currentPoint; /**< 屏幕当前的触摸点 */
@property (nonatomic, assign) BOOL success; //  判断密码是否满足要求，不满足要求线和按钮显示红色
@property (nonatomic, assign) BOOL hasTouchEnd;
@end

@implementation MeeLockView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置默认值为YES
        self.success = YES;
        // 创建按钮
        for (int i = 0; i < 9 ; i++) {
            GesturePasswordButton *btn = [[GesturePasswordButton alloc]init];
            // 给按钮添加标签
            btn.tag = i;
            [self addSubview:btn];
        }
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置每行有几个按钮
    NSInteger numBtnOfRow = 3;
    
    // 初始化按钮的位置
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat btnHW = 74;
    // 按钮之间的间距
    CGFloat space = (MeeScreenW - btnHW * numBtnOfRow ) / (numBtnOfRow + 1);
    for (int i = 0; i < 9; i++) {
        // 行
        CGFloat row = i / numBtnOfRow;
        // 列
        CGFloat cols = i % numBtnOfRow;
        
        x = space + (btnHW + space) * cols;
        y = 50 + (btnHW + space) * row;
        
        // 设置button的frame
        GesturePasswordButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, btnHW, btnHW);
    }
}

#pragma mark - 手势触摸

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hasTouchEnd = NO;
    // 清除手势
    [self setdeleteAllGesturePassword];
    
    [self selectButton:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.success = YES;
    [self selectButton:touches withEvent:event];
}

// 当手指抬起，手势消失，记录密码
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    self.hasTouchEnd = YES;
    NSMutableString *str = [NSMutableString string];
    
        // 遍历所有的按钮，将选中的状态设置为 NO；
    for(GesturePasswordButton *btn in self.buttons){
        btn.selected = YES;
        [btn setNeedsDisplay];
        // 记录密码
        [str appendFormat:@"%zd",btn.tag];
    }
    // 通知代理
    NSLog(@"------> %@",str);
    if ([self.delegate respondsToSelector:@selector(reslutIsTure:)]) {
        self.success = [self.delegate reslutIsTure:str];
    }

    // 当密码不成功，将原来的按钮变成红色
    if (!self.success) {
        for(GesturePasswordButton *btn in self.buttons){
            btn.selected = YES;
            btn.success = NO;
            [btn setNeedsDisplay];
        }
    }
    // 重绘
    [self setNeedsDisplay];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.userInteractionEnabled = NO;
//        [self setdeleteAllGesturePassword];
//    });
//    self.userInteractionEnabled = YES;
}

#pragma mark - 清除手势
- (void)setdeleteAllGesturePassword
{
    
    if(self.buttons.count != 0){
        for (GesturePasswordButton *btn in self.buttons ) {
            btn.selected = NO;
            btn.success = YES;
            // 绘按钮
            [btn setNeedsDisplay];
        }
        [self.buttons removeAllObjects];
        // 重绘
        [self setNeedsDisplay];
    }
}


#pragma mark - 按钮被选择判断
- (void)selectButton:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获取触摸对象
    UITouch *touch = [touches anyObject];
    // 获取当前的触摸点
    CGPoint currentPoint = [touch locationInView:self];
    self.currentPoint = currentPoint;
    // 判断点在不在button上，要获取button
    for(GesturePasswordButton *btn in self.subviews){
        //将View上的点转换成button上面的点
        CGPoint point = [self convertPoint:currentPoint toView:btn];
        // 判断
        if([btn pointInside:point withEvent:event] && btn.selected == NO){
            btn.selected = YES;
            btn.success =YES;
            // 绘按钮
            [btn setNeedsDisplay];
            // 将选中的按钮放在数组中
            [self.buttons addObject:btn];
        }
    }
    // 绘线条
    [self setNeedsDisplay];

}


#pragma mark - buttons
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}


#pragma mark - 圆圈之间连线,给选中的点连线
- (void)drawRect:(CGRect)rect
{
    for (int i=0; i<self.buttons.count; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        NSLog(@"success ----> %zd",self.success);
        if (self.success) {
            CGContextSetRGBStrokeColor(context, 16.0/255,93.0/255 ,54.0/255, 0.7);//线条颜色
        }
        else {
            CGContextSetRGBStrokeColor(context, 208/255.f, 36/255.f, 36/255.f, 0.7);//红色
        }
        CGContextSetLineWidth(context,5);
        CGContextMoveToPoint(context, self.buttons[i].center.x,self.buttons[i].center.y);
        
        if (i < self.buttons.count-1) {
            CGContextAddLineToPoint(context,self.buttons[i+1].center.x,self.buttons[i+1].center.y);
        }else{
            if (self.success && (self.hasTouchEnd == NO)) {
                CGContextAddLineToPoint(context, self.currentPoint.x,self.currentPoint.y);
            }
        }
        CGContextStrokePath(context);
    }
}






@end
