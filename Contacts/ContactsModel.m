//
//  ContactsModel.m
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ContactsModel.h"
#import "ContactDetailModel.h"

@implementation ContactsModel

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.contactList = [[NSMutableArray alloc] init];
//        NSObject *receivedProduct = [dictionary objectForKey:@"data"];
        for (NSDictionary *item in (NSArray *)dictionary) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                ContactDetailModel *contactDetail = [[ContactDetailModel alloc] initWithContactDetailDictionary:item];
                [self.contactList addObject:contactDetail];
            }
        }
    }
    return self;
}

- (void)requestData:(NSString *)path completion:(void (^)(ContactsModel *))completion {
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    ContactsModel *contactModel = [[ContactsModel alloc] initWithDictionary:dict];
    if (completion) {
        completion(contactModel);
    }
}

@end
