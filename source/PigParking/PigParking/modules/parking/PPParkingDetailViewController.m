//
//  PPParkingDetailViewController.m
//  PigParking
//
//  Created by LiYongQiang on 14-8-23.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPParkingDetailViewController.h"
#import "PPParkingModel.h"
#import "PPMapView.h"
#import "FBImagesWheel.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PPParkingModel.h"
#import "PPHistoryDB.h"

@interface PPParkingDetailViewController () <UITableViewDataSource, UITableViewDelegate, FBImagesWheelDelegate>

@property (nonatomic, assign) UITableView *tableView;
@property (nonatomic, strong) PPParkingModel *model;
@property (nonatomic, strong) NSDictionary *parkingInfo;

@property (nonatomic, strong) FBImagesWheel *imagesWheelView;

@end

@implementation PPParkingDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.model = [PPParkingModel model];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack
                                                                                             target:self
                                                                                             action:@selector(btnBackClick:)];
    }
    return self;
}

- (void)loadView
{
    CGRect win_s = [UIScreen mainScreen].bounds;
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, win_s.size.width, win_s.size.height-20.0f-44.0f)];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imagesWheelView = [[FBImagesWheel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200.0f)];
    _imagesWheelView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
    _imagesWheelView.delegate = self;
    
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    tv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tv];
    self.tableView = tv;
    
    __block MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    [hud show:YES];
    
    [self.model fetchParkingDetails:_data[@"id"]
                           complete:^(id data, NSError *error) {
                               [hud hide:YES];
                               
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
                               
                               self.parkingInfo = data;
                               
                               tv.dataSource = self;
                               tv.delegate = self;
                               tv.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                               [self.tableView reloadData];
                               
                               [self setupImagesScrollView:data[@"smallImages"]];
                           }];
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
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        return 200.0f;
    }
    
    if (2 == indexPath.row)
    {
        return 85.0f;
    }
    
    return 54.0f;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 200.0f;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return _imagesWheelView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70.0f)];
    
    UIImage *im = [UIImage imageNamed:@"btn-bg"];
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setTitle:@"到这里去" forState:UIControlStateNormal];
    b.frame = CGRectMake(0, 0, im.size.width, im.size.height);
    b.center = CGPointMake(v.bounds.size.width*0.5, v.bounds.size.height*0.5);
    [b setBackgroundImage:im forState:UIControlStateNormal];
    [b addTarget:self action:@selector(btnGoHereClick:) forControlEvents:UIControlEventTouchDragInside];
    [v addSubview:b];
    
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail-images-cell"];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detail-images-cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell addSubview:_imagesWheelView];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail-cell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detail-cell"];
        cell.textLabel.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.imageView.image = nil;
    cell.textLabel.numberOfLines = 1;
    
    if (1 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"pk-details-cell-icon0"];
        cell.textLabel.text = _parkingInfo[@"address"];
    }
    else if (2 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"pk-details-cell-icon1"];
        cell.textLabel.numberOfLines = 3;
        cell.textLabel.text = [NSString stringWithFormat:@"前%@分钟免费；\n一小时%@元；\n全天%@元;", _parkingInfo[@"freeTime"], _parkingInfo[@"fristHourCharge"], _parkingInfo[@"fullDayCharge"]];
    }
    else if (3 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"pk-details-cell-icon2"];
        cell.textLabel.text = [NSString stringWithFormat:@"共 %@ 个车位", _parkingInfo[@"parkingCount"]];
    }
    
    return cell;
}

#pragma mark -

- (void)setupImagesScrollView:(NSArray *)images
{
    if (0 == images.count)
    {
        return;
    }
    
    [_imagesWheelView setImages:images];
}

- (void)imageWheelDidChangeImage:(FBImagesWheel *)wheel imageView:(UIImageView *)imageView
{
    NSMutableArray *a = [NSMutableArray array];
    
    for (NSString *d in _parkingInfo[@"bigImages"])
    {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [d hasPrefix:@"http"] ? [NSURL URLWithString:d] : [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", d]];
        photo.srcImageView = imageView;
        [a addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = imageView.tag;
    browser.photos = a;
    [browser show];
}

#pragma mark -

- (IBAction)btnGoHereClick:(id)sender
{
    if ([PPUser currentUser].isSaveSearchHistory)
    {
        [[PPHistoryDB db] insert:_data];
    }
    
    CLLocationCoordinate2D to = MAKE_COOR_S(_data[@"lat"], _data[@"lon"]);
    [PPMapView navigateFrom:_fromCoordinate to:to];
}

- (void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
