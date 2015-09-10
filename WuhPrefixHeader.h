
/*
 *  常用宏定义
 *  Created by kiwuh on 15/7/11.
 */

#ifndef WuhPrefixHeader_h
#define WuhPrefixHeader_h

/** -----------------System---------------- */
#define iOS_Version [[UIDevice currentDevice] systemVersion] floatValue]  //当前系统版本 eg.8.3
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0]) //当前语言 eg:English


/** -----------------Device---------------- */
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)        //是否是iPad
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)    //是否是iPhone

/** -----------------Frame ---------------- */
#define Screen_size [UIScreen mainScreen].bounds.size
#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height
#define NavigationBar_height 44
#define ToolBar_height 44
#define Space 8 //标准间隔

/** -----------------Color----------------- */
#define Color_RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]           //RGB
#define Color_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]        //RGBA

#define Color_Hex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0f green:((float)((hexValue & 0xFF00) >> 8))/255.0f blue:((float)(hexValue & 0xFF))/255.0f alpha:1.0]          //16进制颜色码
#define Color_gray [UIColor grayColor]
#define Color_white [UIColor whiteColor]
#define Color_Black [UIColor blackColor]
#define Color_red [UIColor redColor]
#define Color_blue [UIColor blueColor]

/** -----------------Font------------------ */

#define Font_system_size(s) [UIFont systemFontOfSize:s]        //设置字体大小
#define Font_heiti_size(s) [UIFont fontWithName:@"STHeitiSC-Medium" size:s] //黑体

/** -----------------Image------------------ */
#define Image_Named(name) [UIImage imageNamed:name]         //通过名字来加载图片
#define Image_LocalFile(fileName,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:ext]]   //通过本地资源包中的文件和扩展名来加载图片
#define Image_filename(fileName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]]          //能过本地资源包中的文件名来加载图片

/** -----------------G C D------------------ */
#define GCD_subThread(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)  //开启线程调用block
#define GCD_mainThread(block) dispatch_async(dispatch_get_main_queue(),block)  //返回主线程调用block


/** -----------------Log ------------------- */
#ifdef DEBUG
    #define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    #define DLog(...)
#endif

#define WUHAssert(condition, ...)                                       \
    do {                                                                      \
        if (!(condition)) {                                                     \
            [[NSAssertionHandler currentHandler]                                  \
                handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
                                    file:[NSString stringWithUTF8String:__FILE__]  \
                                lineNumber:__LINE__                                  \
                                description:__VA_ARGS__];                             \
        }                                                                       \
    } while(0)

/** ---------------Path -------------------- */
#define Document_path NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  //沙箱中文档的path
#define Cache_path NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);       //沙箱中缓存的path

/** ---------------App Custom define ------- */  //根据app自定义
#define Color_Main Color_RGB(250,122,50)
#define Color_Main_Gary Color_RGB(222,222,222)



#endif
