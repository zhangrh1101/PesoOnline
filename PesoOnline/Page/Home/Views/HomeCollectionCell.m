//
//  HomeCollectionCell.m
//  WisePeople
//
//  Created by mac mini on 2022/8/17.
//

#import "HomeCollectionCell.h"

@interface HomeCollectionCell()

@property (nonatomic, strong) UILabel              *  textLabel;
@property (nonatomic, strong) UIImageView          *  iconImgView;

@end

/*首页Cell*/
@implementation HomeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.iconImgView = [[UIImageView alloc] init];
    self.iconImgView.image = [UIImage imageNamed:@"mine_Invitation"];
    [self.contentView addSubview:self.iconImgView];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(55);
    }];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textColor = MainTextColor;
    self.textLabel.font = KFONT(13);
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.text = @"都是瓜皮";
    [self.contentView addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.iconImgView.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)setIcon:(NSString *)icon {
    _icon = icon;
    self.iconImgView.image = [UIImage imageNamed:icon];
}

- (void)setName:(NSString *)name {
    _name = name;
    self.textLabel.text = name;
}


@end
