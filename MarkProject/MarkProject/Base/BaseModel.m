//
//  BaseModel.m
//  MarkProject
//
//  Created by 孙冬 on 2020/5/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+(void)createTableIfNoExit
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{} Fail:^{return;}];
    //计划表
    NSString *createPlanTableSqlString = @"CREATE TABLE IF NOT EXISTS PlanList"
    "(PlanID            integer PRIMARY KEY AUTOINCREMENT,"
    "PlanTitle          text    NOT NULL,"
    "PlanDayDate        text    NOT NULL,"
    "priority           integer NOT NULL,"
    "PlanItemBeginDate  integer NOT NULL, "
    "PlanItemEndDate    integer NOT NULL, "
    "CurrentTime        integer NOT NULL)";
    [db executeUpdate:createPlanTableSqlString];
    //随想
    NSString *createSuiXiangTableSqlString = @"CREATE TABLE IF NOT EXISTS MDList "
    "(MDID          integer PRIMARY KEY AUTOINCREMENT,"
    "Title          text    NOT NULL,"
    "Type           text    NOT NULL,"
    "FilePath       text            ,"
    "StoragePath    text            ,"
    "CreateTime     text    NOT NULL,"
    "UpdateTime     text    NOT NULL,"
    "CurrentTime    integer NOT NULL)";
    [db executeUpdate:createSuiXiangTableSqlString];
    //账单
    NSString *createBillTableSqlString = @"CREATE TABLE IF NOT EXISTS BillList"
    "(BillID        integer     PRIMARY KEY AUTOINCREMENT,"
    "type           integer     NOT NULL,"
    "money          text        NOT NULL,"
    "name           text        NOT NULL,"
    "currentDateStr text        NOT NULL,"
    "mark           text                ,"
    "currentDate    text        NOT NULL)";
    [db executeUpdate:createBillTableSqlString];
    //密码本
    NSString *createTableSqlString = @"CREATE TABLE IF NOT EXISTS SecretList"
    "(ID            integer PRIMARY KEY AUTOINCREMENT,"
    "Name           text    NOT NULL,"
    "NameURL        text            ,"
    "Account        text    NOT NULL,"
    "PassWord       text    NOT NULL,"
    "Note           text            ,"
    "createdAt      integer NOT NULL,"
    "updatedAt      integer NOT NULL)";
    [db executeUpdate:createTableSqlString];
    //便签
    NSString *createNoteTableSqlString = @"CREATE TABLE IF NOT EXISTS MemoList"
    "(ID            integer PRIMARY KEY AUTOINCREMENT,"
    "memoTitle      text    NOT NULL,"
    "memoContent    text            ,"
    "memoColorHex   text    NOT NULL,"
    "createdAt      integer NOT NULL,"
    "updatedAt      integer NOT NULL)";
    [db executeUpdate:createNoteTableSqlString];
    [db close];
}

+(void)deleteWithTableName:(NSString *)str deleteID:(NSInteger)deleteID
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{} Fail:^{
        return ;
    }];
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where ID = ?",str];
    BOOL result = [db executeUpdate:sql, deleteID];
    if (!result) {
        [MDMethods showTextMessage:@"删除失败"];
    }
    [db close];
}
@end
