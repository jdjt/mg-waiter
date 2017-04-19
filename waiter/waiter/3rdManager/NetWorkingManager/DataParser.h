//
//  DataParser.h
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//


@interface DataParser : NSObject

/**
 解析网络数据

 @param ident url
 @param dict 网络请求返回的数据
 @return id类型，(为nil时是不需要返回数据的)(为NSNumber时，返回BOOL类型，为“retOk”成功或失败)
 */
+(id)parserUrl:(NSString*)ident fromData:(id)dict;
@end
