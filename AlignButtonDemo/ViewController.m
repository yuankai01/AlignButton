//
//  ViewController.m
//  AlignButtonDemo
//
//  Created by Gao on 2019/7/29.
//  Copyright © 2019 Gao. All rights reserved.
//

#import "ViewController.h"
#import "AlignButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet AlignButton *rightBtn;
@property (weak, nonatomic) IBOutlet AlignButton *leftBtn;
@property (weak, nonatomic) IBOutlet AlignButton *topBtn;
@property (weak, nonatomic) IBOutlet AlignButton *bottomBtn;
@property (weak, nonatomic) IBOutlet AlignButton *imageBtn;
@property (weak, nonatomic) IBOutlet AlignButton *titleBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [UIView appearance].semanticContentAttribute = UIUserInterfaceLayoutDirectionLeftToRight;
//    [UISearchBar appearance].semanticContentAttribute = UIUserInterfaceLayoutDirectionLeftToRight;
//    self.navigationController.navigationBar.semanticContentAttribute = [UIView appearance].semanticContentAttribute;
    
    /** 注意：
     本地添加了RTL语言后，打印出的才是RightToLeft，否则是LeftToRight
     添加对应的语言后，切换系统语言才会打印出来的才是RTL（1）或LTR（0），否则打印的是上次对应的记录。
     */
    NSLog(@"---==%ld---%ld--==%ld",[UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.view.semanticContentAttribute],[[UIApplication sharedApplication] userInterfaceLayoutDirection],self.view.effectiveUserInterfaceLayoutDirection);
    
    /* <#注释#>
     //Note: that doesn’t actually flip the UIImage, but instead configures the image to be drawn flipped when it’s placed inside a UIImageView.
     注意：图片并没有翻转，当放置到imageView的时候image才会被翻转
     */
    UIImage *oriImg = [UIImage imageNamed:@"a2"];
    UIImage *image = [UIImage imageWithCGImage:oriImg.CGImage
                                         scale:oriImg.scale
                                   orientation:UIImageOrientationUpMirrored];
    
    UIImage *image2 = [oriImg imageFlippedForRightToLeftLayoutDirection];
    
    UIImage *image3 = [oriImg imageWithHorizontallyFlippedOrientation];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 500, 120, 40)];
    imgView.image = image;
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(180, 500, 120, 40)];
    imgView2.image = image2;
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(180, 560, 120, 40)];
    imgView3.image = image3;
    
//    [self.view addSubview:imgView];
//    [self.view addSubview:imgView2];
//    [self.view addSubview:imgView3];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.rightBtn.alignType = AlignType_Right;
    self.rightBtn.padding = 10;
    
    self.rightBtn.imageView.backgroundColor =  [UIColor cyanColor];
    self.rightBtn.titleLabel.backgroundColor =  [UIColor redColor];

    self.leftBtn.imageView.backgroundColor =  [UIColor cyanColor];
    self.leftBtn.titleLabel.backgroundColor =  [UIColor redColor];
    
    self.leftBtn.alignType = AlignType_Left;
    self.leftBtn.padding = 10;
    
    self.topBtn.alignType = AlignType_Top;
    self.topBtn.padding = 10;
    
    self.bottomBtn.alignType = AlignType_Bottom;
    self.bottomBtn.padding = 10;
}

@end
