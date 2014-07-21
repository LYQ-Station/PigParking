//
//  PPUser.m
//  PigParking
//
//  Created by Vincent on 7/21/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPUser.h"

static NSString *__CurrentUserIDCacheKey = @"CurrentUserIDCacheKey";
static NSString *__LocalUsersCacheKey = @"LocalUsersCacheKey";
static NSString *__currentUserID = nil;
static PPUser *__currentUser = nil;
static NSMutableDictionary *__users = nil;

@implementation PPUser

+ (id)currentUser
{
    [self loadFromCache];
    
    return __currentUser;
}

+ (void)loginUser:(NSDictionary *)userInfo
{
    __currentUser = [[PPUser alloc] initWithUserInfo:userInfo];
    __currentUserID = userInfo[@"uid"];
    
    [__users setObject:userInfo forKey:__currentUserID];
    
    [self saveToCache];
}

+ (void)loadFromCache
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSDictionary *td = (NSDictionary *)[df objectForKey:__LocalUsersCacheKey];
    
    __users = [[NSMutableDictionary alloc] initWithDictionary:td];
    
    if ([df objectForKey:__CurrentUserIDCacheKey])
    {
        __currentUser = [[PPUser alloc] initWithUserInfo:[df objectForKey:__CurrentUserIDCacheKey]];
        __currentUserID = __currentUser.uid;
    }
}

+ (void)saveToCache
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df setObject:__currentUserID forKey:__CurrentUserIDCacheKey];
    [df synchronize];
    
    [df setObject:__users forKey:__LocalUsersCacheKey];
    [df synchronize];
}

#pragma mark -

- (id)initWithUserInfo:(NSDictionary *)userInfo
{
    self = [super init];
    if (self)
    {
        _userInfo = userInfo;
    }
    return self;
}

- (NSString *)uid
{
    return _userInfo[@"uid"];
}

@end
