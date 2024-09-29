//
//  HHListPopView.m
//  RenMinWenLv
//
//  Created by Mac on 2021/8/26.
//

#import "HHListPopView.h"

@implementation HHListPopModel

@end

@interface HHListPopView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView            *  whiteView;
@property (nonatomic, strong) UITableView       *  tableView;

@property (nonatomic, copy)  NSString           *  title;
@property (nonatomic, strong) NSArray           *  dataArray;

@property (nonatomic, copy)  void (^sureBlock)(id data);
@property (nonatomic, copy)  void (^cancleBlock)(void);

@end

@implementation HHListPopView

- (instancetype)init{
    if(self=[super init]) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title dataArray:(NSArray *)dataArray {
    if(self=[super init]) {
        
        self.title = title;
        self.dataArray = dataArray;
        [self createUI];
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
    return self;
}

- (void)createUI {
    
    UIView *maskView = [[UIView alloc] init];
    [maskView addTapGestureWithTarget:self action:@selector(hide)];
    [self addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView.alpha = 0;
    self.whiteView.layer.cornerRadius = 8;
    self.whiteView.clipsToBounds = YES;
    [self addSubview:self.whiteView];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    /*标题*/
    UIView *topView = [[UIView alloc] init];
    [self.whiteView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
    }];
    
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = self.title;
    titleLB.font = KBOLDFONT(16);
    titleLB.textColor = MainTextColor;
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.numberOfLines = 0;
    [topView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"arrow_bottom_black"];
    iconImg.contentMode = UIViewContentModeCenter;
    [topView addSubview:iconImg];
    [iconImg addTapGestureWithTarget:self action:@selector(hide)];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.estimatedRowHeight = 0;
    tableView.backgroundColor = BackGroundColor;
    [self.whiteView addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        if (self.dataArray.count >= 6) {
            make.height.mas_equalTo(6 * 50);
        }else{
            make.height.mas_equalTo(self.dataArray.count * 50);
        }
    }];
    self.tableView = tableView;
}



- (void)hide {
    
    [self shakeToHide:self.whiteView];

    [UIView animateWithDuration:0.3 animations:^{
        self.whiteView.alpha = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"listPopViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = DarkTextColor;
        cell.textLabel.font = KFONT(16);
    }
    
    id data = self.dataArray[indexPath.row];
    if ([data isKindOfClass:[HHListPopModel class]]) {
        HHListPopModel *model = (HHListPopModel *)data;
        cell.textLabel.text = model.name;
    }else{
        cell.textLabel.text = [data objectForKey:@"name"];
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HHLog(@"第%ld组 -- 第%ld行",indexPath.section, indexPath.row);

    if (self.sureBlock) {
        self.sureBlock(self.dataArray[indexPath.row]);
    }
    [self hide];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

+ (void)showWithTitle:(NSString *)title dataArray:(NSArray *)dataArray sureBlock:(void (^)(id data))sureBlock {
    
    [HHListPopView showWithTitle:title dataArray:dataArray sureBlock:sureBlock cancleBlock:nil];
}

+ (void)showWithTitle:(NSString *)title dataArray:(NSArray *)dataArray sureBlock:(void (^)(id data))sureBlock cancleBlock:(nullable void (^)(void))cancleBlock {
    
    [APP_KeyWindow endEditing:YES];
    
    //创建弹出视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    HHListPopView *alter = [[HHListPopView alloc] initWithTitle:title dataArray:dataArray];
    alter.sureBlock = sureBlock;
    alter.cancleBlock = cancleBlock;
    [window addSubview: alter];
    [alter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [alter shakeToShow:alter.whiteView];
    
    [UIView animateWithDuration:0.3 animations:^{
        alter.whiteView.alpha = 1;
        alter.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    } completion:nil];
}


- (void)shakeToShow:(UIView *)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.8, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.5, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.2, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];

    animation.values = values;
    
    [aView.layer addAnimation:animation forKey:@"ShakeToShow"];
}

- (void)shakeToHide:(UIView *)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.2, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.5, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.8, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight, 0)]];
    
    animation.values = values;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [aView.layer addAnimation:animation forKey:@"ShakeToHide"];
}

@end
