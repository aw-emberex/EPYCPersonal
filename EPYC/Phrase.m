//
//  Phrase.m
//  EPYC
//
//  Created by Alex Wait on 3/24/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "Phrase.h"


@implementation Phrase

@dynamic phraseText;

-(NSString*) description {
    NSString* test = [[NSString alloc]initWithFormat:@"PhraseText: %@", self.phraseText];
    return test;
}

@end
