//
//  Phrase.h
//  EPYC
//
//  Created by Alex Wait on 3/16/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Phrase : NSObject

@property (nonatomic, readwrite) NSString* phraseText;
@property (nonatomic, readwrite) NSString* author;

-(id) init;
-(id) initWithPhraseText: (NSString*) phraseText;
-(id) initWithAuthor: (NSString*) authorName;
-(id) initWithAll: (NSString*) phraseText : (NSString*)authorName;

@end
