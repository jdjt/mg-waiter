//
//  ChatMessage+CoreDataProperties.h
//  waiter
//
//  Created by new on 2017/4/26.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "ChatMessage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ChatMessage (CoreDataProperties)

+ (NSFetchRequest<ChatMessage *> *)fetchRequest;

@property (nullable, nonatomic, retain) TaskList *belongTaskList;

@end

NS_ASSUME_NONNULL_END
