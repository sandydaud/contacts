//
//  ContactDetailModel.h
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactDetailModel : NSObject

@property (strong, nonatomic) NSString *idContact;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *contactUrl;
@property (assign, nonatomic) BOOL isFavorite;
@property (strong, nonatomic) NSString *response;

- (instancetype)initWithContactDetailDictionary:(NSDictionary *)dictionary;
- (void)requestContactDetail:(NSString *)path completion:(void (^)(ContactDetailModel *))completion;
- (void)updateContactDetail:(NSString *)path contactDetail:(ContactDetailModel *)contactDetail completion:(void (^)(BOOL, NSString *))completion;
- (void)addContactDetail:(NSString *)path contactDetail:(ContactDetailModel *)contactDetail completion:(void (^)(BOOL, NSString *))completion;
@end
