//
//  HHRefreshGifHeader.m
//  CTFreightLoan
//
//  Created by 楚天小贷 on 2019/3/7.
//  Copyright © 2019年 Zzzzzzzzz. All rights reserved.
//

#import "HHRefreshGifHeader.h"

@interface HHRefreshGifHeader ()

@property (nonatomic, strong) NSMutableArray *  imagesArr;

@end
@implementation HHRefreshGifHeader


- (void)prepare {
    
    [super prepare];
    
    [self setImages:self.imagesArr forState:MJRefreshStateIdle];
    [self setImages:self.imagesArr forState:MJRefreshStatePulling];
   
    // 设置正在刷新状态的动画图片
    [self setImages:self.imagesArr forState:MJRefreshStateRefreshing];

}


- (NSMutableArray *)imagesArr {
    
    if (!_imagesArr) {
        _imagesArr = [NSMutableArray arrayWithCapacity:0];
        
        for (int i=0; i<59; i++) { 
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%d",i]];
            [_imagesArr addObject:image];
        }
    }
    return _imagesArr;
}



@end
