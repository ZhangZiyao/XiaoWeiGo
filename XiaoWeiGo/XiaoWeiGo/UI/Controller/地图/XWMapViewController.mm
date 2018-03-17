//
//  XWMapViewController.m
//  XiaoWeiGo
//
//  Created by Ziyao on 2018/2/6.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWMapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "YUSegment.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "RouteAnnotation.h"
#import "BNRoutePlanModel.h"
#import "BNCoreServices.h"
#import "BNaviModel.h"

@interface XWMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKRouteSearchDelegate,BMKGeoCodeSearchDelegate,BNNaviUIManagerDelegate,BNNaviRoutePlanDelegate>
{
    BMKLocationService *_locService;
    BMKRouteSearch *_routeSearch;
    BMKMapView *_mapView;
    BMKGeoCodeSearch* _geocodesearch;
    
    BMKPlanNode *startNode;
    BMKPlanNode *endNode;
    
    BOOL hasRoute;
    NSInteger selectedIndex;
    
    CLLocation *currentLocation;
    BOOL loc;
}
@property (nonatomic, strong) YUSegmentedControl *segmentedControl;
//@property (nonatomic, strong) BMKMapView *mapView;
//@property (nonatomic, strong) BMKMapView *nowLocation;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation XWMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"到达目的地";
    [self showBackItem];
    selectedIndex = 0;
    
    startNode = [[BMKPlanNode alloc] init];
    endNode = [[BMKPlanNode alloc] init];
    if (self.address) {
        endNode.name = self.address;
    }
    
}

- (void)geoSearch{
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
//    geocodeSearchOption.city= _cityText.text;
    geocodeSearchOption.address = self.address;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}
- (void)reverseGeo{
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    if (currentLocation != nil) {
        pt = (CLLocationCoordinate2D){currentLocation.coordinate.latitude, currentLocation.coordinate.longitude};
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}
- (void)segmentedControlTapped:(YUSegmentedControl *)sender {
    NSLog(@"切换路线 %ld",sender.selectedSegmentIndex);
    selectedIndex = sender.selectedSegmentIndex;
    if (IsStrEmpty(self.address)) {
        return;
    }
    [self getRouteLine:sender.selectedSegmentIndex];
}
- (void)getRouteLine:(NSInteger)index{
    switch (index) {
        case 0:
        {
            [self onClickNewBusSearch];
        }
            break;
        case 1:
        {
            [self onClickDriveSearch];
        }
            break;
        case 2:
        {
            [self onClickWalkSearch];
        }
            break;
        case 3:
        {
            [self onClickRidingSearch];
        }
            break;
            
        default:
            break;
    }
}
- (void)layoutSubviews{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    [imageView setImage:[UIImage imageNamed:@"navigation_img_bg"]];
//    [self.view addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    _routeSearch = [[BMKRouteSearch alloc]init];
    _routeSearch.delegate = self;
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    if (!IsStrEmpty(self.address)) {
        endNode.name = self.address;
        [self geoSearch];
    }
    
    NSArray *array = @[@"公交",@"驾车",@"步行",@"骑行"];
    _segmentedControl = [[YUSegmentedControl alloc] initWithTitles:array];
    _segmentedControl.backgroundColor = bgColor;
    _segmentedControl.showsBottomSeparator = YES;
    _segmentedControl.showsTopSeparator = NO;
    _segmentedControl.showsIndicator = YES;
    [_segmentedControl addTarget:self action:@selector(segmentedControlTapped:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight-44)];
    _mapView.zoomLevel = 14.1; //地图等级，数字越大越清晰
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态为普通定位模式
//    _mapView.updateTargetScreenPtWhenMapPaddingChanged = YES;
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(44);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"map_loc"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.cornerRadius = 1.0;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(getMyLocation) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mapView).offset(20*kScaleW);
        make.size.mas_equalTo(CGSizeMake(60*kScaleW, 60*kScaleH));
        make.bottom.equalTo(_mapView).offset(-20*kScaleH);
    }];
    
    [self addBottomView];
    
    [self onClickNewBusSearch];
}
- (void)getMyLocation{
    loc = YES;
    [_locService startUserLocationService];
}
- (void)addBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
    UILabel *durationLabel = [[UILabel alloc] init];
    durationLabel.textColor = [UIColor blackColor];
    durationLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [bottomView addSubview:durationLabel];
    self.durationLabel = durationLabel;
    
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = UIColorFromRGB16(0x56bc8b);
    label.font = [UIFont rw_regularFontSize:15.0];
    [bottomView addSubview:label];
    self.label = label;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"map_arrow"] forState:UIControlStateNormal];
    [button setTitle:@"导航" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont rw_regularFontSize:14.0]];
    [button setBackgroundColor:UIColorFromRGB16(0x3385ff)];
    button.layer.cornerRadius = 3.0;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(startNavi) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(150*kScaleH);
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(20*kScaleH);
        make.right.equalTo(bottomView).offset(-20*kScaleH);
        make.size.mas_equalTo(CGSizeMake(100*kScaleW, 50*kScaleH));
    }];
    [durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(30*kScaleH);
        make.left.equalTo(bottomView).offset(20*kScaleH);
        make.right.equalTo(button.mas_left).offset(-20*kScaleH);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView).offset(-20*kScaleH);
        make.left.equalTo(durationLabel);
        make.width.mas_equalTo(200);
    }];
    self.bottomView.hidden = YES;
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
//        [_mapView addAnnotation:item];
//        _mapView.centerCoordinate = result.location;
//        NSString* titleStr;
//        NSString* showmeg;
        
//        titleStr = @"正向地理编码";
//        showmeg = [NSString stringWithFormat:@"纬度:%f,经度:%f",item.coordinate.latitude,item.coordinate.longitude];
//
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
//        [myAlertView show];
        
        endNode.pt = CLLocationCoordinate2DMake(item.coordinate.latitude,item.coordinate.longitude);
        if ((!IsStrEmpty(endNode.name)) && (!IsStrEmpty(startNode.name)) && !hasRoute) {
            hasRoute = YES;
            [self getRouteLine:selectedIndex];
        }
        
    }
}
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
//        [_mapView addAnnotation:item];
//        _mapView.centerCoordinate = result.location;
//        NSString* titleStr;
//        NSString* showmeg;
//        titleStr = @"反向地理编码";
//        showmeg = [NSString stringWithFormat:@"%@",item.title];
//
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
//        [myAlertView show];
        startNode.name = [NSString stringWithFormat:@"%@",item.title];
        if ((!IsStrEmpty(endNode.name)) && (!IsStrEmpty(startNode.name)) && !hasRoute) {
            hasRoute = YES;
            [self getRouteLine:selectedIndex];
        }
    }
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    _mapView.centerCoordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    if (IsStrEmpty(self.address) || loc) {
        loc = NO;
        [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    }
    [_mapView updateLocationData:userLocation];
    
    currentLocation = userLocation.location;
    if (!startNode.name) {
        [self reverseGeo];
    }
    startNode.pt = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    
    if ((!IsStrEmpty(endNode.name)) && (!IsStrEmpty(startNode.name)) && !hasRoute) {
        hasRoute = YES;
        [self getRouteLine:selectedIndex];
    }
}
#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [(RouteAnnotation*)annotation getRouteAnnotationView:view];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}
#pragma mark - BMKRouteSearchDelegate

- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"onGetDrivingRouteResult error:%d", (int)error);
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        [self calculateDuration:plan.duration andDistance:plan.distance];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = IsStrEmpty(startNode.name)?@"起点":startNode.name;
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注

            }
            if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = IsStrEmpty(endNode.name)?@"终点":endNode.name;
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];

            NSLog(@"%@   %@    %@", transitStep.entraceInstruction, transitStep.exitInstruction, transitStep.instruction);

            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }

        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"onGetWalkingRouteResult error:%d", (int)error);
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        [self calculateDuration:plan.duration andDistance:plan.distance];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = IsStrEmpty(startNode.name)?@"起点":startNode.name;
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注

            }
            if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = IsStrEmpty(endNode.name)?@"终点":endNode.name;
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];

            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }

        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }

        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR) {
//        [self resetSearch:result.suggestAddrResult];
//        [self onClickWalkSearch];
    }
}
/**
 *返回骑行搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKRidingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetRidingRouteResult:(BMKRouteSearch *)searcher result:(BMKRidingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    NSLog(@"onGetRidingRouteResult error:%d", (int)error);
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKRidingRouteLine* plan = (BMKRidingRouteLine*)[result.routes objectAtIndex:0];
        [self calculateDuration:plan.duration andDistance:plan.distance];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKRidingStep* transitStep = [plan.steps objectAtIndex:i];
            if (i == 0) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = IsStrEmpty(startNode.name)?@"起点":startNode.name;
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = IsStrEmpty(endNode.name)?@"终点":endNode.name;
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.degree = (int)transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];

            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }

        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKRidingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }

        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR) {
//        [self resetSearch:result.suggestAddrResult];
//        [self onClickRidingSearch];
    }
}
/**
 *返回公共交通路线检索结果（new）
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKMassTransitRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetMassTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKMassTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"onGetMassTransitRouteResult error:%d", (int)error);
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKMassTransitRouteLine* routeLine = (BMKMassTransitRouteLine*)[result.routes objectAtIndex:0];
        [self calculateDuration:routeLine.duration andDistance:routeLine.distance];
        BOOL startCoorIsNull = YES;
        CLLocationCoordinate2D startCoor;//起点经纬度
        CLLocationCoordinate2D endCoor;//终点经纬度
        
        NSInteger size = [routeLine.steps count];
        NSInteger planPointCounts = 0;
        for (NSInteger i = 0; i < size; i++) {
            BMKMassTransitStep* transitStep = [routeLine.steps objectAtIndex:i];
            for (BMKMassTransitSubStep *subStep in transitStep.steps) {
                //添加annotation节点
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = subStep.entraceCoor;
                item.title = subStep.instructions;
                item.type = 2;
                [_mapView addAnnotation:item];
                
                if (startCoorIsNull) {
                    startCoor = subStep.entraceCoor;
                    startCoorIsNull = NO;
                }
                endCoor = subStep.exitCoor;
                
                //轨迹点总数累计
                planPointCounts += subStep.pointsCount;
                
                //steps中是方案还是子路段，YES:steps是BMKMassTransitStep的子路段（A到B需要经过多个steps）;NO:steps是多个方案（A到B有多个方案选择）
                if (transitStep.isSubStep == NO) {//是子方案，只取第一条方案
                    break;
                }
                else {
                    //是子路段，需要完整遍历transitStep.steps
                }
            }
        }
        
        //添加起点标注
        RouteAnnotation* startAnnotation = [[RouteAnnotation alloc]init];
        startAnnotation.coordinate = startCoor;
        startAnnotation.title = IsStrEmpty(startNode.name)?@"起点":startNode.name;
        startAnnotation.type = 0;
        [_mapView addAnnotation:startAnnotation]; // 添加起点标注
        //添加终点标注
        RouteAnnotation* endAnnotation = [[RouteAnnotation alloc]init];
        endAnnotation.coordinate = endCoor;
        endAnnotation.title = IsStrEmpty(endNode.name)?@"终点":endNode.name;
        endAnnotation.type = 1;
        [_mapView addAnnotation:endAnnotation]; // 添加终点标注
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        NSInteger index = 0;
        for (BMKMassTransitStep* transitStep in routeLine.steps) {
            for (BMKMassTransitSubStep *subStep in transitStep.steps) {
                for (NSInteger i = 0; i < subStep.pointsCount; i++) {
                    temppoints[index].x = subStep.points[i].x;
                    temppoints[index].y = subStep.points[i].y;
                    index++;
                }
                
                //steps中是方案还是子路段，YES:steps是BMKMassTransitStep的子路段（A到B需要经过多个steps）;NO:steps是多个方案（A到B有多个方案选择）
                if (transitStep.isSubStep == NO) {//是子方案，只取第一条方案
                    break;
                }
                else {
                    //是子路段，需要完整遍历transitStep.steps
                }
            }
        }
        
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}
#pragma mark - 显示路程信息
- (void)calculateDuration:(BMKTime *)duration andDistance:(int)distance{
    NSMutableString *string = [NSMutableString string];
    if (duration.dates > 0) {
        [string appendString:[NSString stringWithFormat:@"%d天",duration.dates]];
    }
    if (duration.hours > 0) {
        [string appendString:[NSString stringWithFormat:@"%d小时",duration.hours]];
    }
    if (duration.minutes > 0) {
        [string appendString:[NSString stringWithFormat:@"%d分钟",duration.minutes]];
    }
    if (duration.seconds > 0) {
        [string appendString:[NSString stringWithFormat:@"%d秒",duration.seconds]];
    }
    [string appendString:@"    "];
    if (distance < 1000) {
        [string appendString:[NSString stringWithFormat:@"%d米",distance]];
    }else{
        [string appendString:[NSString stringWithFormat:@"%g公里",distance/1000.0]];
    }
    self.durationLabel.text = string;
    
    self.label.text = @"最快";
    self.bottomView.hidden = NO;
    [_mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(44);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-150*kScaleH);
    }];
    
}
-(void)onClickDriveSearch
{
//    BMKPlanNode* start = [[BMKPlanNode alloc]init];
//    start.name = @"火车站";
//    start.cityName = @"北京";
    
//    BMKPlanNode* end = [[BMKPlanNode alloc]init];
//    end.name = @"天安门";
//    end.cityName = @"北京";
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
//    drivingRouteSearchOption.city= @"烟台市";
    drivingRouteSearchOption.from = startNode;
    drivingRouteSearchOption.to = endNode;
    drivingRouteSearchOption.drivingRequestTrafficType = BMK_DRIVING_REQUEST_TRAFFICE_TYPE_NONE;//不获取路况信息
    BOOL flag = [_routeSearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
    }
    else
    {
        NSLog(@"car检索发送失败");
    }
    
}

-(void)onClickWalkSearch
{
//    BMKPlanNode* start = [[BMKPlanNode alloc]init];
//    start.name = @"烟台站";
//    start.cityName = @"烟台";
//    BMKPlanNode* end = [[BMKPlanNode alloc]init];
//    end.name = @"烟台大学";
//    end.cityName = @"烟台";
    
    
    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
//    walkingRouteSearchOption.city= @"烟台市";
    walkingRouteSearchOption.from = startNode;
    walkingRouteSearchOption.to = endNode;
    BOOL flag = [_routeSearch walkingSearch:walkingRouteSearchOption];
    if(flag)
    {
        NSLog(@"walk检索发送成功");
    }
    else
    {
        NSLog(@"walk检索发送失败");
    }
    
}

- (void)onClickRidingSearch {
//    BMKPlanNode* start = [[BMKPlanNode alloc]init];
//    start.name = @"烟台站";
//    start.cityName = @"烟台";
//    BMKPlanNode* end = [[BMKPlanNode alloc]init];
//    end.name = @"烟台大学";
//    end.cityName = @"烟台";
    
    BMKRidingRoutePlanOption *option = [[BMKRidingRoutePlanOption alloc]init];
//    option.city= @"烟台市";
    option.from = startNode;
    option.to = endNode;
    BOOL flag = [_routeSearch ridingSearch:option];
    if (flag)
    {
        NSLog(@"骑行规划检索发送成功");
    }
    else
    {
        NSLog(@"骑行规划检索发送失败");
    }
}
//新公交路线规划 - 支持跨城公交
- (void)onClickNewBusSearch{
//    BMKPlanNode* start = [[BMKPlanNode alloc]init];
//    start.name = @"烟台站";
//    start.cityName = @"烟台";
//    BMKPlanNode* end = [[BMKPlanNode alloc]init];
//    end.name = @"烟台大学";
//    end.cityName = @"烟台";
    
    BMKMassTransitRoutePlanOption *option = [[BMKMassTransitRoutePlanOption alloc]init];
//    option.city= @"烟台市";
    option.from = startNode;
    option.to = endNode;
    BOOL flag = [_routeSearch massTransitSearch:option];

    if(flag) {
        NSLog(@"公交交通检索（支持垮城）发送成功");
    } else {
        NSLog(@"公交交通检索（支持垮城）发送失败");
    }
    
//    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
//    transitRouteSearchOption.city= @"北京市";
//    transitRouteSearchOption.from = startNode;
//    transitRouteSearchOption.to = endNode;
//    BOOL flag = [_routeSearch transitSearch:transitRouteSearchOption];
//
//    if(flag)
//    {
//        NSLog(@"bus检索发送成功");
//    }
//    else
//    {
//        NSLog(@"bus检索发送失败");
//    }
}
#pragma mark - 私有

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat leftTopX, leftTopY, rightBottomX, rightBottomY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    // 左上角顶点
    leftTopX = pt.x;
    leftTopY = pt.y;
    // 右下角顶点
    rightBottomX = pt.x;
    rightBottomY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        leftTopX = pt.x < leftTopX ? pt.x : leftTopX;
        leftTopY = pt.y < leftTopY ? pt.y : leftTopY;
        rightBottomX = pt.x > rightBottomX ? pt.x : rightBottomX;
        rightBottomY = pt.y > rightBottomY ? pt.y : rightBottomY;
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(leftTopX, leftTopY);
    rect.size = BMKMapSizeMake(rightBottomX - leftTopX, rightBottomY - leftTopY);
    UIEdgeInsets padding = UIEdgeInsetsMake(30, 0, 100, 0);
    BMKMapRect fitRect = [_mapView mapRectThatFits:rect edgePadding:padding];
    [_mapView setVisibleMapRect:fitRect];
}
//输入的起终点有歧义，取返回poilist其他点重新发起检索
- (void)resetSearch:(BMKSuggestAddrInfo*)suggestInfo {
    if (suggestInfo.startPoiList.count > 0) {
        BMKPoiInfo *starPoi = [[BMKPoiInfo alloc] init];
        starPoi = suggestInfo.startPoiList[1];
//        _startAddrText.text = starPoi.name;
    }
    if (suggestInfo.endPoiList.count > 0) {
        BMKPoiInfo *endPoi = [[BMKPoiInfo alloc] init];
        endPoi = suggestInfo.endPoiList[1];
//        _endAddrText.text = endPoi.name;
    }
    [MBProgressHUD alertInfo:@"输入的起终点有歧义，取返回poilist其他点重新发起检索"];
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _routeSearch.delegate = self;
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _routeSearch.delegate = nil;
    _geocodesearch.delegate = nil; // 不用时，置nil
}
- (void)dealloc{
    if (_routeSearch != nil) {
        _routeSearch = nil;
    }
    if (_locService) {
        _locService = nil;
    }
    if (_mapView != nil) {
        _mapView = nil;
    }
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
}
//发起导航
- (void)startNavi
{
    if ((!IsStrEmpty(endNode.name)) && (!IsStrEmpty(startNode.name)) && !hasRoute) {
        return;
    }
    //节点数组
    NSMutableArray *nodesArray = [[NSMutableArray alloc]    initWithCapacity:2];
    
    //起点
    BNRoutePlanNode *start = [[BNRoutePlanNode alloc] init];
    start.pos = [[BNPosition alloc] init];
    start.pos.x = startNode.pt.latitude;
    start.pos.y = startNode.pt.longitude;
    start.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:start];
    
    //终点
    BNRoutePlanNode *end = [[BNRoutePlanNode alloc] init];
    end.pos = [[BNPosition alloc] init];
    end.pos.x = endNode.pt.latitude;
    end.pos.y = endNode.pt.longitude;
    end.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:end];
    
    //关闭openURL,不想跳转百度地图可以设为YES
    [BNCoreServices_RoutePlan setDisableOpenUrl:YES];
    [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:nodesArray time:nil delegete:self userInfo:nil];
    //发起路径规划
//    [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:nodesArray time:nil delegete:self userInfo:nil];
}
//算路成功后，在回调函数中发起导航，如下：
//算路成功回调
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{
    NSLog(@"算路成功");
    
    //路径规划成功，开始导航
    [BNCoreServices_UI showPage:BNaviUI_NormalNavi delegate:self extParams:nil];
}
- (id)naviPresentedViewController {
    return self;
}
//算路失败回调
- (void)routePlanDidFailedWithError:(NSError *)error andUserInfo:(NSDictionary*)userInfo
{
    NSString *message;
    switch ([error code]%10000)
    {
        case BNAVI_ROUTEPLAN_ERROR_LOCATIONFAILED:
            NSLog(@"暂时无法获取您的位置,请稍后重试");
            message = @"暂时无法获取您的位置,请稍后重试";
            break;
        case BNAVI_ROUTEPLAN_ERROR_ROUTEPLANFAILED:
            NSLog(@"无法发起导航");
            message = @"无法发起导航";
            break;
        case BNAVI_ROUTEPLAN_ERROR_LOCATIONSERVICECLOSED:
            NSLog(@"定位服务未开启,请到系统设置中打开定位服务。");
            message = @"定位服务未开启,请到系统设置中打开定位服务。";
            break;
        case BNAVI_ROUTEPLAN_ERROR_NODESTOONEAR:
            NSLog(@"起终点距离起终点太近");
            message = @"起终点距离起终点太近";
            break;
        default:
            NSLog(@"算路失败");
            message = @"路线获取失败，请稍后重试";
            break;
    }
    [MBProgressHUD alertInfo:message];
}

//算路取消回调
-(void)routePlanDidUserCanceled:(NSDictionary*)userInfo {
    NSLog(@"算路取消");
}

#pragma mark - 安静退出导航

- (void)exitNaviUI
{
    [BNCoreServices_UI exitPage:EN_BNavi_ExitTopVC animated:YES extraInfo:nil];
}

@end
