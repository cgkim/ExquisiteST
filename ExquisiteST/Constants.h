//
//  Constants.h
//  ExquisiteST
//
//  Created by kim on 13-10-11.
//
//

#define IS_WIDESCREEN (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568 ) < DBL_EPSILON)

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

#define BASE_URL @"183.234.98.82"

#define JZST_URL(__C1__) [NSString stringWithFormat:@"jzst/%@", __C1__]
#define GET_NEWS_LIST JZST_URL(@"getNewsList.aspx")
#define GET_NEWS_CONTENT JZST_URL(@"getNewsContent.aspx")

#define VIDEO_URL @"http://183.234.98.82/files/happyst.mp4"

#define WEBVIEW_URL(__C1__) [NSString stringWithFormat:@"http://%@/jzst/getNewsContent.aspx?nid=%@", BASE_URL, __C1__]

#define TIMEOUT 15
#define PAGECOUNT 10
#define CACHEPOLICY NSURLRequestReturnCacheDataElseLoad
#define DELAYINSECONDS 1.0


#define DATEFORMAT @"yyyy-MM-dd"
#define DATETIMEFORMAT @"yyyy-MM-dd HH:mm:ss"



#define BARBUTTON_COLOR [UIColor colorWithRed:71/255.0 green:117/255.0 blue:155/255.0 alpha:1]
#define BORDER_COLOR [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]




