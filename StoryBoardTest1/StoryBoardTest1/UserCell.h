//
//  UserCell.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/7/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell
@property(weak, nonatomic) IBOutlet UILabel *numberLabel;
@property(weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property(weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

- (void)setNumberLabelText:(NSInteger)text;

- (void)setUserNameText:(NSString *)text;

@end
