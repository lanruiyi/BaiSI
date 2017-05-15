//
//  NewViewController.m
//  BaiSI
//
//  Created by 兰瑞益 on 17/2/3.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "NewViewController.h"
#import "RLMUser.h"
#import "sqlite3.h"

@interface NewViewController ()
{
    RLMRealm *_customRealm;
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *age;


@property (nonatomic, strong) RLMResults *locArray;

@property (nonatomic, strong) RLMNotificationToken *token;

@property (nonatomic, assign) sqlite3 *database;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LCommonBgColor;
    //标题图片
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //左边按钮
//    UIButton *but = [[UIButton alloc] init];
//    [but setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
//    [but setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
//    [but addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
//    [but sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    [self sqlite3Test];
}

- (void)tagClick{
    

    
}

/* 打开数据库 */
- (void)openDatabase:(NSString *)dbname
{
    //生成沙盒文件路径
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    NSString *filePath = [directory stringByAppendingPathComponent:dbname];
    NSLog(@"%@",filePath);
    //打开数据库，如果数据库存在直接打开，如果数据库不存在，创建并打开
    int result = sqlite3_open(filePath.UTF8String, &_database);
    if (result == SQLITE_OK) {
        NSLog(@"Open Database Success");
    } else {
        NSLog(@"Open Database Fail");
    }
}
/* 执行没有返回值的SQL语句 */
- (void)executeNonQuery:(NSString *)sql
{
    if (!_database) {
        return;
    }
    char *error;
    //执行没有返回值的SQL语句
    int result = sqlite3_exec(_database, sql.UTF8String, NULL, NULL, &error);
    if (result == SQLITE_OK) {
        NSLog(@"Execute SQL Query Success");
    } else {
        NSLog(@"Execute SQL Query Fail error : %s",error);
    }
}
/* 执行有返回值的SQL语句 */
- (NSArray *)executeQuery:(NSString *)sql
{
    if (!_database) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    sqlite3_stmt *stmt; //保存查询结果
    //执行SQL语句，返回结果保存在stmt中
    int result = sqlite3_prepare_v2(_database, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        //每次从stmt中获取一条记录，成功返回SQLITE_ROW，直到全部获取完成，就会返回SQLITE_DONE
        while( SQLITE_ROW == sqlite3_step(stmt)) {
            //获取一条记录有多少列
            int columnCount = sqlite3_column_count(stmt);
            //保存一条记录为一个字典
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            for (int i = 0; i < columnCount; i++) {
                //获取第i列的字段名称
                const char *name  = sqlite3_column_name(stmt, i);
                //获取第i列的字段值
                const unsigned char *value = sqlite3_column_text(stmt, i);
                //保存进字典
                NSString *nameStr = [NSString stringWithUTF8String:name];
                NSString *valueStr = [NSString stringWithUTF8String:(const char *)value];
                dict[nameStr] = valueStr;
            }
            [array addObject:dict];//添加当前记录的字典存储
        }
        sqlite3_finalize(stmt);//stmt需要手动释放内存
        stmt = NULL;
        NSLog(@"Query Stmt Success");
        return array;
    }
    NSLog(@"Query Stmt Fail");
    return nil;
}
/* 关闭数据库 */
- (void)closeDatabase
{
    //关闭数据库
    int result = sqlite3_close(_database);
    if (result == SQLITE_OK) {
        NSLog(@"Close Database Success");
        _database = NULL;
    } else {
        NSLog(@"Close Database Fail");
    }
}
/* 结合SQL语句，操作数据库 */
- (void)sqlite3Test{
    //打开SQlite数据库
    [self openDatabase:@"sqlite3_database.db"];
    //在数据库中创建表
    [self executeNonQuery:@"create table mytable(num varchar(7),name varchar(7),sex char(1),primary key(num));"];
    //在表中插入记录
    [self executeNonQuery:@"insert into mytable(num,name,sex) values (0,'liuting','m');"];
    [self executeNonQuery:@"insert into mytable(num,name,sex) values (1,'zhangsan','f');"];
    [self executeNonQuery:@"insert into mytable(num,name,sex) values (2,'lisi','m');"];
    [self executeNonQuery:@"insert into mytable(num,name,sex) values (3,'wangwu','f');"];
    [self executeNonQuery:@"insert into mytable(num,name,sex) values (4,'xiaoming','m');"];
    //读取数据库的表中数据
    NSArray* result = [self executeQuery:@"select num,name,sex from mytable;"];
    if (result) {
        for (NSDictionary *row in result) {
            NSString *num = row[@"num"];
            NSString *name = row[@"name"];
            NSString *sex = row[@"sex"];
            NSLog(@"Read Database : num=%@, name=%@, sex=%@",num,name,sex);
        }
    }
    [self closeDatabase];
}
/*
 这里就简单列出一些常用的SQL语句：
 
 创建表：
 create table 表名称(字段1,字段2,……,字段n,[表级约束])[TYPE=表类型];
 插入记录：
 insert into 表名(字段1,……,字段n) values (值1,……,值n);
 删除记录：
 delete from 表名 where 条件表达式;
 修改记录：
 update 表名 set 字段名1=值1,……,字段名n=值n where 条件表达式;
 查看记录：
 select 字段1,……,字段n  from  表名 where 条件表达式;
 */
@end
