//
//  MeeWaterFlowCell.m
//  MeeViews
//
//  Created by liwei on 16/4/26.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeWaterFlowCell.h"

@implementation MeeWaterFlowCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.backgroundColor = MeeRandomColor
    
    self.label.backgroundColor = MeeRandomColor;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
   //  CGFloat w = [self.label.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.label.font} context:nil].size.width;
    self.label.width = 20;
}


//- (void)setText:(NSString *)text
//{
//    _text = text;
//    self.label.text = text;
//      CGFloat w = [self.label.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.label.font} context:nil].size.width;
//    self.label.width = w;
//    
//}

@end
