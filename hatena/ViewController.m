//
//  ViewController.m
//  hatena
//
//  Created by Hideki Mutoh on 2014/09/26.
//

#import "ViewController.h"
#import "CategoryItem.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    categoryItems = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    [self initCategory];
    [self.tableView reloadData];
}

-(void)initCategory{
    [self addCategoryItem:@"総合" withUrl:@""];
    [self addCategoryItem:@"世の中" withUrl:@"/social"];
    [self addCategoryItem:@"政治と経済" withUrl:@"/economics"];
    [self addCategoryItem:@"暮らし" withUrl:@"/life"];
    [self addCategoryItem:@"テクノロジー" withUrl:@"/it"];
    [self addCategoryItem:@"エンタメ" withUrl:@"/entertainment"];
    [self addCategoryItem:@"アニメとゲーム" withUrl:@"/game"];
    [self addCategoryItem:@"おもしろ" withUrl:@"/fun"];
}

-(void)addCategoryItem:(NSString *)title withUrl:(NSString *)url{
    CategoryItem *item = [[CategoryItem alloc] init];
    item.link = url;
    item.title = title;
    [categoryItems addObject:item];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    NSLog(@"count: %lu",(unsigned long)categoryItems.count);
    return categoryItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) { // yes
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    NSLog(@"a: %@",[[categoryItems objectAtIndex:indexPath.row] title]);
    cell.textLabel.text = [[categoryItems objectAtIndex:indexPath.row] title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     DetailViewController *detail = [[DetailViewController alloc] init];
     detail.titleString = [[categoryItems objectAtIndex:indexPath.row] title];
     detail.linkString = [[categoryItems objectAtIndex:indexPath.row] link];
     [self.navigationController pushViewController:detail animated:YES];
     
}


@end
