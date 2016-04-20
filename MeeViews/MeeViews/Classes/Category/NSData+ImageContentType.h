//
//  NSData+ImageContentType.h
//  MeeViews
//
//  Created by liwei on 16/4/20.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ImageContentType)

// 就是根据图片的二进制数据返回其对应的MIME类型
+ (NSString *)sd_contentTypeForImageData:(NSData *)data;

@end

