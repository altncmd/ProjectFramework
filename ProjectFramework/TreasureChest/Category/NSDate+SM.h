//
//  NSDate+SM.h
//  ProjectFramework
//
//  Created by Elroy on 18/04/2017.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SM)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
@end
