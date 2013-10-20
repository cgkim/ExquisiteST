//
//  WebController.m
//  ExquisiteST
//
//  Created by kim on 13-10-13.
//
//

#import "WebController.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"


@interface WebController () <UIWebViewDelegate>

@property (weak, nonatomic) UIWebView *webView;
@property (strong, nonatomic) MKNetworkOperation *netOperation;

@end

@implementation WebController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
    }
    return self;
}

- (void)loadView
{
    [super loadView];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView = webView;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
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
    [SVProgressHUD showWithStatus:NSLocalizedString(@"loading", nil) maskType:SVProgressHUDMaskTypeBlack];
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
    // 这里不好。web端需要调整。
    if (self.UrIId) {
        self.netOperation = [NTAppDelegate.engine getNewsContentWithNid:self.UrIId OnSucceeded:^(NSString *content) {
            [self.webView loadHTMLString:content baseURL:nil];
        } onError:^(NSError *engineError) {
            NSLog(@"error: %@", [engineError description]);
        }];
    } else if (![[self.webView.request.URL absoluteString] isEqualToString:self.urlString]) {
        NSLog(@"request url: %@", self.urlString);
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    }
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (self.netOperation) {
        [self.netOperation cancel];
        self.netOperation = nil;
    }
}

- (void)unLoadViews {
    // TODO 具体的释放操作
    self.webView = nil;
}

@end
