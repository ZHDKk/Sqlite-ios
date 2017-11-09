//
//  ViewController.m
//  sqlite数据库
//
//  Created by zh dk on 2017/8/30.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //按钮标题数组
    NSArray *arrayTitle = [NSArray arrayWithObjects:@"创建数据库",@"插入数据",@"删除数据",@"查找数据", nil];
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        btn.frame = CGRectMake(100, 100+80*i, 100, 40);
        
        
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = 100+i;
        [btn setTitle:arrayTitle[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
    
   
}

-(void) pressBtn:(UIButton*)btn
{
    
    //获取数据库的创建路径
    NSString *strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
    _DB = [FMDatabase databaseWithPath:strPath];
    //创建数据库
    if (btn.tag == 100) {
        
            if (_DB!=nil) {
            NSLog(@"数据库创建成功");
        }
        
        //打开数据库
        BOOL isOpen = [_DB open];
        if (isOpen) {
            NSLog(@"打开数据库成功");
        }
        
        //创建一个sql语句
        NSString *strCreateTable = @"create table if not exists stu(id integer primary key,age integer,name varchar(20))";
        
        //执行sql语句，sql语句有效;如果执行成功救回返回YES结果，如果失败就是NO
        BOOL isCreate =   [_DB executeUpdate:strCreateTable];
        if(isCreate){
            NSLog(@"创建数据库表成功");
        }
        //关闭数据库
        BOOL isClose = [_DB close];
        if (isClose) {
            NSLog(@"关闭数据库");
        }
    }
    //添加数据
    else if (btn.tag == 101){
        
        //获取数据库的创建路径
        NSString *strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
        _DB = [FMDatabase databaseWithPath:strPath];
        
        if (_DB!=nil) {
            if ([_DB open]) {
                NSString *strInsert = @"insert into stu values(2,18,'zdk')";
                
               BOOL isOk =  [_DB executeUpdate:strInsert];
                if (isOk==YES) {
                    NSLog(@"添加数据成功");
                }
            }
        }
    }
    //删除数据
    else if (btn.tag == 102){
        //获取数据库的创建路径
        NSString *strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
        _DB = [FMDatabase databaseWithPath:strPath];
        //创建查找sql语句
        NSString *strDelete = @"delete from stu where id =1";
        if ([_DB open]) {
            [_DB executeUpdate:strDelete];
        }
    }
    //查找数据
    else if (btn.tag == 103){
        //获取数据库的创建路径
        NSString *strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
        _DB = [FMDatabase databaseWithPath:strPath];
        //创建查找sql语句
        NSString *strQuery = @"select *from stu";
        
        if ([_DB open]) {
            //执行查找sql语句
           FMResultSet *result= [_DB executeQuery:strQuery];
            
            //遍历所有数据
            while ([result next]) {
                NSInteger stuID = [result intForColumn:@"id"];
                NSString *strName = [result stringForColumn:@"name"];
                NSInteger stuAge = [result intForColumn:@"age"];
                
                NSLog(@"stu id = %d,name = %@,age = %d",stuID,strName,stuAge);
            }
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
