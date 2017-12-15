//
//  GeneralTools.h
//  ProjectFramework
//
//  Created by Elroy on 8/22/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

#define IS_IPHONE4 (([[UIScreen mainScreen] bounds].size.height == 480) ? YES : NO)
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO)
#define IS_IPHONE6 (([[UIScreen mainScreen] bounds].size.height == 667) ? YES : NO)
#define IS_IPHONE6PLUS (([[UIScreen mainScreen] bounds].size.height == 736) ? YES : NO)
#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height == 812) ? YES : NO)

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kNavigationBarHeight self.navigationController.navigationBar.frame.size.height
#define kTabBarHeight self.tabBarController.tabBar.frame.size.height

#define kScreenCenterX [[UIScreen mainScreen] bounds].size.width / 2.f
#define kScreenCenterY [[UIScreen mainScreen] bounds].size.height / 2.f

// RGB color
#define RGBColor(R, G, B, Alpha) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(Alpha)]
// Hex color
#define HexColor(hex) [GeneralTools colorFromHexCode:hex]
// Random color
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f];

#define kFontSize(size) [UIFont systemFontOfSize:size]
#define kImage(name) [UIImage imageNamed:name]

// Equal Ratio Adapt
#define kEqualRatioAdapt(x) [[UIScreen mainScreen] bounds].size.width == 320 ? (x) * 0.85157421 : [[UIScreen mainScreen] bounds].size.width == 375 ? (x) : (x) * 1.10344828
#define kEqualRatioValue [[UIScreen mainScreen] bounds].size.width == 320 ? 0.85157421 : [[UIScreen mainScreen] bounds].size.width == 375 ? 1 : 1.10344828



typedef NS_ENUM(NSInteger, BorderStyle) {
    borderTop = 0,      // top
    borderLeft,         // left
    borderRight,        // right
    borderBottom        // bottom
};

@interface GeneralTools : NSObject

#pragma mark - UILabel、UITextField单边框设置
/**
 设置视图的单边框，主要是UILabel、UITextField
 
 @param view 需要设置单边框的视图
 @param width 边框线宽
 @param side 哪条边框
 @param color 边框颜色
 */
+ (void)setViewBorderStyleWithView:(UIView *)view onSide:(BorderStyle)side borderWidth:(float)width borderColor:(UIColor *)color;


#pragma mark - NSString字符串

/**
 判断字符串为空
 
 @param string 需要判断的字符串
 @return 结果
 */
+ (BOOL)isEmptyOrNull:(NSString *)string;

/**
 检查字符串是否是纯数字
 
 @param str 需要判断的字符串
 @return 结果
 */
+ (BOOL)checkStringIsOnlyDigital:(NSString *)str;

/**
 检查字符串是否为nil 转为@""
 
 @param str 需要检查的字符串
 @return 转化为@“”
 */
+ (NSString *)checkStringValue:(id)str;

/**
 判断字符串中包含汉字
 
 @param string 需要判断的字符串
 @return 结果
 */
+ (BOOL)checkStringIsContainerChineseCharacter:(NSString *)string;

/**
 过滤特殊字符串
 
 @param string 需要过滤的字符串
 @return 过滤后的字符串
 */
+ (NSString *)filterSpecialString:(NSString *)string;


/**
 判断字符串中是否含有特殊字符（除数字、字母、下划线以外的所有字符）

 @param content 需要判断的字符串
 @return 判断结果
 */
+ (BOOL)judgeTheillegalCharacter:(NSString *)content;

#pragma mark - 字符串size

/**
 计算字符串尺寸
 
 @param string string
 @param font 字体
 @param size 大小
 @return 尺寸大小
 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size;


#pragma mark - UIColor
/**
 十六进制颜色转UIColor
 
 @param hexString 十六进制颜色
 @return 转换结果
 */
+ (UIColor *)colorFromHexCode:(NSString *)hexString;

/**
 从图片转到颜色
 
 @param image 图片
 @return 颜色
 */
+ (UIColor *)colorFromImage:(UIImage *)image;


#pragma mark - UIImage
/**
 从颜色生成图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageFromUIColor:(UIColor *)color;


#pragma mark - 压缩图片
/**
 压缩图片按照大小
 
 @param image 图片
 @param size 大小
 @return 压缩后的图片
 */
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size;

/**
 压缩图片按照比例
 
 @param image 图片
 @param ratio 压缩比例
 @return 压缩后的图片
 */
+ (UIImage *)image:(UIImage *)image scaleWithRatio:(CGFloat)ratio;


#pragma mark - 添加水印
/**
 图片添加水印
 
 @param img 图片
 @param logo 水印
 @return 添加水印后的图片
 */
+ (UIImage *)image:(UIImage *)img addLogo:(UIImage *)logo;


#pragma mark - NSUserDefault
/**
 NSUserDefault 取值
 
 @param key key
 @return 值
 */
+ (id)UserDefaultGetObj:(NSString *)key;

/**
 NSUserDefault 存入
 
 @param object object
 @param key key
 */
+ (BOOL)UserDefaultSetObject:(id)object ForKey:(NSString *)key;

/**
 移除
 
 @param key key
 */
+ (void)UserDefaultRemoveObjForKey:(NSString *)key;

/**
 清空NSUserDefault
 */
+ (void)UserDefaultClean;

/**
 NSUserDefault 存布尔值
 
 @param b 布尔
 @param key key
 @return 存储结果
 */
+ (BOOL)UserDefaultSetBool:(BOOL)b ForKey:(NSString *)key;


/**
 NSUserDefault 取布尔值

 @param key 键
 @return 值
 */
+ (BOOL)UserDefaultGetBool:(NSString *)key;

#pragma mark - SandBox 沙盒相关

/**
 获取沙盒路径
 
 @return 沙盒路径
 */
+ (NSString *)pathDocuments;

/**
 获取缓存路径
 
 @return 缓存路径
 */
+ (NSString *)pathCaches;

/**
 Documents/name path
 
 @param name name
 @return name
 */
+ (NSString *)pathDocumentsWithFileName:(NSString *)name;

/**
 Caches/name path
 
 @param name name
 @return string
 */
+ (NSString *)pathCachesWithFileName:(NSString *)name;

#pragma mark - 文件操作
/**
 计算缓存文件大小
 
 @return 大小
 */
+ (NSString *)calculateTheCacheSize;

#pragma mark - 检查手机号码是否规范
/**
 *  检查是否为正确手机号码
 *
 *  @param phoneNumber 手机号
 *
 *  @return bool
 */
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber;


#pragma mark - 检查邮箱地址格式
/**
 *  检查邮箱地址格式
 *
 *  @param EmailAddress 邮箱地址
 *
 *  @return bool
 */
+ (BOOL)checkEmailAddress:(NSString *)EmailAddress;


#pragma mark - 身份证相关
/**
 *  判断身份证是否合法
 *
 *  @param number 身份证号码
 *
 *  @return bool
 */
+ (BOOL)checkIdentityNumber:(NSString *)number;

/**
 *  从身份证里面获取性别man 或者 woman 不正确的身份证返回nil
 *
 *  @param number 身份证
 *
 *  @return string
 */
+ (NSString *)getGenderFromIdentityNumber:(NSString *)number;

/**
 *  从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日
 *
 *  @param number 身份证
 *
 *  @return string
 */
+ (NSString *)getBirthdayFromIdentityNumber:(NSString *)number;


#pragma mark - JSON和字典、数组
/**
 *  JSON字符串转字典或者数组
 *
 *  @param string JSON字符串
 *
 *  @return 返回字典或者数组
 */
+ (id)JSONTransformToDictionaryOrArray:(NSString *)string;

/**
 *  字典或者数组转为JSON字符串
 *
 *  @param object 字典或者数组
 *
 *  @return 返回字符串
 */
+ (NSString *)dictionaryOrArrayTransformToString:(id)object;

// 指定回调方法
+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;


#pragma mark - 获取当前Controller
/**
 获取当前屏幕显示的viewcontroller
 
 @return VC
 */
+ (UIViewController *)getCurrentVC;

/**
 获取某个视图所在的UIViewController
 
 @param sourceView 视图
 @return UIViewController
 */
+ (UIViewController *)findViewController:(UIView *)sourceView;


#pragma mark - 数据转换（进制转换）
/**
 *  十进制转十六进制
 *
 *  @param tmpid 传入的十进制
 *
 *  @return 返回十六进制字符串
 */
+ (NSString *)convertDecimalToHex:(uint16_t)tmpid;

/**
 *  十六进制字符串转十进制
 *
 *  @param hexStr 待转换的十六进制字符串
 *
 *  @return 返回十进制
 */
+ (NSInteger)convertHexToDecimal:(NSString *)hexStr;

/**
 *  十六进制转NSData
 */
+ (NSData *)convertHexStrToData:(NSString *)str;

/**
 *  NSData转十六进制
 */
+ (NSString *)convertDataToHexStr:(NSData *)data;

/**
 *  16进制数－>Byte数组
 *
 *  @param hexString 传入的十六进制字符串
 *
 *  @return 返回转换好的数据，为NSData类型，因为无法直接返回字节数组；使用时需要把NSData类型再转换成Byte
 */
+ (NSData *)convertHexToBytes:(NSString *)hexString;

/**
 * Integer to NSData
 */
+(NSData *) convertIntToNSData:(NSInteger)integer;

/**
 * NSData to Integer
 */
+(NSInteger) convertNSDataToInt:(NSData *)data;

#pragma mark - 字符串MD5
+ (NSString *)md5:(NSString *)string;

#pragma mark - 校验
/**
 CRC 16 校验 ======> CRC16/MODBUS(X^16+X^15+X^2+1)
 
 @param pchMsg 需要校验的数据
 @param wDataLen 需要校验的数据长度
 @return 校验码
 */
UInt16 CRC16_1(UInt8 *pchMsg, UInt16 wDataLen);



@end
