//
//  PPIndexViewController.m
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPIndexViewController.h"
#import "PPSettingsViewController.h"
#import "PPParkingDetailsViewController.h"
#import "PPMapView.h"
#import "PPPullView.h"
#import "PPParkingTableView.h"
#import "PPParkingFilterView.h"
#import "PPParkingDetailsView.h"
#import "PPIndexModel.h"

typedef enum {
    PPIndexViewTagMask          = 901,
    PPIndexViewTagTipsLabel,
    PPIndexViewTagMapToolBar,
}PPIndexViewTags;

@interface PPIndexViewController ()

@property (nonatomic, assign) BOOL isStartPage;

@property (nonatomic, assign) PPMapView *mapView;
@property (nonatomic, assign) UIView *mapToolBar;
@property (nonatomic, assign) UITextField *tfSearchBox;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@property (nonatomic, strong) PPPullView *pullView;

@property (nonatomic, strong) PPIndexModel *indexModel;
@property (nonatomic, strong) NSArray *parkingArray;

@end

@implementation PPIndexViewController

+ (UINavigationController *)navController
{
    PPIndexViewController *c = [[PPIndexViewController alloc] initWithNibName:nil bundle:nil];
    
//    PPSettingsViewController *c = [[PPSettingsViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    
    
    return nc;
}

- (void)dealloc
{
    self.leftBarButtonItem = nil;
    self.rightBarButtonItem = nil;
    
    self.indexModel = nil;
    self.parkingArray = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _isStartPage = YES;
        
        self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemList
                                                                              target:self
                                                                              action:@selector(btnBarListClick:)];
        
        self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemFilter
                                                                               target:self
                                                                               action:@selector(btnBarFilterClick:)];
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
    
    [self.navigationController.navigationBar setupTheme];
    
    _mapView = [PPMapView mapViewWithFrame:self.view.bounds];
    _mapView.mapView.userInteractionEnabled = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [_mapView startUpdatingLocation];
    
    [self setupStartUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (void)setupStartUI
{
    _mapView.userInteractionEnabled = NO;
    
        //nav
    UIImage *im_srh = [UIImage imageNamed:@"nav-bar-srh"];
    
    if ([UIImage instancesRespondToSelector:@selector(animatedResizableImageNamed:capInsets:resizingMode:duration:)])
    {
        im_srh = [UIImage animatedResizableImageNamed:@"tf-srh-bg"
                                            capInsets:UIEdgeInsetsMake(0, 25, 0, 25)
                                         resizingMode:UIImageResizingModeStretch
                                             duration:0.0f];

    }
    else
    {
        im_srh = [UIImage animatedResizableImageNamed:@"tf-srh-bg" capInsets:UIEdgeInsetsMake(0, 25, 0, 25) duration:0.0f];
    }
    
    UITextField *tf_srh = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, im_srh.size.width, im_srh.size.height)];
    tf_srh.background = im_srh;
    tf_srh.delegate = self;
    tf_srh.returnKeyType = UIReturnKeySearch;
    tf_srh.font = [UIFont systemFontOfSize:13.0f];
    tf_srh.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 15.0f, tf_srh.bounds.size.height)];
    tf_srh.leftViewMode = UITextFieldViewModeAlways;
    self.tfSearchBox = tf_srh;
    
    self.navigationItem.titleView = tf_srh;
    
        //mask
    UIImageView *mask = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start-mask"]];
    mask.tag = PPIndexViewTagMask;
    [self.view addSubview:mask];
    
        //map tool bar
    {
        UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, self.view.bounds.size.height, self.view.bounds.size.width, 70.0f)];
        tb.tag = PPIndexViewTagMapToolBar;
        [tb setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
        
        if ([tb respondsToSelector:@selector(setShadowImage:forToolbarPosition:)])
        {
            [tb setShadowImage:[[UIImage alloc] init] forToolbarPosition:UIBarPositionBottom];
        }
        
        NSMutableArray *its = [NSMutableArray array];
        UIButton *btn = nil;
        UIBarButtonItem *it = nil;
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 49.0f, 49.0f);
        [btn setImage:[UIImage imageNamed:@"tool-scope"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tool-scope-h"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnScopeClick:) forControlEvents:UIControlEventTouchUpInside];
        it = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [its addObject:it];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 49.0f, 49.0f);
        [btn setImage:[UIImage imageNamed:@"tool-settings"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tool-settings-h"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnSettingClick:) forControlEvents:UIControlEventTouchUpInside];
        it = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [its addObject:it];
        
        it = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [its addObject:it];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 49.0f, 49.0f);
        [btn setImage:[UIImage imageNamed:@"tool-zoomin"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tool-zoomin-h"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnZoominClick:) forControlEvents:UIControlEventTouchUpInside];
        it = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [its addObject:it];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 49.0f, 49.0f);
        [btn setImage:[UIImage imageNamed:@"tool-zoomout"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tool-zoomout-h"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnZoomoutClick:) forControlEvents:UIControlEventTouchUpInside];
        it = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [its addObject:it];
        
        tb.items = its;
        
        [self.view addSubview:tb];
    }
    
        //tips
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 405.0f, [UIScreen mainScreen].bounds.size.width, 20.0f)];
    lb.tag = PPIndexViewTagTipsLabel;
    lb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    lb.font = [UIFont systemFontOfSize:13.0f];
    lb.backgroundColor = [UIColor clearColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor colorWithRed:0.73f green:0.73f blue:0.73f alpha:1.0f];
    lb.text = @"已累计为 XXXXXXXX 位用户找到免费车位";
    [self.view addSubview:lb];
    
    UIGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapStartUIGesture:)];
    [self.view addGestureRecognizer:g];
}

- (void)onTapStartUIGesture:(UIGestureRecognizer *)gesture
{
    [self.view removeGestureRecognizer:gesture];
    
    if ([_tfSearchBox isFirstResponder])
    {
        [_tfSearchBox resignFirstResponder];
    }
    
    [self transacteToIndexUI];
}

- (void)onTapSearchUIGesture:(UITapGestureRecognizer *)gesture
{
    [self.view removeGestureRecognizer:gesture];
    
    if (!_isStartPage)
    {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             UIView *v = self.navigationItem.titleView;
                             v.frame = CGRectMake(0.0f, 0.0f, 230.0f, v.bounds.size.height);
                         }];
        
        [self.navigationItem setLeftBarButtonItem:self.leftBarButtonItem animated:YES];
        [self.navigationItem setRightBarButtonItem:self.rightBarButtonItem animated:YES];
    }
    
    _mapView.userInteractionEnabled = YES;
    
    [_tfSearchBox resignFirstResponder];
}

- (void)transacteToIndexUI
{
    UIView *v1 = [self.view viewWithTag:PPIndexViewTagMask];
    UIView *v2 = [self.view viewWithTag:PPIndexViewTagTipsLabel];
    UIView *v3 = self.navigationItem.titleView;
    UIView *v4 = [self.view viewWithTag:PPIndexViewTagMapToolBar];
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         v2.center = CGPointMake(v2.center.x, [UIScreen mainScreen].bounds.size.height+20.0f);
                         v2.alpha = 0.2f;
                     }
                     completion:^(BOOL finished) {
                         [v2 removeFromSuperview];
                     }];
    
    [UIView animateWithDuration:0.3f
                          delay:0.3f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         v1.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         
                         if (finished)
                         {
                             [v1 removeFromSuperview];
                             
                             [UIView animateWithDuration:0.25f
                                              animations:^{
                                                  v3.frame = CGRectMake(0.0f, 0.0f, 230.0f, v3.bounds.size.height);
                                                  v4.center = CGPointMake(v4.center.x, v4.center.y-v4.bounds.size.height);
                                              }];
                             
                             [self.navigationItem setLeftBarButtonItem:self.leftBarButtonItem animated:YES];
                             [self.navigationItem setRightBarButtonItem:self.rightBarButtonItem animated:YES];
                             
                             self.mapView.userInteractionEnabled = YES;
                             
                             self.isStartPage = NO;
                         }
                     }];
}

#pragma mark - nav bar buttons event

- (void)btnBarListClick:(id)sender
{
    if (_pullView)
    {
        [_pullView hide:NO];
        self.pullView = nil;
        
        [self.navigationItem setLeftBarButtonItem:self.leftBarButtonItem animated:YES];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        _tfSearchBox.enabled = YES;
    }
    
    PPParkingTableView *tv = [[PPParkingTableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height-80.0f)
                                                                  data:_parkingArray];
    tv.actDelegate = self;
    self.pullView = [[PPPullView alloc] initWithParentView:self.view contentView:tv mask:YES];
    [_pullView show];
    
    UIBarButtonItem *back_it = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack
                                                                            target:self
                                                                            action:@selector(btnQuitParkingListClick)];
    [self.navigationItem setLeftBarButtonItem:back_it animated:YES];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    _tfSearchBox.enabled = NO;
}

- (void)btnBarFilterClick:(id)sender
{
    if (_pullView)
    {
        [_pullView hide:YES];
        self.pullView = nil;
        
        self.navigationItem.leftBarButtonItem.enabled = YES;
        _tfSearchBox.enabled = YES;
        
        return;
    }
    
    PPParkingFilterView *fv = [[PPParkingFilterView alloc] initWithDelegate:self];
    self.pullView = [[PPPullView alloc] initWithParentView:self.view contentView:fv mask:YES];
    [_pullView show];
    
    self.navigationItem.leftBarButtonItem.enabled = NO;
    _tfSearchBox.enabled = NO;
}

- (void)btnQuitParkingListClick
{
    [_pullView hide:YES];
    
    [self.navigationItem setLeftBarButtonItem:self.leftBarButtonItem animated:YES];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    _tfSearchBox.enabled = YES;
}

#pragma mark - map tool bar buttons event

- (void)btnScopeClick:(id)sender
{
    [_mapView startUpdatingLocation];
}

- (void)btnSettingClick:(id)sender
{
    PPSettingsViewController *c = [[PPSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:c animated:YES];
}

- (void)btnZoominClick:(id)sender
{
    [_mapView zoomIn];
}

- (void)btnZoomoutClick:(id)sender
{
    [_mapView zoomOut];
}

#pragma mark - model

- (void)fetchAroundParking
{
    if (!_indexModel)
    {
        self.indexModel = [PPIndexModel model];
    }
    
    [_indexModel fetchAroundParking:_mapView.coordinate block:^(NSArray *data, NSError *error) {
        self.parkingArray = data;
        [self.mapView showAroundParking:data];
    }];
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapSearchUIGesture:)];
    [self.view addGestureRecognizer:g];
    
    if (_isStartPage)
    {
        return YES;
    }
    
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         UIImage *im_srh = [UIImage imageNamed:@"nav-bar-srh"];
                         UIView *v = self.navigationItem.titleView;
                         
                         v.frame = CGRectMake(0.0f, 0.0f, im_srh.size.width, v.bounds.size.height);
                     }];
    
    _mapView.userInteractionEnabled = NO;
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - mapview delegate

- (void)ppMapView:(PPMapView *)mapView didUpdateToLocation:(CLLocation *)newLocation
{
    [self fetchAroundParking];
}

- (void)ppMapView:(PPMapView *)mapView didSelectAnnotation:(PPMapAnnoation *)annotation
{
    if (_pullView)
    {
        [_pullView hide:NO];
        _pullView = nil;
    }
    
    NSDictionary *d = (NSDictionary *)annotation.data;
    
    PPParkingDetailsView *v = [[PPParkingDetailsView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 138.0f)];
    v.delegate = self;
    v.title = d[@"title"];
    v.chargeText = d[@"charge"];
    v.distanceText = d[@"distance"];
    v.parkingCountText = d[@"parkingCount"];
    v.addressText = d[@"address"];
    v.flag = PPParkingTableViewCellFlagCheap;
    v.fromCoordinate = _mapView.coordinate;
    v.toCoordinate = CLLocationCoordinate2DMake([d[@"lat"] floatValue], [d[@"lon"] floatValue]);
    
    _pullView = [[PPPullView alloc] initWithParentView:self.view contentView:v mask:NO];
    [_pullView showNoMask];
}

- (void)ppMapView:(PPMapView *)mapView didDeselectAnnotation:(PPMapAnnoation *)annotation
{
    [_pullView hide:YES];
    _pullView = nil;
}

#pragma mark - parking tableview delegate

- (void)parkingTableView:(PPParkingTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PPParkingDetailsViewController *c = [[PPParkingDetailsViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:c animated:YES];
}

#pragma mark - parking details view delegate

- (void)ppParkingDetailsViewGoHere:(PPParkingDetailsView *)view
{
    
}

- (void)ppParkingDetailsViewShowDetails:(PPParkingDetailsView *)view
{
    PPParkingDetailsViewController *v = [[PPParkingDetailsViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:v animated:YES];
}

@end
