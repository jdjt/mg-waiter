//
//  ChatMessage+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/21.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "ChatMessage+CoreDataProperties.h"

@implementation ChatMessage (CoreDataProperties)

+ (NSFetchRequest<ChatMessage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ChatMessage"];
}

@dynamic belongTaskList;

@end
