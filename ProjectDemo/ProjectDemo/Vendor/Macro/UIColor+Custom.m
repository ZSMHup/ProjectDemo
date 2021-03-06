//
//  UIColor+Custom.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)

+ (UIColor *)mainColor {
    return kRGBColor(33, 150, 243);
}

+ (UIColor *)backgroundColor {
    
    return kRGBColor(246, 246, 246);
}

+ (UIColor *)whiteColor:(CGFloat)alpha {
    return [UIColor colorWithHexString:@"#FFFFFF" alpha:alpha];
}

+ (UIColor *)blackColor:(CGFloat)alpha {
    return [UIColor colorWithHexString:@"#000000" alpha:alpha];
}


@end
