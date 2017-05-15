//
//  AppDelegate.m
//  BaiSI
//
//  Created by 兰瑞益 on 17/1/27.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"

#import "Dog.h"
#import "Person.h"
#import "Company.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //self.window.backgroundColor = [UIColor redColor];
    
    self.window.rootViewController = [[TabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
    
//    [self cleanRealm];
//    [self addInitDataToRealm];
//    //[self migrateRealm];
//    [self queryRealm];
//    [self updateRealm];
//    [self multithreadRealm];
//    NSLog(@"db path:%@", [RLMRealm defaultRealm].configuration.fileURL);
    return YES;
}


/**
 清理数据库文件，为测试环境做准备。
 */
- (void)cleanRealm {
    NSFileManager *manager = [NSFileManager defaultManager];
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    NSArray<NSURL *> *realmFileURLs = @[
                                        config.fileURL,
                                        [config.fileURL URLByAppendingPathExtension:@"lock"],
                                        [config.fileURL URLByAppendingPathExtension:@"management"],
                                        ];
    for (NSURL *URL in realmFileURLs) {
        NSError *error = nil;
        [manager removeItemAtURL:URL error:&error];
        if (error) {
            NSLog(@"clean realm error:%@", error);
        }
    }
}
/**
 添加测试数据
 */
- (void)addInitDataToRealm {
    Company *company = [[Company alloc] init];
    company.name = @"GOOGLE";
    
    Person *person = [[Person alloc] init];
    person.name = @"张三";
    person.age = 28;
    person.company = company;
    
    Dog *dog1 = [[Dog alloc] init];
    dog1.name = @"小黑";
    dog1.color = @"黑色";
    
    Dog *dog2 = [[Dog alloc] init];
    dog2.name = @"小狗子";
    dog2.color = @"黑色";
    
    
    Dog *dog3 = [[Dog alloc] init];
    dog3.name = @"大白";
    dog3.color = @"白色";
    
    [person.dogs addObject:dog1];
    [person.dogs addObject:dog2];
    [person.dogs addObject:dog3];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:person];
    }];
}
/**
 查询测试
 */
- (void)queryRealm {
    RLMResults<Dog *> *dogs = [[Dog objectsWhere:@"color = '黑色' AND name BEGINSWITH '小'"]     sortedResultsUsingProperty:@"name" ascending:YES];
    for (Dog *dog in dogs) {
        NSLog(@"dog:%@， owners:%@", dog, dog.owners);
    }
}

/**
 更新测试
 */
- (void)updateRealm {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"color = %@ AND name BEGINSWITH %@", @"白色", @"大"];
    RLMResults *dogs = [Dog objectsWithPredicate:pred];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        for (Dog *dog in dogs) {
            dog.color = @"新的颜色";
        }
    }];
}

/**
 多线程测试
 */
- (void)multithreadRealm {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        NSLog(@"start async");
        RLMResults *results = [Person objectsWhere:@"name = '张三' "];
        if (results.count > 0) {
            Person *person = results[0];
            NSLog(@"outer block, name:%@", person.name);
        }
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            NSLog(@"in async block");
            RLMResults *results = [Person objectsWhere:@"name = '张三' "];
            if (results.count > 0) {
                Person *person = results[0];
                person.name = @"王麻子";
                NSLog(@"change name to wangmazi");
            }
        }];
        if (results.count > 0) {
            Person *person = results[0];
            NSLog(@"async person:%@, tid=%@", person.name, [NSThread currentThread]);
        }
    });
    
    NSArray *names = @[@"张三", @"李四"];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        int i = 0;
        while (i < 2) {
            NSString *name = names[i];
            RLMResults *results = [Person objectsWhere:@"name = %@", name];
            if (results.count > 0) {
                Person *person = results[0];
                if ([person.name isEqualToString:@"李四"]) {
                    person.name = @"王五";
                    NSLog(@"change name to wangwu");
                } else {
                    person.name = @"李四";
                    NSLog(@"change name to lisi");
                }
                sleep(3);
            }
            i++;
        }
    }];
}
- (void)migrateRealm {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 1;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion){
        if (oldSchemaVersion < 1) {}
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
}

@end
