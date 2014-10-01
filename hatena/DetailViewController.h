//
//  DetailViewController.h
//  hatena
//
//  Created by Hideki Mutoh on 2014/09/26.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,MWFeedParserDelegate> {
    
    // Parsing
    MWFeedParser *feedParser;
    MWFeedParser *feedParser2;
    NSMutableArray *parsedItems;
    NSArray *itemsToDisplay;
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *titleString, *linkString;
@property (nonatomic, strong) NSArray *itemsToDisplay;
@property(nonatomic) NSInteger genre;

@end

