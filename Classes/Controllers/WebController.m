//
//  WebController.m
//  ExquisiteST
//
//  Created by kim on 13-10-13.
//
//

#import "WebController.h"
#import "SVProgressHUD.h"

@interface WebController () <UIWebViewDelegate>

@property (weak, nonatomic) UIWebView *webView;

@end

@implementation WebController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"新闻详情";
    }
    return self;
}

- (void)loadView
{
    [super loadView];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView = webView;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark UIWebView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
    NSLog(@"url%@", [webView.request.URL absoluteString]);
    NSLog(@"url%@", [webView stringByEvaluatingJavaScriptFromString:@"window.location.href"]);
    [SVProgressHUD showWithStatus:NSLocalizedString(@"loading", nil)];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"end");
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error: %@", [error description]);
    [SVProgressHUD dismiss];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSString *requestString = [[request URL] absoluteString];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"request url: %@", self.urlString);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}

- (void)unLoadViews {
    // TODO 具体的释放操作

}

@end
