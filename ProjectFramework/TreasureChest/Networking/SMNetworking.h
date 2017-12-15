//
//  SMNetworking.h
//  ProjectFramework
//
//  Created by Elroy on 8/29/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMBaseTool.h"

@interface SMNetworking : SMBaseTool

#pragma mark - 判断网络状态
/**
 判断网络状态

 @return 网络状态提示
 */
+ (NSString *)getNetworkStatusTips;

#pragma mark - 注册登录
///**
// 注册
// 
// @param param 请求参数
// @param progress 请求进度（进度条可以在这个block中实现）
// @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
// @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
// */
//+ (void)registerWithParam:(SMRegisterParam *)param progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(SMRegisterResult *result))success failure:(void (^)(NSError *error))failure;
//
///**
// 登录
// */
//+ (void)loginWithParam:(SMLoginParam *)param progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(SMLoginResult *result))success failure:(void (^)(NSError *error))failure;


@end
