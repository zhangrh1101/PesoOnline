//
//  HHAlterListPopView.m
//  RenMinWenLv
//
//  Created by Mac on 2021/8/26.
//

#import "HHAlterListPopView.h"

@implementation HHAlterListModel

@end

@interface HHAlterListPopView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView            *  whiteView;
@property (nonatomic, strong) UITableView       *  tableView;

@property (nonatomic, strong) NSArray           *  dataArray;

@property (nonatomic, copy)  void (^sureBlock)(id data);
@property (nonatomic, copy)  void (^cancleBlock)(void);

@end

@implementation HHAlterListPopView

- (instancetype)init{
    if(self=[super init]) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithDataArray:(NSArray *)dataArray {
    if(self=[super init]) {
        
        self.dataArray = dataArray;
        [self createUI];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
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

    //列表
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.estimatedRowHeight = 0;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.whiteView addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        if (self.dataArray.count >= 6) {
            make.height.mas_equalTo(6 * 55);
        }else{
            make.height.mas_equalTo(self.dataArray.count * 55);
        }
    }];
    self.tableView = tableView;
    
    self.tableView.scrollEnabled = NO;
    if (self.dataArray.count > 6) {
        self.tableView.scrollEnabled = YES;
    }
    
    /*间隔*/
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BackGroundColor;
    [self.whiteView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    /*标题*/
    UIView *cancelView = [[UIView alloc] init];
    [cancelView addTapGestureWithTarget:self action:@selector(hide)];
    [self.whiteView addSubview:cancelView];
    [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UILabel *cancelLB = [[UILabel alloc] init];
    cancelLB.text = @"取消";
    cancelLB.font = KFontHarmonyOSMedium(16);
    cancelLB.textColor = MainTextColor;
    cancelLB.textAlignment = NSTextAlignmentCenter;
    cancelLB.numberOfLines = 0;
    [cancelView addSubview:cancelLB];
    [cancelLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-KSafeAreaMargin);
        make.height.mas_equalTo(50);
    }];
}



- (void)hide {

    [UIView animateWithDuration:0.3 animations:^{
        
        [self shakeToHide:self.whiteView];
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
    HHAlterListPopViewCell *cell = [HHAlterListPopViewCell cellForTableView:tableView];
    
    id data = self.dataArray[indexPath.row];
    if ([data isKindOfClass:[HHAlterListModel class]]) {
        HHAlterListModel *model = (HHAlterListModel *)data;
        cell.model = model;
    }else{
        cell.name = [data objectForKey:@"name"];
        if ([data objectForKey:@"icon"]) {
            cell.icon = [data objectForKey:@"icon"];
        }
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
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

+ (void)showWithDataArray:(NSArray *)dataArray sureBlock:(void (^)(id data))sureBlock {
    
    [HHAlterListPopView showWithDataArray:dataArray sureBlock:sureBlock cancleBlock:nil];
}

+ (void)showWithDataArray:(NSArray *)dataArray sureBlock:(void (^)(id data))sureBlock cancleBlock:(nullable void (^)(void))cancleBlock {
    
    [APP_KeyWindow endEditing:YES];
    
    //创建弹出视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    HHAlterListPopView *alter = [[HHAlterListPopView alloc] initWithDataArray:dataArray];
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



/*
 * HHAlterListPopViewCell
 */
@interface HHAlterListPopViewCell ()

@property (nonatomic, strong) UIImageView          *  iconImageView;
@property (nonatomic, strong) UILabel              *  nameLabel;

@end

@implementation HHAlterListPopViewCell

+ (instancetype)cellForTableView:(UITableView *)tableView {
    
    NSString *cellID = @"HHAlterListPopViewCellID";
    
    HHAlterListPopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[HHAlterListPopViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = KFONT(16);
    self.nameLabel.textColor = MainTextColor;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(self.nameLabel.mas_left).offset(-5);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = SeparationlineColor;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-0.5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(0.5);
    }];
}


- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
}

- (void)setIcon:(NSString *)icon {
    self.iconImageView.image = [UIImage imageNamed:icon];
}

- (void)setModel:(HHAlterListModel *)model {
    self.nameLabel.text = model.name;
}

    
@end
