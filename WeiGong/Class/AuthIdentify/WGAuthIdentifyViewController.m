//
//  WGAuthIdentifyViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGAuthIdentifyViewController.h"
#import "WGAuthIdentify.h"
#import "WGBaseLabel.h"

#import "WGAuthIdentifyNameCell.h"
#import "WGAuthIdentifyPostPhotoCell.h"
#import "WGAuthIdentifyFootView.h"

#import "WGAuthIdentifyPostPhotoView.h"
#import "WGRequestManager.h"

@class WGAuthIdentifyPostPhotoItem;
@interface WGAuthIdentifyViewController ()
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) WGAuthIdentify *identify;
@property (nonatomic, strong) WGBaseLabel *labauthstate; // 认证状态
@property (nonatomic, strong) WGBaseLabel *labuploadphoto; // 上传身份证照片
@property (nonatomic, strong) WGAuthIdentifyFootView *footView; // 上传身份证照片

@property (nonatomic, copy) NSArray <WGAuthIdentifyPostPhotoItem *> *photoItems;
@end

@implementation WGAuthIdentifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份认证";
}

- (void)wg_loadData {
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:self.requestUrl];
    
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.responseJSON) {
            WGAuthIdentify *identify = [WGAuthIdentify wg_modelWithDictionry:response.responseJSON];
            
//            identify.agileFlag = 0;
//            identify.checkFlag = 0;
            
            self.identify = identify;
            
            NSString *authText = @"身份认证";
            if (identify.checkFlag == 1) {
                authText = @"认证审核中";
            } else if (identify.checkFlag == 2) {
                authText = @"认证通过";
            } else if (identify.checkFlag == 3) {
                authText = @"身份认证失败";
                if (identify.checkReason) {
                    authText = [NSString stringWithFormat:@"认证失败：%@", identify.checkReason];
                }
            }
            self.labauthstate.text = kStringAppend(@"   ", authText);
            
            self.footView.identify = self.identify;
            self.tableView.tableFooterView = self.footView;
            
            self.dataArray = [self dataListWithIdentify:identify];
            
            [self.tableView wg_reloadData];
        }
    }];
}
- (NSArray *)dataListWithIdentify:(WGAuthIdentify *)identify {
    if (identify == nil)  return nil;
    NSArray *nameList = @[@"真实姓名", @"身份证号"];
    NSMutableArray *dataArray = @[].mutableCopy;
    for (NSInteger i = 0; i < nameList.count; i++) {
        WGAuthIdentifyNameItem *item = [WGAuthIdentifyNameItem new];
        item.text_left = nameList[i];
        item.text_right = (i==0) ? identify.personalName:identify.identityCard;
        item.canInput = !(identify.checkFlag == 1 || identify.checkFlag == 2 );
        item.index = i;
        [dataArray wg_addObject:item];
    }
    return [dataArray copy];
}
#pragma mark - 代理方法
- (NSInteger)wg_numberOfSections {
    if (self.identify) {
        return 2;
    } else {
        return 0;
    }
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    NSInteger count = (section == 0) ? [self.dataArray count]:1;
    return count;
}
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        WGAuthIdentifyNameItem *item = self.dataArray[indexPath.row];
        WGAuthIdentifyNameCell *cell = [WGAuthIdentifyNameCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    } else if (indexPath.section == 1) {
        WGAuthIdentifyPostPhotoCell *cell = [WGAuthIdentifyPostPhotoCell wg_cellWithTableView:self.tableView];
        cell.identify = self.identify;
        self.photoItems = cell.photoItems;
        return cell;
    }
    
    WG_BaseTableViewCell *cell = [WG_BaseTableViewCell wg_cellWithTableView:self.tableView];
    cell.textLabel.text = @"12";
    return cell;
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 30;
}
- (UIView *)wg_headerAtSection:(NSInteger)section {
    if (section == 0) {
        return self.labauthstate;
    } else if (section == 1) {
        return self.labuploadphoto;
    }
    return nil;
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    if (indexPath.section == 1) {
        WGAuthIdentifyNameItem *item1 = self.dataArray[0];
        WGAuthIdentifyNameItem *item2 = self.dataArray[1];
//        NSString *name = kStringAppend(item1.text_right, item2.text_right);
        WGLog(@"name:%@---%@",item1.text_right, item2.text_right);
    }
}
#pragma mark - getter && setter 
- (WGBaseLabel *)labauthstate {
    if (!_labauthstate) {
        _labauthstate = [WGBaseLabel wg_labelWithFont:kFont_15 textColor:kColor_Orange];
        _labauthstate.backgroundColor = kColor(253, 246, 220);
        CGFloat left = 5;
        _labauthstate.insets = UIEdgeInsetsMake(0, left, 0, 0);
//        _labauthstate.frame = CGRectMake(0, 0, kScreenWidth, 30);
    }
    return _labauthstate;
}
- (WGBaseLabel *)labuploadphoto {
    if (!_labuploadphoto) {
        _labuploadphoto = [WGBaseLabel wg_labelWithFont:kFont_15 textColor:kColor_Black_Sub];
        _labuploadphoto.backgroundColor = kClearColor;
        CGFloat left = 5, top = 4;
        _labuploadphoto.insets = UIEdgeInsetsMake(top, left, 0, 0);
        _labuploadphoto.text = @"   上传身份证照片";
//        _labuploadphoto.frame = CGRectMake(0, 0, kScreenWidth, 30);
    }
    return _labuploadphoto;
}
- (WGAuthIdentifyFootView *)footView {
    if (!_footView) {
        __weak typeof(self) weakself = self;
        _footView = [WGAuthIdentifyFootView new];
        _footView.wg_height = 220;
        _footView.tapHandle = ^() {
            __strong typeof(weakself) strongself = weakself;
            [strongself submitData];
        };
    }
    return _footView;
}
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/getPersonBasicInfo";
}
- (void)dealloc {
    NSString *url = @"/linggb-ws/ws/0.1/person/commitIdentity";
    [WGRequestManager cancelTaskWithUrl:url];
}
#pragma mark - 提交数据
- (void)submitData {
    
    WGAuthIdentifyNameItem *item1 = self.dataArray[0];
    WGAuthIdentifyNameItem *item2 = self.dataArray[1];
    
//    WGLog(@"url1:%@ url2:%@ url3:%@",self.identify.identityCardUrl, self.identify.identityCardUrl2, self.identify.identityCardUrl3);
    NSString *name = [item1.text_right stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (name.length == 0) {
        [MBProgressHUD wg_message:@"请输入姓名"];
        return;
    }
    if (![item2.text_right wg_isIdentifyCard]) {
        [MBProgressHUD wg_message:@"请输入正确身份证号码"];
        return;
    }

    for (WGAuthIdentifyPostPhotoItem *photoItem in self.photoItems) {
        
        if (photoItem.imageUrl.length == 0) {
            NSString *message = @"请选择身份证正面照片";
            if (photoItem.index == 1) {
                message = @"请选择身份证背面照片";
            } else if (photoItem.index == 2) {
                message = @"请选择手持身份证照片";
            }
            [MBProgressHUD wg_message:message];
            return;
        }
//        WGLog(@"title:%@ -- url:%@",photoItem.title, photoItem.imageUrl);
    }
    
    NSString *url = @"/linggb-ws/ws/0.1/person/commitIdentity";
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = @{@"personalName":item1.text_right, @"identityCard":item2.text_right};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.responseJSON) {
            NSString *content = response.responseJSON[@"content"];
            if (content) {
                [MBProgressHUD  wg_message:content];
            }
            [self performSelector:@selector(wg_pop) withObject:nil afterDelay:0.2];
//            [self wg_pop];
        }
    }];
}
@end
