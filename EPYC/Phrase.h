//
//  Phrase.h
//  EPYC
//
//  Created by Alex Wait on 3/24/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Phrase : NSManagedObject

@property (nonatomic, retain) NSString * phraseText;

-(NSString*) description;

@end
