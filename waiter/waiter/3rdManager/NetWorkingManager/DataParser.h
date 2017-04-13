//
//  DataParser.h
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//


@interface DataParser : NSObject
+(NSMutableArray *)parserUrl:(NSString*)ident fromData:(id)dict;
@end
