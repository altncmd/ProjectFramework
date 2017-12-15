//
//  SMDataBaseManager.h
//  ProjectFramework
//
//  Created by Elroy on 10/12/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMDataBaseManager : NSObject

/**
 Database action singleton pattern
 
 @return Singleton pattern
 */
+ (SMDataBaseManager *)sharedDataBase;

/**
 Clear database (cache)
 
 @return Result
 */
- (BOOL)clearCache;

///**
// Insert living data
// 
// @param model Living data
// @return Result
// */
////- (BOOL)insertAnchorListWithModel:(SMAnchorListModel *)model;
//
///**
// Get the living data
// 
// @return Data
// */
////- (SMAnchorListModel *)getAnchorList;
//
///**
// Saving the avatar image
// 
// @param image Avatar image
// @param anchor Using for identifier anchors, it can be an anchor's ID or a avatar URL(Because each anchor have an only and unique picture URL) or other can be unique identifier an anchor string;
// @return Saving result
// */
//- (BOOL)cacheAnchorAvatarImage:(UIImage *)image forAnchorID:(NSString *)anchor;
//
///**
// Get the avatar image
// 
// @param anchor Anchor identifier
// @return UIImage
// */
//- (UIImage *)getAnchorAvatarImageWithAnchor:(NSString *)anchor;
//
///**
// Saving anchor's living cover picture
// 
// @param image Cover picture
// @param anchor Using for identifier anchors, it can be an anchor's ID or a picture URL(Because every anchor have an only and unique picture URL) or other can be unique identifier an anchor string;
// @return Saving result
// */
//- (BOOL)cacheAnchorCoverPhotoImage:(UIImage *)image forAnchorID:(NSString *)anchor;
//
///**
// Get anchor's living cover picture
// 
// @param anchor Anchor identifier
// @return UIImage
// */
//- (UIImage *)getAnchorCoverPhotoImageWithAnchor:(NSString *)anchor;

@end
