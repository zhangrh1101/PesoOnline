//
//  HomeTableCell.m
//  WisePeople
//
//  Created by mac mini on 2022/8/17.
//

#import "HomeTableCell.h"
#import "HHWebViewController.h"

@class HomeCellItemView;

@interface HomeTableCell ()

@property (nonatomic, strong) UIView               *  backView;
@property (nonatomic, strong) UILabel              *  titleLabel;
@property (nonatomic, strong) UIView               *  itemViews;
@end

@implementation HomeTableCell

+ (instancetype)cellForTableView:(UITableView *)tableView {
    
    NSString *cellID = [NSString stringWithFormat:@"HomeTableCellID"];
    
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[HomeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.backView.layer.cornerRadius = 10;
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(HHEdge(0, 15, 15, 15));
    }];
    
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HHAutoWidth(15));
        make.left.mas_equalTo(HHAutoWidth(20));
    }];
    
    [self.backView addSubview:self.itemViews];
    [self.itemViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(HHAutoWidth(15));
        make.left.mas_equalTo(HHAutoWidth(15));
        make.right.mas_equalTo(HHAutoWidth(-15));
        make.bottom.mas_equalTo(HHAutoWidth(-5));
    }];
}

#pragma mark - Set
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    if (self.itemViews.subviews.count > 0) {
        return;
    }
    NSLog(@"dataArray %ld", dataArray.count);
    
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HomeCellItemView *itemView = [[HomeCellItemView alloc] init];
        itemView.data = (NSDictionary *)obj;
        itemView.tag = idx;
        [itemView addTarget:self action:@selector(itemViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemViews addSubview:itemView];
    }];
    
    //子视图布局
    [self.itemViews.subviews mas_distributeSudokuViewsWithFixedLineSpacing:10 fixedInteritemSpacing:10 warpCount:4 topSpacing:0 bottomSpacing:0 leadSpacing:0 tailSpacing:0];
    NSInteger column = ((dataArray.count - 1) / 4) + 1;
    [self.itemViews mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KScale(90) * column + (column-1) * 10);
    }];
}

#pragma mark - Lazy
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
    }
    return _backView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"常用应用";
        _titleLabel.textColor = MainTextColor;
        _titleLabel.font = KBOLDFONT(16);
    }
    return _titleLabel;
}

- (UIView *)itemViews {
    if (!_itemViews) {
        _itemViews = [[UIView alloc] init];
    }
    return _itemViews;
}

#pragma mark - Action
- (void)itemViewClick:(UIButton *)button {
    NSInteger index = button.tag;
    NSString *htmlTitle = [self.dataArray[index] objectForKey:@"name"];
    NSString *htmlUrl = [self.dataArray[index] objectForKey:@"url"];
    
    HHLog(@"name  %@", htmlTitle);
    
    //此URL的格式是应用B设置的URL Scheme
    if ([htmlTitle isEqualToString:@"数字会议"]) {
        NSString *UrlStr = @"com.shizheng.PeopleCongress://token=abc";  // token=@"abc"
        NSURL *url = [NSURL URLWithString:UrlStr];
        // 在这里可以先做个判断,如没有跳转APPStore去下载
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
            
        }else{
            [HHSystemAlter showWithAnimationType:AlterAnimationTypeScale title:@"温馨提示" subTitle:@"跳转的应用程序未安装" sureBlock:^{
                
            }];
        }
    }else{
        if ([HH_Utilities isBlankString:htmlUrl]) {
            [MBProgressHUD showMessage:@"暂未开放"];
            return;
        }
        if ([htmlUrl containsString:@"uuid"]) {
            htmlUrl = KString(@"%@&token=%@",htmlUrl, [UserModel getInfo].accessToken);
        }else{
            htmlUrl = KString(@"%@?token=%@",htmlUrl, [UserModel getInfo].accessToken);
        }
        HHLog(@"htmlUrl  %@", htmlUrl);
        
        HHWebViewController *webVC = [[HHWebViewController alloc] init];
        webVC.htmlTitle = htmlTitle;
        webVC.htmlUrl = htmlUrl;
        [[ControlTools navigationViewController] pushViewController:webVC animated:YES];
    }
    
}

@end


@interface HomeCellItemView ()

@property (nonatomic, strong) UILabel              *  textLabel;
@property (nonatomic, strong) UIImageView          *  iconImgView;

@end

@implementation HomeCellItemView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.iconImgView = [[UIImageView alloc] init];
    self.iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.iconImgView];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(KScale(50));
    }];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textColor = MainTextColor;
    self.textLabel.font = KFONT(13);
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.numberOfLines = 0;
    //    self.textLabel.backgroundColor = HHRandomColor;
    [self addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImgView.mas_bottom);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    self.iconImgView.image = [UIImage imageNamed:data[@"icon"]];
    self.textLabel.text = data[@"name"];
}


@end
