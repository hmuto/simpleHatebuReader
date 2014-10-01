//
//  DetailViewController.m
//  hatebu
//
//  Created by Hideki Mutoh on 2014/09/26.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "DetailTableViewCell.h"
#import "MWFeedParser_Private.h"

@implementation DetailViewController

@synthesize itemsToDisplay;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Setup
    self.title = @"Loading...";
    parsedItems = [[NSMutableArray alloc] init];
    self.itemsToDisplay = [NSArray array];

    // Refresh button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(refresh)];
    // Parse

    feedParser = [[MWFeedParser alloc] initWithFeedURL:self.getFeedUrl];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
    feedParser.connectionType = ConnectionTypeAsynchronously;
    [feedParser parse];

}


- (NSURL *)getFeedUrl {

    NSString *baseUrl = [NSString stringWithFormat:@"http://b.hatena.ne.jp/"];
    NSString *genreUri = [NSString stringWithFormat:@"hotentry"];
    NSString *suffix = [NSString stringWithFormat:@".rss"];
    NSString *urlString = [baseUrl stringByAppendingFormat:@"%@%@%@", genreUri, _linkString, suffix];
    NSURL *feedURL = [NSURL URLWithString:urlString];
    return feedURL;

}


- (void)loadView {

    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.backgroundColor = [UIColor whiteColor];

    CGFloat toolBarHeight = 0;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    CGRect tableViewRect = CGRectMake(view.bounds.origin.x, view.bounds.origin.y, view.bounds.size.width, view.bounds.size.height - toolBarHeight);

    _tableView = [[UITableView alloc] initWithFrame:tableViewRect];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [view addSubview:_tableView];
    self.view = view;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {

    self.title = @"Refreshing...";
    [parsedItems removeAllObjects];
    [feedParser stopParsing];
    [feedParser parse];
    self.tableView.userInteractionEnabled = NO;
    self.tableView.alpha = 0.3;
}

- (void)updateTableWithParsedItems {

    self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
            [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                 ascending:NO]]];
    self.tableView.userInteractionEnabled = YES;
    self.tableView.alpha = 1;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
    NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"Parsed Feed Info: “%@”", _titleString);
    self.title = _titleString;//info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"Parsed Feed Item: “%@”", item.title);
    if (item) [parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    [self updateTableWithParsedItems];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Finished Parsing With Error: %@", error);
    if (parsedItems.count == 0) {
        self.title = @"Failed"; // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                        message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
    }
    [self updateTableWithParsedItems];
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemsToDisplay.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    // Configure the cell.
    MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
    if (item) {
        // Set
        cell.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.titleLabel.text = item.title;//itemTitle;
        NSMutableString *subtitle = [NSMutableString string];
        [subtitle appendString:item.summary];//
        cell.descriptionLabel.text = subtitle;

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    WebViewController *webView = [WebViewController new];
    webView.title = [[itemsToDisplay objectAtIndex:indexPath.row] title];
    webView.linkString = [[itemsToDisplay objectAtIndex:indexPath.row] link];

    [self.navigationController pushViewController:webView animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


@end
