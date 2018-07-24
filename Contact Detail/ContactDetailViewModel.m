//
//  ContactDetailViewModel.m
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ContactDetailViewModel.h"
#import "ContactDetailModel.h"

@implementation ContactDetailViewModel

- (instancetype)initWithContactDetail:(ContactDetailModel *)contactDetail {
    self = [self init];
    if (self) {
        self.contactDetail = contactDetail;
        [self needUpdate];
    }
    
    return self;
}

- (void)needUpdate {
    if (self.didUpdate) {
        self.didUpdate();
    }
}

- (void)updateContactDetail:(ContactDetailModel *)contactDetail {
    self.contactDetail = contactDetail;
    [self needUpdate];
}

@end
