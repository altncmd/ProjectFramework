//
//  SMToolBox.m
//  ProjectFramework
//
//  Created by Elroy on 8/22/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMToolBox.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation SMToolBox

+ (void)setViewBorderStyleWithView:(UIView *)view onSide:(BorderStyle)side borderWidth:(float)width borderColor:(UIColor *)color {
    if (side == 0) {
        /******** 给视图设置部分边框线 *************/
        CALayer *topBorder = [CALayer layer];
        float w = view.frame.size.width;
        topBorder.frame = CGRectMake(0, 0, w, width);
        topBorder.backgroundColor = color.CGColor;
        [view.layer addSublayer:topBorder];
        /**************************************/
    } else if (side == 1) {
        /******** 给视图设置部分边框线 *************/
        CALayer *leftBorder = [CALayer layer];
        float h = view.frame.size.height;
        leftBorder.frame = CGRectMake(0, 0, width, h);
        leftBorder.backgroundColor = color.CGColor;
        [view.layer addSublayer:leftBorder];
        /**************************************/
    } else if (side == 2) {
        /******** 给视图设置部分边框线 *************/
        CALayer *rightBorder = [CALayer layer];
        float h = view.frame.size.height;
        float w = view.frame.size.width - 0.5f;
        rightBorder.frame = CGRectMake(w, 0, width, h);
        rightBorder.backgroundColor = color.CGColor;
        [view.layer addSublayer:rightBorder];
        /**************************************/
    } else if (side == 3) {
        /******** 给视图设置部分边框线 *************/
        CALayer *bottomBorder = [CALayer layer];
        float h = view.frame.size.height - 0.5f;
        float w = view.frame.size.width;
        bottomBorder.frame = CGRectMake(0, h, w, width);
        bottomBorder.backgroundColor = color.CGColor;
        [view.layer addSublayer:bottomBorder];
        /**************************************/
    }
    
}

#pragma mark - NSString字符串

// 判断字符串为空
+ (BOOL)isEmptyOrNull:(NSString *)string
{
    if (string == nil)
    {
        return YES;
    }
    if (string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([string isEqualToString:@""])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
    {
        return YES;
    }
    return NO;
}

// 检查字符串是否是纯数字
+ (BOOL)checkStringIsOnlyDigital:(NSString *)str
{
    NSString *string = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length >0)
    {
        return NO;
    }else return YES;
}

//检查字符串是否为nil 转为@""
+ (NSString *)checkStringValue:(id)str
{
    if ([str isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return str;
}

//判断字符串中包含汉字
+ (BOOL)checkStringIsContainerChineseCharacter:(NSString *)string
{
    for (int i = 0; i < string.length; i++)
    {
        int a = [string characterAtIndex:i];
        if (a >= 0x4e00 && a <= 0x9fff) {
            return YES;
        }
    }
    return NO;
}

//过滤特殊字符串
+ (NSString *)filterSpecialString:(NSString *)string
{
    NSCharacterSet *dontWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+,.;':|/@!? "];
    //stringByTrimmingCharactersInSet只能去掉首尾的特殊字符串
    return [[[string componentsSeparatedByCharactersInSet:dontWant] componentsJoinedByString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

//判断是否含有非法字符 yes 有  no没有
+ (BOOL)judgeTheillegalCharacter:(NSString *)content {
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

#pragma mark - 字符串size

/**
 计算字符串尺寸
 
 @param string string
 @param font 字体
 @param size 大小
 @return 尺寸大小
 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    return [string boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil].size;
}

#pragma mark - UIColor

+ (UIColor *)colorFromHexCode:(NSString *)hexString
{
    if (!hexString) {
        return [UIColor clearColor];
    }
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//从图片转到颜色
+ (UIColor *)colorFromImage:(UIImage *)image
{
    if (image == nil)
    {
        return [UIColor clearColor];
    } else {
        return [UIColor colorWithPatternImage:image];
    }
}


#pragma mark - UIImage
//从颜色生成图片
+ (UIImage *)imageFromUIColor:(UIColor *)color {
    if (!color) {
        color = [UIColor clearColor];
    }
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 压缩图片
// 压缩图片按照大小
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size
{
    CGImageRef imgRef = image.CGImage;
    CGSize originSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // 原始大小
    if (CGSizeEqualToSize(originSize, size)) {
        return image;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);            //[UIScreen mainScreen].scale
    CGContextRef context = UIGraphicsGetCurrentContext();
    /**
     *  设置CGContext集插值质量
     *  kCGInterpolationHigh 插值质量高
     */
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// 压缩图片按照比例
+ (UIImage *)image:(UIImage *)image scaleWithRatio:(CGFloat)ratio
{
    CGImageRef imgRef = image.CGImage;
    if (ratio > 1 || ratio <= 0) {
        return image;
    }
    CGSize size = CGSizeMake(CGImageGetWidth(imgRef) * ratio, CGImageGetHeight(imgRef) * ratio); // 缩放后大小
    return [SMToolBox image:image scaleToSize:size];
}

#pragma mark - 添加水印
+ (UIImage *)image:(UIImage *)img addLogo:(UIImage *)logo
{
    if (logo == nil ) {
        return img;
    }
    if (img == nil) {
        return nil;
    }
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    int logoWidth = logo.size.width;
    int logoHeight = logo.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake(w-logoWidth-15, 10, logoWidth, logoHeight), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:imageMasked];
    CGContextRelease(context);
    CGImageRelease(imageMasked);
    CGColorSpaceRelease(colorSpace);
    return returnImage;
}

#pragma mark - NSUserDefault
// 取值
+ (id)UserDefaultGetObj:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}

// 存入
+ (BOOL)UserDefaultSetObject:(id)object ForKey:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:object forKey:key];
    return [ud synchronize];
}

// 移除
+ (void)UserDefaultRemoveObjForKey:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:key];
    [ud synchronize];
}

// 清空
+ (void)UserDefaultClean
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    [ud synchronize];
}

// 设置布尔
+ (BOOL)UserDefaultSetBool:(BOOL)b ForKey:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:b forKey:key];
    return [ud synchronize];
}

// 取bool值
+ (BOOL)UserDefaultGetBool:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:key];
}


#pragma mark - SandBox 沙盒相关

+ (NSString *)pathDocuments
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)pathCaches
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

/**
 Documents/name path
 
 @param name name
 @return name
 */
+ (NSString *)pathDocumentsWithFileName:(NSString *)name
{
    return [[SMToolBox pathDocuments] stringByAppendingString:name];
}

/**
 Caches/name path
 
 @param name name
 @return string
 */
+ (NSString *)pathCachesWithFileName:(NSString *)name
{
    return [[SMToolBox pathCaches] stringByAppendingString:name];
}

#pragma mark - 文件操作
/**
 计算缓存文件大小
 
 @return 大小
 */
+ (NSString *)calculateTheCacheSize {
    // TODO:这里的路径需要根据实际项目更改
    NSString *path = [[SMToolBox pathDocuments] stringByAppendingPathComponent:@"grassroot.sqlite"];
    // 总大小
    unsigned long long size = 0;
    NSString *sizeText = nil;
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件属性
    NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
    
    // 如果这个文件或者文件夹不存在,或者路径不正确直接返回0;
    if (attrs == nil)
        return @"0kB";//size;
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:path];
        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [path stringByAppendingPathComponent:subpath];
            // 累加文件大小
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
            
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
        }
        return sizeText;
    } else { // 如果是文件
        size = attrs.fileSize;
        if (size >= pow(10, 9)) { // size >= 1GB
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        } else { // 1KB > size
            sizeText = [NSString stringWithFormat:@"%zdB", size];
        }
        
    }
    return sizeText;
}

#pragma mark - 检查手机号码是否规范
/**
 *  检查是否为正确手机号码
 *
 *  @param phoneNumber 手机号
 *
 *  @return bool
 */
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber
{
    if (phoneNumber.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneNumber] == YES)
        || ([regextestcm evaluateWithObject:phoneNumber] == YES)
        || ([regextestct evaluateWithObject:phoneNumber] == YES)
        || ([regextestcu evaluateWithObject:phoneNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 检查邮箱地址格式
/**
 *  检查邮箱地址格式
 *
 *  @param EmailAddress 邮箱地址
 *
 *  @return bool
 */
+ (BOOL)checkEmailAddress:(NSString *)EmailAddress
{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    //先把NSString转换为小写
    NSString *lowerString       = EmailAddress.lowercaseString;
    
    return [regExPredicate evaluateWithObject:lowerString] ;
}

#pragma mark - 身份证相关
/**
 *  判断身份证是否合法
 *
 *  @param number 身份证号码
 *
 *  @return bool
 */
+ (BOOL)checkIdentityNumber:(NSString *)number
{
    {
        //必须满足以下规则
        //1. 长度必须是18位或者15位，前17位必须是数字，第十八位可以是数字或X
        //2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
        //3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
        //4. 第17位表示性别，双数表示女，单数表示男
        //5. 第18位为前17位的校验位
        //算法如下：
        //（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
        //（2）余数 ＝ 校验和 % 11
        //（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
        //6. 出生年份的前两位必须是19或20
        number = [number stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        number = [SMToolBox filterSpecialString:number];
        //1⃣️判断位数
        if (number.length != 15 && number.length != 18) {
            return NO;
        }
        //2⃣️将15位身份证转为18位
        NSMutableString *mString = [NSMutableString stringWithString:number];
        if (number.length == 15) {
            //出生日期加上年的开头
            [mString insertString:@"19" atIndex:6];
            //最后一位加上校验码
            [mString insertString:[SMToolBox getLastIdentifyNumberForIdentifyNumber:mString] atIndex:[mString length]];
            number = mString;
        }
        //3⃣️开始判断
        NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
        NSString *leapMmdd = @"0229";
        NSString *year = @"(19|20)[0-9]{2}";
        NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
        NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
        NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
        NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
        //区域
        NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
        NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
        NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        if (![regexTest evaluateWithObject:number]) {
            return NO;
        }
        //4⃣️验证校验码
        return [[SMToolBox getLastIdentifyNumberForIdentifyNumber:number] isEqualToString:[number substringWithRange:NSMakeRange(17, 1)]];
    }
}

/**
 *  从身份证里面获取性别man 或者 woman 不正确的身份证返回nil
 *
 *  @param number 身份证
 *
 *  @return string
 */
+ (NSString *)getGenderFromIdentityNumber:(NSString *)number
{
    if ([SMToolBox checkIdentityNumber:number]) {
        number = [SMToolBox filterSpecialString:number];
        NSInteger i = [[number substringWithRange:NSMakeRange(number.length - 2, 1)] integerValue];
        if (i % 2 == 1) {
            return @"man";
        } else {
            return @"woman";
        }
    } else {
        return nil;
    }
}

/**
 *  从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日
 *
 *  @param number 身份证
 *
 *  @return string
 */
+ (NSString *)getBirthdayFromIdentityNumber:(NSString *)number
{
    if ([SMToolBox checkIdentityNumber:number]) {
        number = [SMToolBox filterSpecialString:number];
        if (number.length == 18) {
            return [NSString stringWithFormat:@"%@年%@月%@日",[number substringWithRange:NSMakeRange(6,4)], [number substringWithRange:NSMakeRange(10,2)], [number substringWithRange:NSMakeRange(12,2)]];
        }
        if (number.length == 15) {
            return [NSString stringWithFormat:@"19%@年%@月%@日",[number substringWithRange:NSMakeRange(6,2)], [number substringWithRange:NSMakeRange(8,2)], [number substringWithRange:NSMakeRange(10,2)]];
        };
        return nil;
    } else {
        return nil;
    }
}

+ (NSString *)getLastIdentifyNumberForIdentifyNumber:(NSString *)number {
    //位数不小于17
    if (number.length < 17) {
        return nil;
    }
    //加权因子
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    //校验码
    unsigned char sChecker[11] = {'1','0','X','9','8','7','6','5','4','3','2'};
    long p =0;
    for (int i =0; i<=16; i++){
        NSString * s = [number substringWithRange:NSMakeRange(i, 1)];
        p += [s intValue]*R[i];
    }
    //校验位
    int o = p%11;
    NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
    return string_content;
}

#pragma mark - JSON和字典、数组
/**
 *  JSON字符串转字典或者数组
 *
 *  @param string JSON字符串
 *
 *  @return 返回字典或者数组
 */
+ (id)JSONTransformToDictionaryOrArray:(NSString *)string
{
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingMutableContainers) error:&error];
    if (error != nil) {
#ifdef DEBUG
        NSLog(@"fail to get dictioanry or array from JSON: %@, error: %@", string, error);
#endif
    }
    return object;
}

/**
 *  字典或者数组转为JSON字符串
 *
 *  @param object 字典或者数组
 *
 *  @return 返回字符串
 */
+ (NSString *)dictionaryOrArrayTransformToString:(id)object
{
    if (![object isKindOfClass:[NSArray class]] && ![object isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    NSError *error;
    //options为0 则不会有换行符和空格   NSJSONWritingPrettyPrinted有空格和换行符方便阅读
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:(0) error:&error];
    if (error != nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from object: %@, error: %@", object, error);
#endif
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

// 指定回调方法
+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
#ifdef DEBUG
    if(error != NULL)
    {
        msg = @"保存图片失败" ;
    } else {
        msg = @"保存图片成功" ;
    }
#endif
}

#pragma mark - 获取当前Controller
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (UIViewController *)findViewController:(UIView *)sourceView
{
    id target = sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}


#pragma mark - 数据转换（进制转换）

/**
 *  十进制转十六进制
 */
+ (NSString *)convertDecimalToHex:(uint16_t)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    uint16_t ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}


/**
 *  十六进制字符串转十进制
 *
 *  @param hexStr 待转换的十六进制字符串
 *
 *  @return 返回十进制
 */
+ (NSInteger)convertHexToDecimal:(NSString *)hexStr {
    return [[NSString stringWithFormat:@"%lu",strtoul([hexStr UTF8String],0,16)] intValue];
}

/**
 *  Hex to NSData
 */
+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    //    LEDEBUG(@"hexdata: %@", hexData);
    return hexData;
}

/**
 *  Hex to Byte array
 *
 *  @param hexString Hex string
 *
 *  @return 返回转换好的数据，为NSData类型，因为无法直接返回字节数组；使用时需要把NSData类型再转换成Byte
 */
+ (NSData *)convertHexToBytes:(NSString *)hexString {
    // 将16进制数据转化成Byte 数组 1AC2
    int x=0;
    int length = (int)hexString.length / 2;
    Byte bytes[length];  ///3ds key的Byte 数组， 128位
    for(int i=0;i<[hexString length];i++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); // 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; // A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; // a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        bytes[x] = int_ch;  ///将转化后的数放入Byte数组里
        x++;
    }
    NSData *data = [[NSData alloc] initWithBytes:bytes length:length];
    return data;
}


/**
 *  NSData to Hex
 */
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%X", (dataBytes[i]) & 0xFF];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

//Integer to NSData
+(NSData *) convertIntToNSData:(NSInteger)integer
{
    Byte *byteData = (Byte*)malloc(4);
    byteData[3] = integer & 0xff;
    byteData[2] = (integer & 0xff00) >> 8;
    byteData[1] = (integer & 0xff0000) >> 16;
    byteData[0] = (integer & 0xff000000) >> 24;
    NSData *result = [NSData dataWithBytes:byteData length:4];
//    SMLog(@"result=%@",result);
    return (NSData*)result;
}

//NSData to Integer
+(NSInteger) convertNSDataToInt:(NSData *)data
{
    unsigned char bytes[4];
    [data getBytes:bytes length:4];
    NSInteger n = (int)bytes[0] << 24;
    n |= (int)bytes[1] << 16;
    n |= (int)bytes[2] << 8;
    n |= (int)bytes[3];
    return n;
}

#pragma mark - 字符串MD5
+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

#pragma mark - 校验

// CRC 高位字节值表
const UInt8 chCRCHTalbe[] = {
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40
};

// CRC 低位字节值表
const UInt8 chCRCLTalbe[] = {
    0x00, 0xC0, 0xC1, 0x01, 0xC3, 0x03, 0x02, 0xC2, 0xC6, 0x06, 0x07, 0xC7,
    0x05, 0xC5, 0xC4, 0x04, 0xCC, 0x0C, 0x0D, 0xCD, 0x0F, 0xCF, 0xCE, 0x0E,
    0x0A, 0xCA, 0xCB, 0x0B, 0xC9, 0x09, 0x08, 0xC8, 0xD8, 0x18, 0x19, 0xD9,
    0x1B, 0xDB, 0xDA, 0x1A, 0x1E, 0xDE, 0xDF, 0x1F, 0xDD, 0x1D, 0x1C, 0xDC,
    0x14, 0xD4, 0xD5, 0x15, 0xD7, 0x17, 0x16, 0xD6, 0xD2, 0x12, 0x13, 0xD3,
    0x11, 0xD1, 0xD0, 0x10, 0xF0, 0x30, 0x31, 0xF1, 0x33, 0xF3, 0xF2, 0x32,
    0x36, 0xF6, 0xF7, 0x37, 0xF5, 0x35, 0x34, 0xF4, 0x3C, 0xFC, 0xFD, 0x3D,
    0xFF, 0x3F, 0x3E, 0xFE, 0xFA, 0x3A, 0x3B, 0xFB, 0x39, 0xF9, 0xF8, 0x38,
    0x28, 0xE8, 0xE9, 0x29, 0xEB, 0x2B, 0x2A, 0xEA, 0xEE, 0x2E, 0x2F, 0xEF,
    0x2D, 0xED, 0xEC, 0x2C, 0xE4, 0x24, 0x25, 0xE5, 0x27, 0xE7, 0xE6, 0x26,
    0x22, 0xE2, 0xE3, 0x23, 0xE1, 0x21, 0x20, 0xE0, 0xA0, 0x60, 0x61, 0xA1,
    0x63, 0xA3, 0xA2, 0x62, 0x66, 0xA6, 0xA7, 0x67, 0xA5, 0x65, 0x64, 0xA4,
    0x6C, 0xAC, 0xAD, 0x6D, 0xAF, 0x6F, 0x6E, 0xAE, 0xAA, 0x6A, 0x6B, 0xAB,
    0x69, 0xA9, 0xA8, 0x68, 0x78, 0xB8, 0xB9, 0x79, 0xBB, 0x7B, 0x7A, 0xBA,
    0xBE, 0x7E, 0x7F, 0xBF, 0x7D, 0xBD, 0xBC, 0x7C, 0xB4, 0x74, 0x75, 0xB5,
    0x77, 0xB7, 0xB6, 0x76, 0x72, 0xB2, 0xB3, 0x73, 0xB1, 0x71, 0x70, 0xB0,
    0x50, 0x90, 0x91, 0x51, 0x93, 0x53, 0x52, 0x92, 0x96, 0x56, 0x57, 0x97,
    0x55, 0x95, 0x94, 0x54, 0x9C, 0x5C, 0x5D, 0x9D, 0x5F, 0x9F, 0x9E, 0x5E,
    0x5A, 0x9A, 0x9B, 0x5B, 0x99, 0x59, 0x58, 0x98, 0x88, 0x48, 0x49, 0x89,
    0x4B, 0x8B, 0x8A, 0x4A, 0x4E, 0x8E, 0x8F, 0x4F, 0x8D, 0x4D, 0x4C, 0x8C,
    0x44, 0x84, 0x85, 0x45, 0x87, 0x47, 0x46, 0x86, 0x82, 0x42, 0x43, 0x83,
    0x41, 0x81, 0x80, 0x40
};

/**
 CRC 16 校验 ======> CRC16/MODBUS(X^16+X^15+X^2+1)
 
 @param pchMsg 需要校验的数据
 @param wDataLen 需要校验的数据长度
 @return 校验码
 */
UInt16 CRC16_1(UInt8 *pchMsg, UInt16 wDataLen)
{
    Byte chCRCHi = 0xFF; // 高CRC字节初始化
    Byte chCRCLo = 0xFF; // 低CRC字节初始化
    UInt16 wIndex;      // CRC循环中的索引
    while (wDataLen--)
    {
        // 计算CRC
        wIndex = chCRCLo ^ *pchMsg++ ;
        chCRCLo = chCRCHi ^ chCRCHTalbe[wIndex];
        chCRCHi = chCRCLTalbe[wIndex] ;
    }
    return ((chCRCHi << 8) | chCRCLo) ;
}

//#pragma mark - 屏幕截图的几种方式
//
///**
// *  屏幕截图有状态栏
// *
// *  @param type 图片保存位置
// *
// *  @return
// */
//+ (UIImage *)imageWithScreenshotWithCaptureType:(CaptureType)type
//{
//    CGSize imageSize = [UIScreen mainScreen].bounds.size;
//    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
//
//    for (UIWindow *window in [UIApplication sharedApplication].windows) {
//        if (window.screen == [UIScreen mainScreen]) {
//            [window drawViewHierarchyInRect:[UIScreen mainScreen].bounds afterScreenUpdates:NO];
//        }
//    }
//    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
//    [statusBar drawViewHierarchyInRect:statusBar.bounds afterScreenUpdates:NO];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    [self saveImage:image WithCaptureType:type];
//
//    return image;
//}
//
//
///**
// *  屏幕截图没有状态栏
// *
// *  @param type 图片保存位置
// *
// *  @return
// */
//+ (UIImage *)imageWithScreenshotNoStatusBarWithCaptureType:(CaptureType)type
//{
//    CGSize size = [UIScreen mainScreen].bounds.size;
//
//    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    for (UIWindow *window in [UIApplication sharedApplication].windows)
//    {
//        if (window.screen == [UIScreen mainScreen]) {
//            CGContextSaveGState(context);
//            CGContextTranslateCTM(context, window.center.x, window.center.y);
//            CGContextConcatCTM(context, window.transform);
//            CGContextTranslateCTM(context, -window.bounds.size.width *window.layer.anchorPoint.x, -window.bounds.size.height *window.layer.anchorPoint.y);
//            [window.layer renderInContext:context];
//            CGContextRestoreGState(context);
//        }
//
//    }
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    [self saveImage:image WithCaptureType:type];
//    return image;
//
//}
//
///**
// *  给一个view截图
// *
// *  @param type 图片保存位置
// *
// *  @return
// */
//+ (UIImage *)imageForView:( UIView * _Nonnull )view withCaptureType:(CaptureType)type
//{
//    CGSize size = view.bounds.size;
//
//    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [view.layer renderInContext:context];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    [self saveImage:image WithCaptureType:type];
//    return image;
//
//}

///**
// *  保存image到指定的位置
// *
// *  @param image image
// *  @param type  类型
// */
//+ (void)saveImage:(UIImage *)image WithCaptureType:(CaptureType)type
//{
//
//    NSData *data = UIImagePNGRepresentation(image);
//    /**
//     *  时间戳
//     */
//    NSString *time =[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
//    switch (type) {
//        case CaptureTypeSandbox:
//        {
//            [data writeToFile:pathCachesWithFileName([NSString stringWithFormat:@"%@_mainScrren_status.png",time]) atomically:YES];
//        }
//            break;
//        case CaptureTypePhotes:
//        {
//            [data writeToFile:pathCachesWithFileName([NSString stringWithFormat:@"%@_mainScrren_status.png",time]) atomically:YES];
//
//        }
//            break;
//        case CaptureTypeBoth:
//        {
//            [data writeToFile:pathCachesWithFileName([NSString stringWithFormat:@"%@_mainScrren_status.png",time]) atomically:YES];
//            [data writeToFile:pathCachesWithFileName([NSString stringWithFormat:@"%@_mainScrren_status.png",time]) atomically:YES];
//        }
//            break;
//        default:
//            break;
//    }
//}

@end
