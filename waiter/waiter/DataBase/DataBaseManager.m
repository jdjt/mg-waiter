//
//  DataBaseManager.m
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager

+ (instancetype)defaultInstance
{
    static DataBaseManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}
- (id)init
{
    if (self = [super init])
    {
        // 监听程序进入前后台
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterbackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}
- (void)applicationWillEnterbackground:(NSNotification *)notification{
    [self saveContext];
}
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "tianhongkeji.fsdfsfs" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"waiter" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"waiter.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#warning abort() 会导致软件崩溃退出的同时生成错误日志. 如果你要发布该应用，应当避免使用该方法，它只是在开发阶段会很有用.
            abort();
        }else{
        NSLog(@"coreData数据存储成功!!!");
        }
    }
}



#pragma mark - Core Data using implementation

/**
 *  @abstract 从数据库中取得数据
 *
 */
- (NSArray *)arrayFromCoreData:(NSString *)entityName predicate:(NSPredicate *)predicate limit:(NSUInteger)limit offset:(NSUInteger)offset orderBy:(NSArray *)sortDescriptors
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    if (sortDescriptors != nil && sortDescriptors.count > 0)
        [request setSortDescriptors:sortDescriptors];
    if (predicate)
        [request setPredicate:predicate];
    
    [request setFetchLimit:limit];
    [request setFetchOffset:offset];
    
    NSError *error = nil;
    NSArray *fetchObjects = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error){
        NSLog(@"fetch request error=%@", error);
        return nil;
    }
    
    return fetchObjects;
}

/**
 *  @abstract 向数据库中插入一条新建数据
 *
 */
- (NSManagedObject *)insertIntoCoreData:(NSString *)entityName
{
    NSManagedObject *obj  = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
    return obj;
}

/**
 *  @abstract 从数据库中删除一条数据
 */
- (void) deleteFromCoreData:(NSManagedObject *) obj
{
    [self.managedObjectContext deleteObject:obj];
}
//将指定的数据表格清空
- (void) cleanCoreDatabyEntityName:(NSString*)entityName
{
    NSArray *DBarray = [self arrayFromCoreData:entityName predicate:nil limit:NSIntegerMax offset:0 orderBy:nil];
    if (DBarray.count >0)
    {
        for (NSManagedObject *obj in DBarray)
        {
            [self deleteFromCoreData:obj];
        }
    }
}
/**
 * @abstract 根据任务编号查找本地是否存在
 */
- (BOOL)findWaiterRushByTaskCode:(NSString *)taskCode EntityName:(NSString *)entityName{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskCode = %@", taskCode];
    NSArray *result = [self arrayFromCoreData:entityName predicate:predicate limit:NSIntegerMax offset:0 orderBy:nil];
    if (result.count <= 0 ||result == nil)
        return NO;
    else
       return YES;
}
@end
