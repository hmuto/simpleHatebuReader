//
//  CategoryItem.h
//  hatena
//
//  Created by Hideki Mutoh on 2014/09/26.
//

#import <Foundation/Foundation.h>

@interface CategoryItem : NSObject{
    
    
    NSString *identifier; // Item identifier
    NSString *title; // Item title
    NSString *link; // Item URL
    
    NSArray *enclosures;
    
}

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;

@end

