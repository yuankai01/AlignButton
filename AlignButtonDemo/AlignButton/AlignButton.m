//
//  AlignButton.m
//  CETCLeechdomExpert
//
//  Created by Gao on 2019/7/29.
//  Copyright © 2019 Aaron Yu. All rights reserved.
//

#import "AlignButton.h"

@implementation AlignButton

+ (void)load
{
    
}

//根据当前语言是否包含ar判断是RTL(RightToLeft)还是LTR(LeftToRight)是否要重右到左布局
+ (BOOL)isRTLLayout{
    NSString *language = [[self class] getCurrentLanguage];
    if([language isEqualToString:@"ar"] || [language isEqualToString:@"he"]){
        return YES;
    }else{
        return NO;
    }
}

//获取当前系统语言
+(NSString *)getCurrentLanguage
{
    //本地化所有语言
    NSArray *languages = [NSLocale preferredLanguages];
    if (languages.count > 0) {
        NSString *currentLanguage = [languages objectAtIndex:0];
        //        NSLog(@"currentLanguage --==%@",currentLanguage);
        return currentLanguage;
    }else return nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSet];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initSet];
}

- (void)initSet
{
    self.padding = 5;   //默认间距5
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = [super titleRectForContentRect:contentRect];
    
    if (AlignType_Bottom == self.alignType || AlignType_Top == self.alignType) {
        rect = CGRectMake(0, rect.origin.y, CGRectGetWidth(self.frame), rect.size.height);
    }
    
    return rect;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect titleRect= [self titleRectForContentRect:self.frame];
    CGRect imgRect = [self imageRectForContentRect:self.frame];
    
    switch (self.alignType) {
        case AlignType_Right: //字体居右，图片居左
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -self.padding, 0, 0)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, self.padding, 0, 0)];
        }
            break;
        case AlignType_Left:    //文字居左，图片居右边
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleRect.size.width + self.padding, 0, -titleRect.size.width)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgRect.size.width - self.padding, 0, imgRect.size.width)];
        }
            break;
        case AlignType_Top:    //文字居上，图片居下
        {
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            CGFloat height = imgRect.size.height + self.padding + titleRect.size.height;
            
            self.titleLabel.frame = CGRectMake(0, (CGRectGetHeight(self.frame) - height) / 2, CGRectGetWidth(self.frame), CGRectGetHeight(self.titleLabel.frame));
            
            self.imageView.frame = CGRectMake((CGRectGetWidth(self.frame) - imgRect.size.width) / 2, CGRectGetMaxY(self.titleLabel.frame) + self.padding, imgRect.size.width, imgRect.size.height);
        }
            break;
        case AlignType_Bottom:  //文字居下，图片居上
        {
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            CGFloat height = imgRect.size.height + self.padding + titleRect.size.height;
            
            self.imageView.frame = CGRectMake((CGRectGetWidth(self.frame) - imgRect.size.width) / 2, (CGRectGetHeight(self.frame) - height) / 2, imgRect.size.width, imgRect.size.height);
            
            self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + self.padding, CGRectGetWidth(self.frame), CGRectGetHeight(self.titleLabel.frame));
        }
            break;
        default:
            break;
    }
}

@end
