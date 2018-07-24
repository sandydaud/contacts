//
//  ContactDetailView.m
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ContactDetailView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ContactDetailView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.emailButton.layer.cornerRadius = self.messageButton.layer.cornerRadius = self.callButton.layer.cornerRadius = self.favoriteButton.layer.cornerRadius = self.emailButton.layer.frame.size.height / 2;
    self.collectionButtonView.layer.cornerRadius = 5.0f;
    self.imageBackground.layer.cornerRadius = self.imageBackground.layer.frame.size.height / 2;
    self.imageBackground.layer.borderColor = [[UIColor blackColor] CGColor];
    self.imageBackground.layer.borderWidth = 2.0f;
    self.snackbarView.hidden = YES;
}

@end
