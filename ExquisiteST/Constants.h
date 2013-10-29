//
//  Constants.h
//  ExquisiteST
//
//  Created by kim on 13-10-11.
//
//

#define IS_WIDESCREEN ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

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
#define ZBST_VIDEO_URL @"http://58.248.254.7:9135/live/ds-stzh.sdp/playlist.m3u8?portalId=5&contentType=4&pid=37&uid=no_number&nettype=uninet&sec=947badcd171bdac4121c72d8527cec69&uc=yuetv_wap"

#define TIMEOUT 15
#define PAGECOUNT 10
#define CACHEPOLICY NSURLRequestReturnCacheDataElseLoad
#define DELAYINSECONDS 1.0


#define DATEFORMAT @"yyyy-MM-dd"
#define DATETIMEFORMAT @"yyyy-MM-dd HH:mm:ss"

