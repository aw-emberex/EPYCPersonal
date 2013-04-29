//
//  User.h
//  EPYCPersonal
//
//  Created by Alex Wait on 4/28/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * isSelectedUser;
@property (nonatomic, retain) NSString * name;

@end
