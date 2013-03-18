//
//  Phrase.m
//  EPYC
//
//  Created by Alex Wait on 3/16/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "Phrase.h"

@implementation Phrase

@synthesize author = _author;
@synthesize phraseText = _phraseText;

-(id) init {
    return [self initWithAll:@"" :@""];
}

-(id) initWithAuthor:(NSString *)authorName {
    return [self initWithAll:@"" :authorName];
}

-(id) initWithPhraseText:(NSString *)phraseText {
    return [self initWithAll:phraseText :@""];
}

-(id) initWithAll:(NSString *)phraseText :(NSString *)authorName {
    if (self = [super init]) {
        [self setAuthor:authorName];
        [self setPhraseText:phraseText];
    }
    return self;
}

@end
