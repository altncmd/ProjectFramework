//
//  SMDataBaseManager.m
//  ProjectFramework
//
//  Created by Elroy on 10/12/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMDataBaseManager.h"

@interface SMDataBaseManager ()

@property (nonatomic, strong) FMDatabaseQueue *SMDBQueue;
@property (nonatomic, strong) FMDatabase *SMDB;

@end


@implementation SMDataBaseManager

+ (SMDataBaseManager *)sharedDataBase {
    static SMDataBaseManager *dataBaseManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBaseManager = [[SMDataBaseManager alloc] init];
    });
    return dataBaseManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _SMDB = [FMDatabase databaseWithPath:[self getDataBasePath]];
        // 如果数据库打开失败返回空
        if (![_SMDB open]) {
            return nil;
        }
        
        NSString *sql_anchorList = @"CREATE TABLE IF NOT EXISTS Anchor_List (id INTEGER PRIMARY KEY AUTOINCREMENT, nickname TEXT, photo TEXT, avatar TEXT, sex INTEGER, lianMaiStatus TEXT, flv TEXT, avatarImage BLOB, coverPhoto BLOB)";
        
        BOOL isSuccess = [_SMDB executeUpdate:sql_anchorList];
        if (isSuccess) {
            NSLog(@"\nCreate table success!\nDatabase Path:%@", [self getDataBasePath]);
        }
        [_SMDB close];
    }
    return self;
}

- (NSString *)getDataBasePath {
    NSString *path = [GeneralTools pathDocuments];
    return [path stringByAppendingPathComponent:@"database.sqlite"];
}


/**
 清空数据库(清空缓存)

 @return 清空结果
 */
- (BOOL)clearCache {
    BOOL isSuccess = NO;
    [_SMDB open];
    NSString *sqlStr = @"DELETE FROM Anchor_List";
    isSuccess = [_SMDB executeUpdate:sqlStr];
    [_SMDB close];
    return isSuccess;
}

///**
// Insert living data
// 
// @param model Living data
// @return Result
// */
//- (BOOL)insertAnchorListWithModel:(SMAnchorListModel *)model {
//    BOOL isSuccess = NO;
//    [_SMDB open];
//    
//    // 查询数据库是否有数据(有就更新，没有就插入)
//    NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM Anchor_List WHERE flv = '%@'", model.flv];
//    FMResultSet *resultSet = [_SMDB executeQuery:sqlStr];
////    NSMutableArray *arr = [NSMutableArray array];
////    while (resultSet.next) {
////        [arr addObject:[resultSet stringForColumn:@"photo"]];
////    }
//    
//    // if the database don't have living data then insert data, if it has then update
//    if (!resultSet.next) {
//        sqlStr = [NSString stringWithFormat:@"INSERT INTO Anchor_List (nickname, photo, avatar, sex, lianMaiStatus, flv) values ('%@','%@','%@','%ld','%@','%@')", model.nickname, model.photo, model.avatar, model.sex, model.lianMaiStatus, model.flv];
//        isSuccess = [_SMDB executeUpdate:sqlStr];
//    } else {
//        NSString *sqlStr = [NSString stringWithFormat:@"UPDATE Anchor_List SET nickname = '%@', photo = '%@', avatar = '%@', sex = '%ld', lianMaiStatus = '%@', flv = '%@' WHERE flv = '%@'", model.nickname, model.photo, model.avatar, model.sex, model.lianMaiStatus, model.flv, model.flv];
//        isSuccess = [_SMDB executeUpdate:sqlStr];
//    }
//    [_SMDB close];
//    
//    return isSuccess;
//}
//
///**
// Get the living data
//
// @return Datas array
// */
//- (NSMutableArray *)getAnchorList {
//    [_SMDB open];
//    NSString *sqlStr = @"SELECT * FROM Anchor_List";
//    FMResultSet *resultSet = [_SMDB executeQuery:sqlStr];
//    NSMutableArray *models = [NSMutableArray array];
//    while (resultSet.next) {
//        SMAnchorListModel *model = [[SMAnchorListModel alloc] init];
//        model.nickname = [resultSet stringForColumn:@"nickname"];
//        model.photo = [resultSet stringForColumn:@"photo"];
//        model.avatar = [resultSet stringForColumn:@"avatar"];
//        model.sex = [resultSet stringForColumn:@"sex"].integerValue;
//        model.lianMaiStatus = [resultSet stringForColumn:@"lianMaiStatus"];
//        model.flv = [resultSet stringForColumn:@"flv"];
//        [models addObject:model];
//    }
//    [_SMDB close];
//    return models;
//}
//
/////**
//// 插入银行卡信息到数据库
//// 
//// @param model 银行卡信息模型
//// @return 插入是否成功
//// */
////- (BOOL)insertBankCardInforWithModel:(SMBankInfoModel *)model {
////    BOOL isSuccess = NO;
////    [_SMDB open];
////    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE Anchor_Information SET address = '%@', bankaccount = '%@', bankano = '%@', banktype = '%@', bankname = '%@'", model.address, model.bankaccount, model.bankano, model.banktype, model.bankname];
////    isSuccess = [_SMDB executeUpdate:sqlStr];
////    [_SMDB close];
////    
////    return isSuccess;
////}
////
/////**
//// 获取银行卡信息
//// 
//// @return 返回银行卡信息
//// */
////- (SMBankInfoModel *)getBankCardInfor {
////    SMBankInfoModel *model = [[SMBankInfoModel alloc] init];
////    [_SMDB open];
////    NSString *sqlStr = @"SELECT * FROM Anchor_Information";
////    FMResultSet *resultSet = [_SMDB executeQuery:sqlStr];
////    if (resultSet.next) {
////        model.address = [resultSet stringForColumn:@"address"];
////        model.bankaccount = [resultSet stringForColumn:@"bankaccount"];
////        model.bankano = [resultSet stringForColumn:@"bankano"];
////        model.banktype = [resultSet stringForColumn:@"banktype"];
////        model.bankname = [resultSet stringForColumn:@"bankname"];
////    }
////    [_SMDB close];
////    return model;
////}
////
/////**
//// 从数据库删除银行卡信息
//// 
//// @return 是否删除成功
//// */
////- (BOOL)deleteBankCardInfor {
////    BOOL isSuccess = NO;
////    [_SMDB open];
////    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE Anchor_Information SET address = NULL, bankaccount = NULL, bankano = NULL, banktype = NULL, bankname = NULL"];
////    isSuccess = [_SMDB executeUpdate:sqlStr];
////    [_SMDB close];
////    
////    return isSuccess;
////}
//
///**
// Saving the avatar image
//
// @param image Avatar image
// @param anchor Using for identifier anchors, it can be an anchor's ID or a avatar URL(Because each anchor have an only and unique picture URL) or other can be unique identifier an anchor string;
// @return Saving result
// */
//- (BOOL)cacheAnchorAvatarImage:(UIImage *)image forAnchorID:(NSString *)anchor {
//    BOOL isSuccess = NO;
//    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//    [_SMDB open];
//    // 注意这里语句不能写成(这是错误的写法，能存进错误的数据，但读出来有问题):
//    // NSString *sqlStr = [NSString stringWithFormat:@"UPDATE Anchor_Information SET avatarImage = %@", imageData];
//    isSuccess = [_SMDB executeUpdate:@"UPDATE Anchor_List SET avatarImage = ? WHERE flv = ?", imageData, anchor];
//    [_SMDB close];
//    return isSuccess;
//}
//
///**
// Get the avatar image
// 
// @param anchor Anchor identifier
// @return UIImage
// */
//- (UIImage *)getAnchorAvatarImageWithAnchor:(NSString *)anchor {
//    NSData *imageData = nil;
//    UIImage *image = nil;
//    [_SMDB open];
//    NSString *sqlStr = [NSString stringWithFormat:@"SELECT avatarImage FROM Anchor_List WHERE flv = '%@'", anchor];
//    FMResultSet *resultSet = [_SMDB executeQuery:sqlStr];
//    while (resultSet.next) {
//        imageData = [resultSet dataForColumn:@"avatarImage"];
//        image = [UIImage imageWithData:imageData];
//    }
//    [_SMDB close];
//    return image;
//}
//
///**
// 
// 
// @return
// */
//
///**
// Saving anchor's living cover picture
//
// @param image Cover picture
// @param anchor Using for identifier anchors, it can be an anchor's ID or a picture URL(Because each anchor have an only and unique picture URL) or other can be unique identifier an anchor string;
// @return Saving result
// */
//- (BOOL)cacheAnchorCoverPhotoImage:(UIImage *)image forAnchorID:(NSString *)anchor {
//    BOOL isSuccess = NO;
//    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//    [_SMDB open];
//    // 注意这里语句不能写成(这是错误的写法，能存进错误的数据，但读出来有问题):
//    // NSString *sqlStr = [NSString stringWithFormat:@"UPDATE Anchor_Information SET avatarImage = %@", imageData];
//    isSuccess = [_SMDB executeUpdate:@"UPDATE Anchor_List SET coverPhoto = ? WHERE flv = ?", imageData, anchor];
//    [_SMDB close];
//    return isSuccess;
//}
//
///**
// Get anchor's living cover picture
//
// @param anchor Anchor identifier
// @return UIImage
// */
//- (UIImage *)getAnchorCoverPhotoImageWithAnchor:(NSString *)anchor {
//    NSData *imageData = nil;
//    UIImage *image = nil;
//    [_SMDB open];
//    NSString *sqlStr = [NSString stringWithFormat:@"SELECT coverPhoto FROM Anchor_List WHERE flv = '%@'", anchor];
//    FMResultSet *resultSet = [_SMDB executeQuery:sqlStr];
//    while (resultSet.next) {
//        imageData = [resultSet dataForColumn:@"coverPhoto"];
//        image = [UIImage imageWithData:imageData];
//    }
//    [_SMDB close];
//    return image;
//}

@end
