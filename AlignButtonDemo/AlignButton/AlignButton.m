//
//  AlignButton.m
//  CETCLeechdomExpert
//
//  Created by Gao on 2019/7/29.
//  Copyright © 2019 Aaron Yu. All rights reserved.
//

#import "AlignButton.h"
#import <objc/runtime.h>

@implementation AlignButton

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
    
//    if (isRTL()) {
//        UIImage *oriImg = self.imageView.image;
//        UIImage *image = [self hts_imageFlippedForRightToLeftLayoutDirection:oriImg];
//
//        UIImage *image3 = [image imageFlippedForRightToLeftLayoutDirection];
//
//        NSLog(@"33");
//    }
    
    CGRect titleRect= [self titleRectForContentRect:self.bounds];
    CGRect imgRect = [self imageRectForContentRect:self.bounds];
    
    switch (self.alignType) {
        case AlignType_Right: //字体居右，图片居左
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -self.padding, 0, 0)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, self.padding, 0, 0)];
            
            //针对RTL的情况，当然也可以判断isRTL，重新计算frame
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

/** RTL布局
 后面把这两个函数写成oc语法了。
 */
static UIEdgeInsets RTLEdgeInsetsWithInsets(UIEdgeInsets insets) {
    if (insets.left != insets.right && isRTL()) {
        CGFloat temp = insets.left;
        insets.left = insets.right;
        insets.right = temp;
    }
    return insets;
}

//获取当前系统语言，根据当前语言判断是否是RTL
static BOOL isRTL() {
    NSArray *languages = [NSLocale preferredLanguages];
    if (languages.count > 0) {

        NSString *language = [languages objectAtIndex:0];
        if([language containsString:@"ar"] || [language containsString:@"he"]){
            return YES;
        }else return NO;
        
    }else return NO;
}

void RTLMethodSwizzling (id obj,SEL oriMethod,SEL newMethod){
    Method ori = class_getInstanceMethod([obj class], oriMethod);
    Method new = class_getInstanceMethod([obj class], newMethod);
    method_exchangeImplementations(ori, new);
}

//hook
+ (void)load
{
    if (isRTL()) {
        [AlignButton swizzlingOriMethod:@selector(setContentEdgeInsets:) newMethod:@selector(rtl_setContentEdgeInsets:)];

        [AlignButton swizzlingOriMethod:@selector(setImageEdgeInsets:) newMethod:@selector(rtl_setImageEdgeInsets:)];

        [AlignButton swizzlingOriMethod:@selector(setTitleEdgeInsets:) newMethod:@selector(rtl_setTitleEdgeInsets:)];
    }
}

+ (void)swizzlingOriMethod:(SEL)ori newMethod:(SEL)new
{
    Method originalMethod = class_getInstanceMethod([self class], ori);
    Method newMethod = class_getInstanceMethod([self class], new);
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)rtl_setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    [self rtl_setContentEdgeInsets:RTLEdgeInsetsWithInsets(contentEdgeInsets)];
}

- (void)rtl_setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    [self rtl_setImageEdgeInsets:RTLEdgeInsetsWithInsets(imageEdgeInsets)];
}

- (void)rtl_setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    [self rtl_setTitleEdgeInsets:RTLEdgeInsetsWithInsets(titleEdgeInsets)];
}

//改写上面两个函数
- (UIEdgeInsets)RTLEdgeInsetsWithInsets:(UIEdgeInsets)insets
{
    if ([AlignButton isRTLLayout] && insets.left != insets.right) {
        CGFloat temp = insets.left;
        insets.left = insets.right;
        insets.right = temp;
    }
    
    return insets;
}

//根据当前语言是否包含ar判断是RTL(RightToLeft)还是LTR(LeftToRight)，判断是否需要从右到左布局
+ (BOOL)isRTLLayout{
    /*
     本地添加了RTL语言后，打印出的才是RightToLeft，否则是LeftToRight，所以还是要根据当前语言判断是否是RTL
     NSLog(@"RTL----==%ld",[[UIApplication sharedApplication] userInterfaceLayoutDirection]);
     */
    
    NSString *language = [[self class] getCurrentLanguage];
    if([language containsString:@"ar"] || [language containsString:@"he"]){
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
//        NSLog(@"languages --==%@",languages);
        NSString *currentLanguage = [languages objectAtIndex:0];
        return currentLanguage;
    }else return nil;
}

@end
