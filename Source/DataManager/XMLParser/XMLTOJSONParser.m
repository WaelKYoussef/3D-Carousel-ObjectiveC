//
//  XMLTOJSONParser.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "XMLTOJSONParser.h"
#import "NSString+XMLExtensions.h"

#define _XMLTOJSONParserStringValueKey @"stringValue"
#define _XMLTOJSONParserAttributePrefix @"-"

@interface XMLTOJSONParser () <NSXMLParserDelegate> {
    NSMutableArray<NSMutableDictionary*>* _dictionaryStack;
}
@end

@implementation XMLTOJSONParser

-(instancetype)init {
    self = [super init];
    if (self) {
        _dictionaryStack = nil;
    }
    return self;
}

-(NSDictionary*)parseXMLData:(NSData*)data {
    
    _dictionaryStack = [[NSMutableArray alloc] initWithCapacity:30];
    [self pushDictionary:[[NSMutableDictionary alloc] initWithCapacity:1]];
    
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    
    if (_dictionaryStack.count > 0)
        return [NSDictionary dictionaryWithDictionary:_dictionaryStack[0]];
    
    return nil;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    NSMutableDictionary* dictionary = [self newElementDictionaryWithAttributes:attributeDict];
    [self addElementDictionary:dictionary withKey:elementName];
    [self pushDictionary:dictionary];
}

-(NSMutableDictionary*)newElementDictionaryWithAttributes:(NSDictionary*)attributes {
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] initWithCapacity:30];
    for (NSString* key in attributes.allKeys) {
        NSString* attributeKey = [_XMLTOJSONParserAttributePrefix stringByAppendingString:key];
        [dictionary setValue:attributes[key] forKey:attributeKey];
    }
    
    return dictionary;
}

-(void)addElementDictionary:(NSDictionary*)dictionary withKey:(NSString*)key {
    NSDictionary* currentDictionary = [self currentDictionary];
    id value = [currentDictionary valueForKey:key];
    if (value == nil) {
        [currentDictionary setValue:dictionary forKey:key];
    } else if ([value isKindOfClass:[NSMutableArray class]]) {
        [(NSMutableArray*)value addObject:dictionary];
    } else {
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:20];
        [array addObject:value];
        [array addObject:dictionary];
        [currentDictionary setValue:array forKey:key];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([string isWhiteSpace] == false) {
        NSMutableDictionary* currentDictionary = [self currentDictionary];
        NSString* currentValue = currentDictionary[_XMLTOJSONParserStringValueKey];
        NSString* newValue = nil;
        if (currentValue.length > 0)
            newValue = [currentValue stringByAppendingString:string];
        else
            newValue = string;
        [currentDictionary setValue:newValue forKey:_XMLTOJSONParserStringValueKey];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    [self replaceStringOnlyDictionaries];
    [self popDictionary];
}

-(void)replaceStringOnlyDictionaries {
    NSMutableDictionary* currentDictionary = [self currentDictionary];
    for (NSString* key in [currentDictionary allKeys]) {
        id value = currentDictionary[key];
        
        if ([value isKindOfClass:[NSMutableArray class]]) {
          
            NSMutableArray* array = (NSMutableArray*)value;
            for (int ii = 0; ii < array.count; ii++) {
                if ([array[ii] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary* dictionary = array[ii];
                    if ([self dictionaryContainsOnlyStringValue:dictionary]) {
                        NSString* stringValue = dictionary[_XMLTOJSONParserStringValueKey];
                        [array replaceObjectAtIndex:ii withObject:stringValue];
                    }
                }
            }
            
        } else if ([value isKindOfClass:[NSMutableDictionary class]]) {
          
            NSMutableDictionary* dictionary = (NSMutableDictionary*)value;
            if ([self dictionaryContainsOnlyStringValue:dictionary]) {
                NSString* stringValue = dictionary[_XMLTOJSONParserStringValueKey];
                [currentDictionary setValue:stringValue forKey:key];
            }
            
        }
    }
}

-(BOOL)dictionaryContainsOnlyStringValue:(NSDictionary*)dictionary {
    NSArray* keys = dictionary.allKeys;
    return (keys.count == 1 && [keys[0] isEqualToString:_XMLTOJSONParserStringValueKey]);
}

-(NSMutableDictionary*)currentDictionary {
    return [_dictionaryStack lastObject];
}

-(void)pushDictionary:(NSMutableDictionary*)dictionary {
    [_dictionaryStack addObject:dictionary];
}

-(NSMutableDictionary*)popDictionary {
    if (_dictionaryStack.count > 0) {
        NSMutableDictionary* dictionary = [_dictionaryStack lastObject];
        [_dictionaryStack removeLastObject];
        return dictionary;
    }
    
    return nil;
}

-(void)addMultiValue:(id)value withKey:(NSString*)key toDictionary:(NSMutableDictionary*)dicitonary {
    id currentValue = [dicitonary valueForKey:key];
    if (currentValue == nil) {
        [dicitonary setValue:value forKey:key];
    } else if ([value isKindOfClass:[NSMutableArray class]]) {
        [(NSMutableArray*)value addObject:value];
    } else {
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:20];
        [array addObject:currentValue];
        [array addObject:value];
        [dicitonary setValue:array forKey:value];
    }
}

@end
