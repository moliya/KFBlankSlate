//
//  WebViewController.m
//  KFBlankSlateExample
//
//  Created by Carefree on 2018/8/18.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

static NSString *const  WebViewObservingKeyPathTitle = @"title";
static NSString *const  WebViewObservingKeyPathLoading = @"loading";
static NSString *const  WebViewObservingKeyPathProgress = @"estimatedProgress";

@interface WebViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView        *progressView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加KVO监听
    [self.webView addObserver:self forKeyPath:WebViewObservingKeyPathTitle options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:WebViewObservingKeyPathLoading options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:WebViewObservingKeyPathProgress options:NSKeyValueObservingOptionNew context:NULL];

    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];

    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)dealloc {
    //移除监听
    [self.webView removeObserver:self forKeyPath:WebViewObservingKeyPathTitle];
    [self.webView removeObserver:self forKeyPath:WebViewObservingKeyPathLoading];
    [self.webView removeObserver:self forKeyPath:WebViewObservingKeyPathProgress];
}

#pragma mark - Lazyloading
- (WKWebView *)webView {
    if (_webView) {
        return _webView;
    }
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];

    return _webView;
}

- (UIProgressView *)progressView {
    if (_progressView) {
        return _progressView;
    }
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.bounds.size.width, 2);
    _progressView.tintColor = [UIColor greenColor];
    _progressView.trackTintColor = [UIColor whiteColor];
    
    return _progressView;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:WebViewObservingKeyPathTitle]) {
        //标题更新
        self.title = self.webView.title;
    } else if ([keyPath isEqualToString:WebViewObservingKeyPathProgress]) {
        //进度条更新
        self.progressView.alpha = 1;
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress >= 1) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0 animated:NO];
            }];
        }
    } else if ([keyPath isEqualToString:WebViewObservingKeyPathLoading]) {
        //TODO
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
