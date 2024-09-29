//
//  ApiCheckTools.m
//  FasterVpn
//
//  Created by mac mini on 2022/7/8.
//

#import "ApiCheckTools.h"

//https://mapi.kuaijiasuhouduan.com/,
//https://mapi.kjsjsq.xyz/",
//http://103.14.34.157:8012/,
//http://154.204.26.72:8012/,
//http://103.118.41.154:8012/,
//http://206.233.135.69:8012/


@interface ApiCheckTools ()

@end

/* 检查域名工具 */
@implementation ApiCheckTools

static ApiCheckTools *tools = nil;
+ (ApiCheckTools *)shareManager
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        tools = [[ApiCheckTools alloc] init];
    });
    
    return tools;
}

- (void)checkApi {
    
    //黑豹
    NSArray *ApiArray = @[@"https://mapi.heibaohouduan.com/",
                          @"http://154.23.186.11:8022/",
                          @"http://154.204.26.72:8022/",
                          @"http://103.118.41.154:8022/"];

    
    [self requestCheckApi:ApiArray];
}


//检查域名接口
- (void)requestCheckApi:(NSArray *)urlList {
    NSLog(@"检查域名列表 %@", urlList);
    
    [MBProgressHUD showHUD];
    //是否有可用域名
    __block BOOL ApiUsing = NO;
    __block NSMutableArray *apiUseArray = [NSMutableArray arrayWithCapacity:0];
    
    // 1.创建一个串行队列，保证for循环依次执行
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    // 2.异步执行任务
    dispatch_async(serialQueue, ^{
        // 2.创建任务组
        dispatch_group_t group = dispatch_group_create();
        // 4.创建一个数目为1的信号量，用于“卡”for循环，等上次循环结束在执行下一次的for循环
        dispatch_semaphore_t sema = dispatch_semaphore_create(1);
        for (int i = 0; i < urlList.count; i++) {
            // 开始执行for循环，让信号量-1，这样下次操作须等信号量>=0才会继续,否则下次操作将永久停止
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            dispatch_group_enter(group);
            //有可用就直接跳出
            if (ApiUsing) {
                dispatch_group_leave(group);
                dispatch_semaphore_signal(sema);
                break;
            }
            // 模拟一个异步任务
            NSString *urlSting = [NSString stringWithFormat:@"%@%@", urlList[i], CheckApiCanUseUrl];
            [[AFHttpManager sharedManager] GET:urlSting parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                HHLog(@"检查域名接口success %d %@", i, urlSting);
                //添加可用域名
                ApiUsing = YES;
                [apiUseArray addObject:urlSting];
                //进入信号量
                dispatch_semaphore_signal(sema);
                dispatch_group_leave(group);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                HHLog(@"检查域名接口failure %d %@", i, urlSting);
                //进入信号量
                dispatch_semaphore_signal(sema);
                dispatch_group_leave(group);
            }];
        }
        NSLog(@"信号量执行完毕");
        // 1 2 3 都完成 才会执行
        dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
            NSLog(@"taskSuccess!");
            if (apiUseArray.count > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showMessage:@"更新成功"];
                    [[AFHttpManager sharedManager] setValue:[NSURL URLWithString:apiUseArray[0]] forKey:@"baseURL"];
                    return;
                });
            }else{
                [MBProgressHUD showHUD];
                [self requestHttpApiListUrl];
            }
        });
    });
    
    NSLog(@"其他操作");
}



//获取备用域名列表
- (void)requestHttpApiListUrl {
    
    NSArray *ApiArray = @[@"http://45.207.33.169:8022/",
                          @"http://203.86.235.231:8022/"];
    
    WeakSelf
    for (NSString *urlStr in ApiArray) {
        NSString *urlSting = [NSString stringWithFormat:@"%@%@", urlStr, HttpApiListUrl];
        [[AFHttpManager sharedManager] GET:urlSting parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *urlList = responseObject[@"data"];
            [weakSelf requestCheckApi:urlList];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}



@end
