//
//  UIButton+HSButton.m
//  tngouHealth
//
//  Created by hou on 16/4/21.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "UIButton+HSButton.h"

@implementation UIButton (HSButton)
- (void)setRoundLayerWithCornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
@end
