//
//  CPWebVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPWebVC.h"

@interface CPWebVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIProgressView *progress;

@end

@implementation CPWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.hidesBottomBarWhenPushed = YES;
    [self.view addSubview:self.progress];
    
    if (self.shouldHomeItem == NO) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIProgressView *)progress {
    
    if (nil == _progress) {
        _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, 100)];
        _progress.trackTintColor = UIColor.clearColor;
    }
    
    return _progress;
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        
        _webView.delegate = self;
        
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)setUrlStr:(NSString *)urlStr {
    
    _urlStr = urlStr;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:CPUrl(urlStr)];
    
    [self.webView loadRequest:request];
}

- (void)setContentStr:(NSString *)contentStr {
    
    _contentStr = contentStr;
    
    [self.webView loadHTMLString:_contentStr baseURL:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.view bringSubviewToFront:self.progress];
    [self.progress setProgress:0.6 animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.progress setProgress:1 animated:YES];
    
    //获取网页title
    //
    //    NSString *htmlTitle = @"document.title";
    //    NSString *titleHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:htmlTitle];
    //    [self setTitle:titleHtmlInfo];

    [self performSelector:@selector(hideProgress) withObject:nil afterDelay:1.0f];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.progress setProgress:1 animated:YES];
    [self performSelector:@selector(hideProgress) withObject:nil afterDelay:1.0f];
}

- (void)hideProgress {
    [self.progress removeFromSuperview];
}

@end
