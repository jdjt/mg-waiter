//
//  DataBaseManager.h
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
@interface DataBaseManager : NSObject
// 单例模式的数据管理器
+ (instancetype)defaultInstance;

#pragma mark - NSManagedObjectContext Methods

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


/**
 从数据库中取得数据

 @param entityName 将要访问的实体名称，对应数据库的表格名称
 @param predicate 查询条件，用于过滤数据
 @param limit 限定返回结果的数量（基于查询条件，以及起始偏移量和排序方法）
 @param offset 排序状况下返回结果的起始点
 @param sortDescriptors 排序方法
 @return NSArray
 */
- (NSArray *)arrayFromCoreData:(NSString *)entityName predicate:(NSPredicate *)predicate limit:(NSUInteger)limit offset:(NSUInteger)offset orderBy:(NSArray *)sortDescriptors;

/**
 *  @abstract 向数据库中插入一行数据
 *  @entityName  将要访问的实体名称，对应数据库的表格名称
 *  @return 返回的实体对象引用，更新该对象内容即可
 */
- (NSManagedObject *)insertIntoCoreData:(NSString *)entityName;

/**
 *  @abstract 删除指定的记录
 *  @param obj 要删除的对象
 */
- (void)deleteFromCoreData:(NSManagedObject *) obj;

/**
 *  @abstract 将指定的数据表格清空
 *  @param entityName 要删除的数据表格名
 */
- (void)cleanCoreDatabyEntityName:(NSString*)entityName;

/**
 * @abstract 根据任务编号查找本地是否存在
 */
- (BOOL)findWaiterRushByTaskCode:(NSString *)taskCode EntityName:(NSString *)entityName;





@end
