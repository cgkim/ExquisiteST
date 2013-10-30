//
//  VideoController.m
//  ExquisiteST
//
//  Created by kim on 13-10-29.
//
//

#import "VideoController.h"
#import "SVProgressHUD.h"

@interface VideoController () <UIWebViewDelegate>

@property (weak, nonatomic) UIWebView *webView;
@property (assign, nonatomic) BOOL played;

@end

@implementation VideoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

-(void)playStarted:(NSNotification *)notification{
    NSLog(@"start..");
}

-(void)playFinished:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark UIWebView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
    NSLog(@"url%@", [webView.request.URL absoluteString]);
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStarted:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished:) name:@"UIMoviePlayerControllerDidExitFullscreenNotification" object:nil];

    NSLog(@"request url: %@", self.urlString);
    if (!self.played) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
        self.played = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (void)unLoadViews {
    // TODO 具体的释放操作
    
}

@end
