//
//  NewFeatureViewController.m
//  Weibo
//
//  Created by lanouhn on 15/6/17.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "ViewController.h"



#define NewFeatureViewControllerImageCount 3



@interface NewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置scrollView
    [self setupScrollView];
    //2.设置pageControl
    [self setupPageControl];
   
}
/**
 *  设置scrollView
 */
- (void)setupScrollView
{
    //0.设置背景
    self.view.backgroundColor = [UIColor whiteColor];
    //1.添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.frame;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    //2.添加图片
    for (int i = 0; i < NewFeatureViewControllerImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        NSString *name = [NSString stringWithFormat:@"%d.jpg", i];
        
        imageView.image = [UIImage imageNamed:name];
        
        imageView.frame = CGRectMake(i * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:imageView];
        
        //在最后一个图片上添加按钮
        if (i == NewFeatureViewControllerImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    //设置滚动范围
    scrollView.contentSize = CGSizeMake(NewFeatureViewControllerImageCount * self.view.frame.size.width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
}
/**
 *  设置pageControl
 */
- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    pageControl.numberOfPages = NewFeatureViewControllerImageCount;
    
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253 green:98 blue:42 alpha:1.0];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:189 green:189 blue:189 alpha:1.0];
    
    pageControl.userInteractionEnabled = NO;
   
    
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

/**
 *  只要scrollView滚动 就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1.取出水平方向的滚动距离
    CGFloat offSetX = scrollView.contentOffset.x;
    //2.求出页码
     //方法一
    self.pageControl.currentPage = (offSetX + scrollView.frame.size.width * 0.5) / scrollView.frame.size.width;

}


/**
 *  设置开始按钮，进入主控制器
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    //打开imageView的用户交互
    imageView.userInteractionEnabled = YES;
    //设置开始按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    //设置frame
    CGFloat centerX = imageView.frame.size.width * 0.8;
    CGFloat centerY = imageView.frame.size.height * 0.9;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    //设置文字
    [startButton setTitle:@"进入" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    
    
    
}
/**
 *  实现开始按钮 向主控制器跳转
 */
- (void)start
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"root"];
    self.view.window.rootViewController = vc;
   


}
@end
