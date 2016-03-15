//
//  LSCommentCell.m
//  cnbetaReader
//
//  Created by 嘟嘟洒水车 on 16/3/12.
//  Copyright © 2016年 嘟嘟洒水车. All rights reserved.
//

#import "LSCommentCell.h"

@interface LSCommentCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblhost;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;

@end

@implementation LSCommentCell

- (void)setComment:(LSComment *)comment{
    _comment = comment;
    self.lblName.text = comment.name;
    self.lblhost.text = comment.host_name;
    self.lblDate.text = comment.date;
    self.lblComment.text = comment.comment;
    self.imgHead.image = [UIImage imageNamed:@"placeholder"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
