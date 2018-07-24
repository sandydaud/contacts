//
//  ContactDetailViewModel.h
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContactDetailModel;
@interface ContactDetailViewModel : NSObject

@property (strong, nonatomic) ContactDetailModel *contactDetail;
@property (copy, nonatomic) void (^didUpdate)(void);

- (instancetype)initWithContactDetail:(ContactDetailModel *)contactDetail;
- (void)updateContactDetail:(ContactDetailModel *)contactDetail;

@end
