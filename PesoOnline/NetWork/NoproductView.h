//
//  NoproductView.h
//  LongLongLiCai
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoProductManager.h"
@interface NoproductView : UIView

@property (nonatomic, assign)  ExceptionType  exceptionType;

@property (nonatomic, copy)  NSString  * eventTitle;

@property (nonatomic, copy) void (^reloadNetworkDataSource)(void);


@end
