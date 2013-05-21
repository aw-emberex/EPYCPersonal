//
//  UserCell.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/7/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

@synthesize textLabel, numberLabel, starImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNumberLabelText:(NSInteger)text {
    //self.numberLabel.text = [[NSString alloc] initWithFormat:@"# %d", text];
}

- (void)setUserNameText:(NSString *)text {
    self.userNameLabel.text = text;
}

@end
