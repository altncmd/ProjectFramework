//
//  SMHttpTool.h
//  ProjectFramework
//
//  Created by Elroy on 8/22/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMHttpTool : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param progress  进度
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  发送一个Post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param progress  进度
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;


/**
 发送一个POST请求，用于上传多媒体文件
 
 @param url 请求路径
 @param parames 请求参数
 @param progress 上传进度
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)postUploadMedia:(NSString *)url param:(NSDictionary *)parames progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;

///**
// 发送一个POST请求，用于更新用户头像
//
// @param url 请求路径
// @param parames 请求参数
// @param progress 上传进度
// @param success 请求成功后的回调
// @param failure 请求失败后的回调
// */
//+ (void)postUploadIcon:(NSString *)url param:(NSDictionary *)parames progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;


@end
