//
//  CategoryItem.m
//  hatena
//
//  Created by Hideki Mutoh on 2014/09/26.
//

#import "CategoryItem.h"

#define EXCERPT(str, len) (([str length] > len) ? [[str substringToIndex:len-1] stringByAppendingString:@"…"] : str)

@implementation CategoryItem

@synthesize identifier, title, link;

- (NSString *)description {
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"MWFeedItem: "];
    if (title)   [string appendFormat:@"“%@”", EXCERPT(title, 50)];
    if (link)    [string appendFormat:@" (%@)", link];
    return string;
}

#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        identifier = [decoder decodeObjectForKey:@"identifier"];
        title = [decoder decodeObjectForKey:@"title"];
        link = [decoder decodeObjectForKey:@"link"];
        enclosures = [decoder decodeObjectForKey:@"enclosures"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    if (identifier) [encoder encodeObject:identifier forKey:@"identifier"];
    if (title) [encoder encodeObject:title forKey:@"title"];
    if (link) [encoder encodeObject:link forKey:@"link"];
    if (enclosures) [encoder encodeObject:enclosures forKey:@"enclosures"];
}

@end