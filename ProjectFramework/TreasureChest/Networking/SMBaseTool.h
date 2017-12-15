//
//  SMBaseTool.h
//  ProjectFramework
//
//  Created by Elroy on 8/22/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMBaseTool : NSObject

+ (void)getWithUrl:(NSString *)url param:(id)param progress:(void (^)(NSProgress *uploadProgress))progress resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)postWithUrl:(NSString *)url param:(id)param progress:(void (^)(NSProgress *uploadProgress))progress resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)postUploadMedia:(NSString *)url param:(id)param progress:(void (^)(NSProgress *uploadProgress))progress resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
