//
//  HHGradientView.m
//  RenMinWenLv
//
//  Created by Mac on 2021/9/7.
//

#import "HHGradientView.h"

@implementation HHGradientView

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}


@end
