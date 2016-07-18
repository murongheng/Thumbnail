//
//  ViewController.m
//  Thumbnail
//
//  Created by wg on 16/7/17.
//  Copyright © 2016年 wg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    
    NSArray *arr = @[@"5.jpg", @"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"1.jpg"];
    for (int i = 0; i < arr.count; ++i) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width  * i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageView.image = [UIImage imageNamed:arr[i]];
        [_scrollView addSubview:imageView];
    }
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * arr.count, 0);
    _scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    _scrollView.delegate = self;
    _scrollView.tag = 20;
    //遇到边界反弹关掉  ****🐲  🐲   🐲  🐲  ****
    _scrollView.bounces = NO;
    //缩略图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 150)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.tag = 10;
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(900, 150);
    scrollView.delegate = self;
    scrollView.decelerationRate = 0.01;
    scrollView.bounces = NO;
    //    scrollView.pagingEnabled = YES;
    
    for (int i = 1; i < arr.count - 1; ++i) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(125 * i, 25, 125, 100)];
        imageView.image = [UIImage imageNamed:arr[i]];
        [scrollView addSubview:imageView];
        imageView.alpha = 0.5;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
    }
    //
    UIImageView *iv = (id)[self.view viewWithTag:1];
    iv.alpha = 1;
    
    //添加一个UIPageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 600, self.view.frame.size.width, 60)];
    [self.view addSubview:_pageControl];
    //    _pageControl.backgroundColor = [UIColor redColor];
    _pageControl.numberOfPages = 5;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [_pageControl addTarget:self action:@selector(changeScrollView) forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view, typically from a nib.
}
//点击缩略图的图片，拖动到对应的大图
- (void)onClick:(UITapGestureRecognizer *)tap{
    // tap.view.tag  -- 添加该手势的view的标示  ****🐭 🐭tap.view.tag 🐭 🐭 **
    UIImageView *im1 = (id)[self.view viewWithTag:1];
    im1.alpha = 0.5;
    UIImageView *im2 = (id)[self.view viewWithTag:2];
    im2.alpha = 0.5;
    UIImageView *im3 = (id)[self.view viewWithTag:3];
    im3.alpha = 0.5;
    UIImageView *im4 = (id)[self.view viewWithTag:4];
    im4.alpha = 0.5;
    UIImageView *im5 = (id)[self.view viewWithTag:5];
    im5.alpha = 0.5;
    switch (tap.view.tag) {
        case 1: {
            _scrollView.contentOffset = CGPointMake(self.view.frame.size.width * 1, 0);
            im1.alpha = 1;
            _pageControl.currentPage = _scrollView.contentOffset.x / self.view.frame.size.width - 1;
        }
            break;
        case 2: {
            _scrollView.contentOffset = CGPointMake(self.view.frame.size.width * 2, 0);
            im2.alpha = 1;
            _pageControl.currentPage = _scrollView.contentOffset.x / self.view.frame.size.width - 1;
        }
            break;
        case 3: {
            _scrollView.contentOffset = CGPointMake(self.view.frame.size.width * 3, 0);
            im3.alpha = 1;
            _pageControl.currentPage = _scrollView.contentOffset.x / self.view.frame.size.width - 1;
        }
            break;
        case 4: {
            _scrollView.contentOffset = CGPointMake(self.view.frame.size.width * 4, 0);
            im4.alpha = 1;
            _pageControl.currentPage = _scrollView.contentOffset.x / self.view.frame.size.width - 1;
        }
            break;
        case 5: {
            _scrollView.contentOffset = CGPointMake(self.view.frame.size.width * 5, 0);
            im5.alpha = 1;
            _pageControl.currentPage = _scrollView.contentOffset.x / self.view.frame.size.width - 1;
        }
            break;
        default:
            break;
    }
    NSLog(@"hehe ");
}
//当滑动结束的时候执行该方法 *** 🐯  🐯   【常被重写】   🐯  🐯  ****
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //从尾与首相连 当滑到第7页(与第一页的图片相同)的时候，将contentOffset 换成 第一页的offset  ***  🐭 🐭 🐭  ****
    if (_scrollView.contentOffset.x == self.view.frame.size.width * 6) {
        _scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    }
    //从首与尾相连 当滑到第一页(与第五页的图片相同)的时候，将contentOffset 换成第五页的offset  *** 🐂 🐂  🐂  ****
    if (_scrollView.contentOffset.x == 0) {
        _scrollView.contentOffset = CGPointMake(self.view.frame.size.width * 5, 0);
    }
    
    //当_scrollView 拖动时，scrollView1 按比例拖动 获得scrollView1的offset
    /**
     缩略图宽度为125
     _scrollView 拖动一次增加375
     拖动要与图片的宽度挂钩
     缩略图拖动控制大图的时候，要让缩略图达到一定的偏移量(关于该偏移量的计算)后，大图偏移量为大图宽度的整数倍(防止显示的是两张图片)
     */
    //  为scrollView设置不同的标示，可以在代理里面让两个scrollView彼此控制  **  🐰 🐰 🐰  🐰  ****
    if (scrollView.tag == 10) {
        //CGPoint 为浮点类型，取整的时候需要强转
        _scrollView.contentOffset = CGPointMake(((int)scrollView.contentOffset.x / 125 + 1) * self.view.frame.size.width , 0);
        [self changeAlphaAccordingToScrolliView:scrollView];
        _pageControl.currentPage = _scrollView.contentOffset.x / self.view.frame.size.width - 1;
    } else {
        UIScrollView *scrollView1 = (id)[self.view viewWithTag:10];
        scrollView1.contentOffset = CGPointMake(scrollView.contentOffset.x  / 3 - 125 , 0);
        [self changeAlphaAccordingToScrolliView:scrollView1];
        //与_pageControl 关联     *********
        _pageControl.currentPage = _scrollView.contentOffset.x /self.view.frame.size.width - 1;
        //    _pageControl.currentPage = scrollView1.contentOffset.x / 125;
    }
    NSLog(@"%f", _scrollView.contentOffset.x);
}

//当切换到某个视图的时候，与之对应的缩略图透明度改变（变亮）
- (void)changeAlphaAccordingToScrolliView:(UIScrollView *)Sv {
    UIImageView *im1 = (id)[self.view viewWithTag:1];
    im1.alpha = 0.5;
    UIImageView *im2 = (id)[self.view viewWithTag:2];
    im2.alpha = 0.5;
    UIImageView *im3 = (id)[self.view viewWithTag:3];
    im3.alpha = 0.5;
    UIImageView *im4 = (id)[self.view viewWithTag:4];
    im4.alpha = 0.5;
    UIImageView *im5 = (id)[self.view viewWithTag:5];
    im5.alpha = 0.5;
    int t = Sv.contentOffset.x / 125 + 1;
    switch (t) {
        case 1: {
            
            im1.alpha = 1;
        }
            break;
        case 2: {
            
            im2.alpha = 1;
        }
            break;
        case 3: {
            
            im3.alpha = 1;
        }
            break;
        case 4: {
            
            im4.alpha = 1;
        }
            break;
        case 5: {
            
            im5.alpha = 1;
        }
            break;
        default:
            break;
    }
}
// 通过小白点控制两个ScrollView的拖动
- (void)changeScrollView {
    _scrollView.contentOffset = CGPointMake((_pageControl.currentPage + 1 )* self.view.frame.size.width, 0);
    UIScrollView *sv = (id)[self.view viewWithTag:10];
    sv.contentOffset = CGPointMake(_pageControl.currentPage * 125, 0);
    [self changeAlphaAccordingToScrolliView:sv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
