//
//  DetailTableViewCell.m
//  hatena
//
//  Created by Hideki Mutoh on 2014/09/28.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    float padding = 20;
    float cellWidth = [[UIScreen mainScreen] bounds].size.width;
    float cellHeight = 100;

    if (self) {
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];

     _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, cellWidth - padding*3, 40)];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _titleLabel.font =  [UIFont boldSystemFontOfSize:12];
        _titleLabel.numberOfLines = 2;

        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, cellWidth -padding*3, cellHeight - 25)];
        _descriptionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _descriptionLabel.font =  [UIFont systemFontOfSize:10];
        _descriptionLabel.numberOfLines = 4;
        _descriptionLabel.textColor = [UIColor darkGrayColor];

        [contentView addSubview:_titleLabel];
        [contentView addSubview:_descriptionLabel];
        [self.contentView addSubview:contentView];
    }
    return self;
}

@end
