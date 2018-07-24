//
//  ContactsModel.h
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContactDetailModel;
@interface ContactsModel : NSObject

@property (strong, nonatomic) NSMutableArray<ContactDetailModel *> *contactList;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)requestData:(NSString *)path completion:(void (^)(ContactsModel *))completion;

@end
