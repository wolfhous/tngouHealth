//
//  HEMedListCell.m
//  Health
//
//  Created by wolfhous on 16/1/13.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import "HEMedListCell.h"
#import "UIImageView+WebCache.h"
@interface HEMedListCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end
@implementation HEMedListCell


-(void)setList:(HEMedList *)list
{
    _list = list;
    /***/
    
    //    self.leftImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.list.imageURL]]];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.list.imageURL] placeholderImage:[UIImage imageNamed:@"icon_refresh"]];
    //    NSLog(@"%@",self.list.imageURL);
    self.nameLabel.text = self.list.name;
    self.descLabel.text = self.list.desc;

}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
