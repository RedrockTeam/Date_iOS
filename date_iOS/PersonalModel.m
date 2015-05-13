//
//  PersonalModel.m
//  date_iOS
//
//  Created by BooleanMac on 15/5/8.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import "PersonalModel.h"


@implementation PersonalModel

/**
 *  抓取用户信息
 *
 *  @param uid             执行当前操作的用户id
 *  @param getId           需要获取用户信息的用户id
 *  @param successCallback 成功后的回调函数
 *  @param failureCallback 失败后的回调函数
 */
-(void)fetchUserInfoFromUid:(NSNumber *)uid toUid:(NSNumber *)getId withSuccess:(void (^)(id data))successCallback andFailure:(void (^)(id error))failureCallback{

    NSString *url = @"http://106.184.7.12:8002/index.php/api/person/userinfo";
    NSDictionary *parameter = @{@"uid" : uid, @"get_id" : getId};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:parameter constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successCallback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureCallback(error);
    }];
    
}

/**
 *  修改个人资料
 *
 *  @param info            个人资料
 *  @param successCallback 成功后的回调函数
 *  @param failureCallback 失败后的回调函数
 */
-(void)editUserInfo:(NSDictionary *)info withSuccess:(void (^)(id data))successCallback andFailure:(void (^)(id error))failureCallback{
    NSString *url = @"http://106.184.7.12:8002/index.php/api/person/editpersonalinfo";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:info constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successCallback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureCallback(error);
    }];
}

//todo:取个人收藏列表 url: http://106.184.7.12:8002/index.php/api/person/collection
//todo:取个人参加记录 url: http://106.184.7.12:8002/index.php/api/person/join
//todo:取个人发起记录 url: http://106.184.7.12:8002/index.php/api/person/create
@end
