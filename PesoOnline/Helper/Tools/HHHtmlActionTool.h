//
//  HHHtmlActionTool.h
//  RenMinSanNong
//
//  Created by Mac on 2021/9/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HHHtmlActionToolType) {
    HHHtmlActionToolShare = 0,
    HHHtmlActionToolLiveShare = 1,
    HHHtmlActionToolPassword = 2,
};

@interface HHHtmlActionTool : NSObject

+ (HHHtmlActionTool *)actionTool;

- (void)loadFileWithType:(HHHtmlActionToolType)type resultBlock:(void (^)(id _Nullable result))resultBlock;

/*详情ID*/
@property (nonatomic, copy) NSString    * contentId;

/*登录密码加密*/
- (void)html_loginPassword:(NSString *)password;
/*修改密码加密*/
- (void)html_encryPassword:(NSString *)password;

- (void)removeTool;


@end

NS_ASSUME_NONNULL_END
