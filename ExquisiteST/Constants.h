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

#define BASE_URL @"112.91.128.50"

#define JZST_URL(__C1__) [NSString stringWithFormat:@"%@", __C1__]

#define GET_NEWS_LIST JZST_URL(@"getNewsListV2.aspx")
#define GET_NEWS_CONTENT JZST_URL(@"getNewsContent.aspx")

#define VIDEO_URL(__C1__) [NSString stringWithFormat:@"http://%@/vd/%@", BASE_URL, __C1__]

#define IMAGE_URL(__C1__) [NSString stringWithFormat:@"http://%@/image/%@", BASE_URL, __C1__]

#define WEBVIEW_URL(__C1__) [NSString stringWithFormat:@"http://%@/getNewsContent.aspx?nid=%@", BASE_URL, __C1__]

#define ZBST_SP_URL @"http://u.3gtv.net/yuetv/Living_Channel_Info?online_id=37"

#define TIMEOUT 15
#define PAGECOUNT 10
#define CACHEPOLICY NSURLRequestReturnCacheDataElseLoad
#define DELAYINSECONDS 1.0


#define DATEFORMAT @"yyyy-MM-dd"
#define DATETIMEFORMAT @"yyyy-MM-dd HH:mm:ss"



#define BARBUTTON_COLOR [UIColor colorWithRed:71/255.0 green:117/255.0 blue:155/255.0 alpha:1]
#define BORDER_COLOR [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]




