//
//  ContactCollectionViewCell.h
//  Contacts
//
//  Created by Daud Sandy Christianto on 23/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactDetailModel;
@interface ContactCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contactImage;
@property (weak, nonatomic) IBOutlet UILabel *favoriteIcon;

- (void)configureContactDetail:(ContactDetailModel *)contactDetail;

@end
