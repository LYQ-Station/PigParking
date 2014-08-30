//
//  PPMapSearchTableViewController.m
//  PigParking
//
//  Created by Vincent on 7/15/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPMapSearchTableViewController.h"
#import "PPMapSearchModel.h"


@interface PPMapSearchTableViewController () <BMKPoiSearchDelegate>

@property (nonatomic, strong) PPMapSearchModel *model;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation PPMapSearchTableViewController

- (void)dealloc
{
    self.model = nil;
    self.data = nil;
}

- (id)initWithDelegate:(id)delegate
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self)
    {
        _searchDelegate = delegate;
        self.model = [PPMapSearchModel model];
        self.data = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == _data.count)
    {
        return 1;
    }
    
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == _data.count)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"empty-cell"];
        cell.textLabel.text = @"暂无记录。";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor grayColor];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"srh-cell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"srh-cell"];
    }
    
    if (PPMapSearchTableViewControllerModeMapSDKSearch == _mode)
    {
        BMKPoiInfo *d = _data[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:@"pk-details-cell-icon0"];
        cell.textLabel.text = d.name;
        cell.detailTextLabel.text = d.address;
        
        return cell;
    }
    
    NSDictionary *d = (NSDictionary *)(_data[indexPath.row]);
    
    if ([d[@"charge"] hasPrefix:@"0"])
    {
        cell.imageView.image = [UIImage imageNamed:@"map-free-parking"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"map-nofree-parking"];
    }
    
    cell.textLabel.text = d[@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"车位:%@  地址:%@", d[@"parkingCount"], d[@"address"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == _data.count)
    {
        return;
    }
    
    if (_searchDelegate)
    {
        if (PPMapSearchTableViewControllerModeHistory == _mode)
        {
            [_searchDelegate performSelector:@selector(ppMapSearchTableViewContrllerDidSelectHistory:item:) withObject:self withObject:_data[indexPath.row]];
        }
        else
        {
            [_searchDelegate performSelector:@selector(ppMapSearchTableViewContrllerDidSelectSearchResult:item:) withObject:self withObject:_data[indexPath.row]];
        }
    }
}

#pragma mark -

- (void)clean
{
    [_data removeAllObjects];
    [self.tableView reloadData];
}

- (void)showHistory
{
    _mode = PPMapSearchTableViewControllerModeHistory;
    
    [_data removeAllObjects];
    [_data addObjectsFromArray:[_model fetchHistoryList]];
    [self.tableView reloadData];
}

- (void)filterHistory:(NSString *)keyword
{
    [_data removeAllObjects];
    [_data addObjectsFromArray:[_model filterHistoryList:keyword]];
    [self.tableView reloadData];
}

- (void)doSearch:(NSString *)keyword
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.labelText = @"搜索中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    _mode = PPMapSearchTableViewControllerModeSearch;
    
    [self clean];
    
    [_model doSearch:keyword
            complete:^(NSArray *data, NSError *error) {
                [hud hide:NO];
                if (error)
                {
                    MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
                    alert.labelText = error.userInfo[NSLocalizedDescriptionKey];
                    alert.mode = MBProgressHUDModeText;
                    [self.view addSubview:alert];
                    [alert show:YES];
                    [alert hide:YES afterDelay:1.5];
                    return ;
                }
                
                [_data removeAllObjects];
                
                if ([[data class] isSubclassOfClass:[NSArray class]])
                {
                    [_data addObjectsFromArray:data];
                }
                
                [self.tableView reloadData];
            }];
}

- (void)doMapSDKSearch:(NSString *)keyword
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.labelText = @"搜索中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    _mode = PPMapSearchTableViewControllerModeMapSDKSearch;
    
    [self clean];
    
    BMKCitySearchOption *o = [[BMKCitySearchOption alloc] init];
    o.keyword = keyword;
    o.city = @"深圳市";
    
    BMKPoiSearch *s = [[BMKPoiSearch alloc] init];
    s.delegate = self;
    [s poiSearchInCity:o];
}

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_data removeAllObjects];
    [_data addObjectsFromArray:poiResult.poiInfoList];
    [self.tableView reloadData];
}

@end
