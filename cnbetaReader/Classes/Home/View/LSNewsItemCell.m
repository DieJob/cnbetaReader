//
//  LSNewsItemCell.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/1/17.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import "LSNewsItemCell.h"
#import "NSString+Tools.h"
#import "UIImageView+WebCache.h"

@interface LSNewsItemCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgThumb;
@property (weak, nonatomic) IBOutlet UILabel *lblHomeText;
@property (weak, nonatomic) IBOutlet UILabel *lblComments;
@property (weak, nonatomic) IBOutlet UILabel *lblCounter;

@end

@implementation LSNewsItemCell

-(void)setNewsItem:(LSNewsItem *)newsItem{
    _newsItem = newsItem;
    self.lblTitle.text = newsItem.title;
    self.lblTime.text = newsItem.pubtime;
    self.lblCounter.text = newsItem.counter;
    self.lblComments.text = newsItem.comments;
    self.lblHomeText.text = newsItem.summary;
    [self.imgThumb sd_setImageWithURL:[NSURL URLWithString:newsItem.thumb] placeholderImage: [UIImage imageNamed:@"placeholder"]];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
