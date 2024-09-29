//
//  SearchView.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/14.
//

#import "SearchView.h"

@interface SearchView () <UITextFieldDelegate>

@property (nonatomic, strong) UIView        * backView;
@property (nonatomic, strong) UIView        * leftBackView;
@property (nonatomic, strong) UIView        * iconView;

@end

@implementation SearchView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 35;
//        self.leftView = [UIView new];
        self.edgeInsets = UIEdgeInsetsMake(8, 12, 8, 12);
        [self initUI];
    }
    return self;
}

- (void)initUI {
        
    UIView *backView = [[UIView alloc] init];
    backView.layer.cornerRadius = 20;
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    self.backView = backView;
    
    UIView *leftBackView = [[UIView alloc] init];
    [backView addSubview:leftBackView];
    self.leftBackView = leftBackView;
    
    [leftBackView addSubview:self.leftView];
    
    UITextField *contentTF = [[UITextField alloc] init];
    contentTF.placeholder = @"请输入关键字";
    contentTF.font = KFONT(14);
    contentTF.textColor = DarkSubTextColor;
    contentTF.delegate = self;
    contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backView addSubview:contentTF];
    self.textField = contentTF;
    
    UIButton *clearButton = [contentTF valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"search_delete_s"] forState:UIControlStateNormal];
    
//    UIImageView *rightView = [[UIImageView alloc]init];
//    rightView.image = [UIImage imageNamed:@"search_delete_s"];
//    rightView.size = CGSizeMake(60, 40);
//    rightView.contentMode = UIViewContentModeCenter;
//    contentTF.rightView = rightView;
//    contentTF.rightViewMode = UITextFieldViewModeWhileEditing;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.edgeInsets);
    }];
    
    [self.leftBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(10);
        if (self.leftView) {
            make.width.mas_equalTo(20);
        }else{
            make.width.mas_equalTo(0);
        }
        make.height.mas_equalTo(20);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.left.equalTo(self.leftBackView.mas_right).offset(5);
//        make.height.mas_equalTo(self.height);
    }];

}

- (void)setHeight:(CGFloat)height {
    _height = height;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

-(void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    
    [self.leftBackView removeAllSubviews];
    [self.leftBackView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    self.backgroundColor = backColor;
}

- (void)setTextBackColor:(UIColor *)textBackColor {
    _textBackColor = textBackColor;
    self.backView.backgroundColor = textBackColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self.backView addCornerRadius:cornerRadius];
}


#pragma UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
    }
    
    HHLog(@"text  %@",text);
    if (self.searchBlock) {
        self.searchBlock(text);
    }
    return  YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.beginBlock) {
        self.beginBlock();
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.returnBlock) {
        self.returnBlock();
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if (self.searchBlock) {
        self.searchBlock(nil);
    }
    if (self.clearBlock) {
        self.clearBlock();
    }
    return YES;
}



@end


