//
//  NSManagedObject+Category.m
//  waiter
//
//  Created by new on 2017/4/19.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "NSManagedObject+Category.h"
#import <objc/runtime.h>
@implementation NSManagedObject (Category)
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    if (![keyedValues isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSDictionary * properties = [self properties_aps];
    for (NSString * namekey in properties) {
        if ([keyedValues objectForKey:namekey] && [[properties objectForKey:namekey] isEqualToString:@"NSString"]) {
            [self setValue:[keyedValues objectForKey:namekey] forKey:namekey];
        }
    }
    
}
- (NSArray *)getAllProperties{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
     for (int i = 0; i<count; i++){
         const char* propertyName =property_getName(properties[i]);
         [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}
- (NSDictionary *)properties_aps{
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i<outCount; i++){
        
        objc_property_t property = properties[i];
        
        const char* char_f =property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        
        const char* char_f2 = property_getAttributes(property);
        
        NSString * typeString = [NSString stringWithUTF8String:char_f2];
        NSArray * attributes = [typeString componentsSeparatedByString:@","];
        NSString * typeAttribute = [attributes objectAtIndex:0];
        NSString * propertyType = [typeAttribute substringFromIndex:1];
        //@"NSString"
        NSString * str = @"jdjt";
        
        if (propertyType){
        
            NSMutableString * mutable = [[NSMutableString alloc]initWithString:propertyType];
            if (mutable.length > 10) {
                str = [mutable substringWithRange:NSMakeRange(2, 8)];
                
            }
        
        }
        
        [props setValue:str forKey:propertyName];
        
        
        
        
    }
    
    free(properties);
    
    return props;
    
}

@end
