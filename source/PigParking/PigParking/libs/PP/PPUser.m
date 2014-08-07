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

+ (PPUser *)currentUser
{
    if (!__currentUser)
    {
        [self loadFromCache];
    }
    
    return __currentUser;
}

+ (PPUser *)loginUser:(NSDictionary *)userInfo
{
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [d setObject:@(YES) forKey:@"logined"];
    [d setObject:@(YES) forKey:@"is_save_search_history"];
    
    __currentUser = [[PPUser alloc] initWithUserInfo:d];
    __currentUserID = userInfo[@"uid"];
    
    [__users setObject:d forKey:__currentUserID];
    
    [self saveToCache];
    
    return __currentUser;
}

+ (void)loadFromCache
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSDictionary *td = (NSDictionary *)[df objectForKey:__LocalUsersCacheKey];
    
    __users = [[NSMutableDictionary alloc] initWithDictionary:td];
    __currentUserID = [df objectForKey:__CurrentUserIDCacheKey];
    
    if ([td objectForKey:__currentUserID])
    {
        __currentUser = [[PPUser alloc] initWithUserInfo:[NSMutableDictionary dictionaryWithDictionary:[__users objectForKey:__currentUserID]]];
    }
}

+ (void)saveToCache
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df setObject:__currentUserID forKey:__CurrentUserIDCacheKey];
    [df setObject:__users forKey:__LocalUsersCacheKey];
    [df synchronize];
}

#pragma mark -

- (id)initWithUserInfo:(NSMutableDictionary *)userInfo
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

- (BOOL)logined
{
    return [_userInfo[@"logined"] boolValue];
}

- (void)logout
{
    [_userInfo setObject:@(NO) forKey:@"logined"];
    
    __currentUser = nil;
    __currentUserID = @"";
    
    [PPUser saveToCache];
}

- (NSString *)description
{
    return [_userInfo description];
}

- (void)setIsSaveSearchHistory:(BOOL)isSaveSearchHistory
{
    [_userInfo setObject:@(isSaveSearchHistory) forKey:@"is_save_search_history"];
    
    [PPUser saveToCache];
}

- (BOOL)isSaveSearchHistory
{
    return [[_userInfo objectForKey:@"is_save_search_history"] boolValue];
}

@end
