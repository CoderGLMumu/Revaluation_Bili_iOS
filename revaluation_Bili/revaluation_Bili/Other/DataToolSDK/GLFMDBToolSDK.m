//
//  GLFMDBToolSDK.m
//  revaluation_Bili
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLFMDBToolSDK.h"



@interface GLFMDBToolSDK ()
@property (nonatomic, strong) FMDatabaseQueue *queue;
@end

@implementation GLFMDBToolSDK

- (void)insertWithSql:(NSString *)DML_sql, ...NS_REQUIRES_NIL_TERMINATION
{
    /*
     // FMDB中可以用?当作占位符, 但是需要注意: 如果使用问号占位符, 以后只能给占位符传递对象
     */
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    va_list params; //定义一个指向个数可变的参数列表指针;
    va_start(params,DML_sql);//va_start 得到第一个可变参数地址,
    id arg;
    if (DML_sql) {
        //将第一个参数添加到array
//        id prev = DML_sql;
//        [argsArray addObject:prev];
        //va_arg 指向下一个参数地址
        //这里是问题的所在 网上的例子，没有保存第一个参数地址，后边循环，指针将不会在指向第一个参数
        while( (arg = va_arg(params,id)) )
        {
            if ( arg ){
                [argsArray addObject:arg];  
            }  
        }  
        //置空  
        va_end(params);
    }
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
//        let sql = "insert into t_stu(name, age, score) values ('zhangsan', 18, 99)"
//        @"INSERT INTO t_student(score, name) VALUES (?, ?);", @(20), @"jackson"
        BOOL success = [db executeUpdate:DML_sql withArgumentsInArray:argsArray];
        
        if (success) {
            NSLog(@"插入成功");
        }else
        {
            NSLog(@"插入失败");
        }
        
    }];
    
}

- (void)deleteWithSql:(NSString *)DML_sql
{//@"delete from t_stu where name = 'zhangsan'"
    NSString *sql = DML_sql;
    [self.queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:sql]) {
            NSLog(@"删除数据成功");
        }else
        {
            NSLog(@"删除数据失败");
        }
    }];
}

- (void)updateWithSql:(NSString *)DML_sql
{
    /*
     [self.queue inDatabase:^(FMDatabase *db) {
     
     // 开启事务
     [db beginTransaction];
     
     [db executeUpdate:@"UPDATE t_student SET score = 1500 WHERE name = 'zs';"];
     
     NSArray *array = @[@"abc"];
     array[1];
     
     [db executeUpdate:@"UPDATE t_student SET score = 500 WHERE name = 'ls';"];
     // 提交事务
     [db commit];
     }];
     
     
     let sql = "update t_stu set age = 999 where name = 'zhangsan'"
     queue.inDatabase { (db: FMDatabase!) in
     if db.executeUpdate(sql, withArgumentsInArray: nil) {
     print("成功")
     }else {
     print("失败")
     }
     }
     
     */
    //@"UPDATE t_student SET score = 1500 WHERE name = 'zs';"
    //@"UPDATE t_student SET score = 500 WHERE name = 'ls';"
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:DML_sql];
        
//        NSArray *array = @[@"abc"];
//        array[1];
        
        [db executeUpdate:DML_sql];
    }];
}

- (FMResultSet *)queryWithSql:(NSString *)DML_sql
{
    /*
     // FMDB框架中查询用executeQuery方法
     // FMResultSet结果集, 结果集其实和tablevivew很像
     FMResultSet *set = [self.db executeQuery:@"SELECT id, name, score FROM t_student;"];
     while ([set next]) { // next方法返回yes代表有数据可取
     int ID = [set intForColumnIndex:0];
     //        NSString *name = [set stringForColumnIndex:1];
     NSString *name = [set stringForColumn:@"name"]; // 根据字段名称取出对应的值
     double score = [set doubleForColumnIndex:2];
     NSLog(@"%d %@ %.1f", ID, name, score);
     }
     */
    
    //@"SELECT id, name, score FROM t_student;
    
    __block FMResultSet *set = nil;
    
    [self.queue inDatabase:^(FMDatabase *db) {
        // FMResultSet结果集, 结果集其实和tablevivew很像
        set = [db executeQuery:DML_sql];
        
/*
        while ([set next]) { // next方法返回yes代表有数据可取
            int ID = [set intForColumnIndex:0];
            //        NSString *name = [set stringForColumnIndex:1];
            NSString *name = [set stringForColumn:@"name"]; // 根据字段名称取出对应的值
            double score = [set doubleForColumnIndex:2];
            NSLog(@"%d %@ %.1f", ID, name, score);
        }
 
 */
 
    }];
    
    return set;
}

#pragma mark - 单例
static GLFMDBToolSDK *_instance;

//类方法，返回一个单例对象
+ (instancetype)shareToolsWithCreateDDL:(NSString *)DDL
{
    GLFMDBToolSDK *tool = [[self alloc]init];
    // 0.获取沙盒地址
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *sqlFilePath = [path stringByAppendingPathComponent:@"revaluation_Bili.sqlite"];
    
    // 1.创建一个FMDatabaseQueue对象
    // 只要创建数据库队列对象, FMDB内部就会自动给我们加载数据库对象
    tool.queue = [FMDatabaseQueue databaseQueueWithPath:sqlFilePath];
    
    // 2.执行操作
    // 会通过block传递队列中创建好的数据库给我们
    [tool.queue inDatabase:^(FMDatabase *db) {
        // 编写需要执行的代码
        // 2.1创建表(在FMDB框架中, 增加/删除/修改/创建/销毁都统称为更新)
        //            @"CREATE TABLE IF NOT EXISTS t_student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, score REAL DEFAULT 1);"
        BOOL success = [db executeUpdate:DDL];
        
        if (success) {
            NSLog(@"创建表成功");
        }else
        {
            NSLog(@"创建表失败");
        }
        
    }];
    
    //注意：这里建议使用self,而不是直接使用类名Tools（考虑继承）
    
    return tool;
}

//保证永远只分配一次存储空间
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    //    使用GCD中的一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });

    return _instance;
}

/** 事务、多条插入
 
 func transactionTest() -> () {
 queue.inTransaction { (db: FMDatabase!, rollback) in
 
 let sql = "update t_stu set score = score + 10 where name = 'zhangsan'"
 let sql2 = "update t_stu set score = score - 10 where name = 'lisi'"
 let result1 = db.executeUpdate(sql, withArgumentsInArray: nil)
 let result2 = db.executeUpdate(sql2, withArgumentsInArray: nil)
 
 if result1 && result2 {
 
 }else {
 
 // 回滚 *rollback = rollback.memory
 rollback.memory = true
 
 }
 
 
 }
 }
 
 
 func stamentsTest() -> () {
 let sql = "insert into t_stu(name, age, score) values ('zhangsan3', 18, 99);insert into t_stu(name, age, score) values ('zhangsan2', 18, 99);"
 queue.inDatabase { (db) in
 db.executeStatements(sql)
 }
 }

 
 */



@end
