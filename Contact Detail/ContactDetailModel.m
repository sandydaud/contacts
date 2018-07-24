//
//  ContactDetailModel.m
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ContactDetailModel.h"

@implementation ContactDetailModel

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (instancetype)initWithContactDetailDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.idContact = [self objectOrNilForKey:@"id" fromDictionary:dictionary];
        self.firstName = [self objectOrNilForKey:@"first_name" fromDictionary:dictionary];
        self.lastName = [self objectOrNilForKey:@"last_name" fromDictionary:dictionary];
        self.phoneNumber = [self objectOrNilForKey:@"phone_number" fromDictionary:dictionary];
        self.email = [self objectOrNilForKey:@"email" fromDictionary:dictionary];
        self.imageUrl = [NSString stringWithFormat:@"https://gojek-contacts-app.herokuapp.com%@" , [self objectOrNilForKey:@"profile_pic" fromDictionary:dictionary]];
        self.isFavorite = [[self objectOrNilForKey:@"favorite" fromDictionary:dictionary] boolValue];
    }
    return self;
}

- (void)requestContactDetail:(NSString *)path completion:(void (^)(ContactDetailModel *))completion {
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    ContactDetailModel *contactModel = [[ContactDetailModel alloc] initWithContactDetailDictionary:dict];
    if (completion) {
        completion(contactModel);
    }
}

- (void)updateContactDetail:(NSString *)path contactDetail:(ContactDetailModel *)contactDetail completion:(void (^)(BOOL, NSString *))completion {
    NSMutableDictionary *requestParameter = [[NSMutableDictionary alloc] init];
    [requestParameter setValue:contactDetail.idContact forKey:@"id"];
    [requestParameter setValue:contactDetail.firstName forKey:@"first_name"];
    [requestParameter setValue:contactDetail.lastName forKey:@"last_name"];
    [requestParameter setValue:contactDetail.phoneNumber forKey:@"phone_number"];
    [requestParameter setValue:contactDetail.email forKey:@"email"];
    [requestParameter setValue:contactDetail.imageUrl forKey:@"profile_pic"];
    [requestParameter setValue:contactDetail.contactUrl forKey:@"url"];
    [requestParameter setValue:@(contactDetail.isFavorite) forKey:@"favorite"];
    
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:requestParameter options:kNilOptions error:nil];

    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"PUT";
    
    [request setURL:[NSURL URLWithString:path]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonBodyData];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                              options:kNilOptions
                                                                                                                error:nil];
                                                NSDictionary *errorMessage = [forJSONObject objectForKey:@"errors"];
                                                NSMutableArray<NSString *> *errorReponse = [[NSMutableArray alloc] init];
                                                for (NSString *error in errorMessage) {
                                                    [errorReponse addObject:error];
                                                }
                                                self.response = !errorMessage ? @"Add contact success!" : [errorReponse componentsJoinedByString:@", "];
                                                if (completion) {
                                                    completion(errorMessage, self.response);
                                                }
                                            }];
    [task resume];
}

- (void)addContactDetail:(NSString *)path contactDetail:(ContactDetailModel *)contactDetail completion:(void (^)(BOOL, NSString *))completion {
    NSMutableDictionary *requestParameter = [[NSMutableDictionary alloc] init];
    [requestParameter setValue:contactDetail.firstName forKey:@"first_name"];
    [requestParameter setValue:contactDetail.lastName forKey:@"last_name"];
    [requestParameter setValue:contactDetail.phoneNumber forKey:@"phone_number"];
    [requestParameter setValue:contactDetail.email forKey:@"email"];
    [requestParameter setValue:@(contactDetail.isFavorite) forKey:@"favorite"];
    
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:requestParameter options:kNilOptions error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    
    [request setURL:[NSURL URLWithString:path]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonBodyData];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                              options:kNilOptions
                                                                                                                error:nil];
                                                NSDictionary *errorMessage = [forJSONObject objectForKey:@"errors"];
                                                NSMutableArray<NSString *> *errorReponse = [[NSMutableArray alloc] init];
                                                for (NSString *error in errorMessage) {
                                                    [errorReponse addObject:error];
                                                }
                                                self.response = !errorMessage ? @"Add contact success!" : [errorReponse componentsJoinedByString:@", "];
                                                if (completion) {
                                                    completion(errorMessage, self.response);
                                                }
                                            }];
    [task resume];
    
}

@end
