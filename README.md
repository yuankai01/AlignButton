# AlignButton
iOS开发中，`UIButton`是很常用的控件，经常会碰到图片和文字结合的情况，系统默认的是图片在左，文字在右，并且中间间距很小，并不能满足我们的需要，于是封装了一个`AlignButton`控件，只需要指定`alignType`和`padding`就能控制图片和文字的位置和间距，关键代码如下：
``` objective-c
// left、right、top、bottom指的是title的位置
typedef NS_ENUM(NSInteger,AlignType)
{
    AlignType_Right  = 1,   //title在右边
    AlignType_Left,         //title在左边
    AlignType_Top,          //title在上面
    AlignType_Bottom,       //title在下面
};

@interface AlignButton : UIButton

@property (nonatomic,assign) AlignType alignType;   //文字title所在位置
@property (assign, nonatomic) CGFloat padding;      //图片和文字间距

@end

.m文件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
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
    
    /* <#注释#>
     Note: that doesn’t actually flip the UIImage, but instead configures the image to be drawn flipped when it’s placed inside a UIImageView.
     注意：图片并没有翻转，当放置到imageView的时候image才会被翻转
     */
    if (isRTL()) {
        self.imageView.image = [self.imageView.image imageFlippedForRightToLeftLayoutDirection];
    }
}

void RTLMethodSwizzling (id obj,SEL oriMethod,SEL newMethod){
    Method ori = class_getInstanceMethod([obj class], oriMethod);
    Method new = class_getInstanceMethod([obj class], newMethod);
    method_exchangeImplementations(ori, new);
}

//RTL布局：hook方法setImageEdgeInsets:和setTitleEdgeInsets:
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
```
**安装：**

1、使用Cocoapods安装:
```
platform :ios
pod 'AlignButton'
```
2、手动安装：
直接拷贝AlignButton文件夹（包含AlignButton.h、AlignButton.m文件）到工程项目中.

**使用:** 引用头文件：#import "AlignButton.h"

```objective-c
#import "AlignButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet AlignButton *rightBtn;
@property (weak, nonatomic) IBOutlet AlignButton *leftBtn;
@property (weak, nonatomic) IBOutlet AlignButton *topBtn;
@property (weak, nonatomic) IBOutlet AlignButton *bottomBtn;
@property (weak, nonatomic) IBOutlet AlignButton *imageBtn;
@property (weak, nonatomic) IBOutlet AlignButton *titleBtn;

@end

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.rightBtn.alignType = AlignType_Right;
    self.rightBtn.padding = 10;
    
    self.leftBtn.alignType = AlignType_Left;
    self.leftBtn.padding = 10;
    
    self.topBtn.alignType = AlignType_Top;
    self.topBtn.padding = 10;
    
    self.bottomBtn.alignType = AlignType_Bottom;
    self.bottomBtn.padding = 10;
}
```
效果如图：

![image.png](https://upload-images.jianshu.io/upload_images/14783192-e81af3225f567d92.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)       
/
**RTL布局：**  做国际化语言适配时，可能会遇到`RTL（RightToLeft）`布局的情况，大部分国家语言读取都是从左向右`LTR（LeftToRight）`，但有些国家的语言读取是从右向左RTL读取的，如阿拉伯语。
解决思路：判断是否需要RTL布局，`hook UIButton`的方法`setImageEdgeInsets:`和`setTitleEdgeInsets:`来达到RTL重新布局的效果：

![image.png](https://upload-images.jianshu.io/upload_images/14783192-9cffcc134dfdec2d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
