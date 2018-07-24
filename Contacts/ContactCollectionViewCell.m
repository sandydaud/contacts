//
//  ContactCollectionViewCell.m
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ContactCollectionViewCell.h"
#import "ContactDetailModel.h"

@implementation ContactCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contactImage.layer.cornerRadius = self.contactImage.frame.size.height / 2;
}

- (void)configureContactDetail:(ContactDetailModel *)contactDetail {
    self.contactNameLabel.text = contactDetail.firstName;
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:contactDetail.imageUrl]];
    self.contactImage.image = [UIImage imageWithData:imageData];
    
    self.favoriteIcon.hidden = contactDetail.isFavorite ? NO : YES;
}

@end
