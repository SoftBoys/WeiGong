//
//  WGBasicInfoViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoViewController.h"
#import "WGBasicInfoViewController+More.h"
#import "UIViewController+ImagePicker.h"
#import "WG_BaseNavViewController.h"
#import "WGWorkExperienceViewController.h"

#import "WGBasicInfoFootView.h"

#import "WGBasicInfo.h"
#import "WGBasicInfoCellItem.h"

#import "WGBasicInfoBaseCell.h"
#import "WGBasicInfoPhotoCell.h"
#import "WGBasicInfoNameCell.h"
#import "WGBasicInfoSexCell.h"
#import "WGBasicInfoIdentifyCell.h"

#import "WGBasicInfoExperienceCell.h"
#import "WGBasicInfoAddressCell.h"
#import "WGBasicInfoEducationCell.h"
#import "WGBasicInfoDriveCell.h"
#import "WGBasicInfoMoreCell.h"
#import "WGBasicInfoDescCell.h"

#import "WGActionSheet.h"
#import <MWPhotoBrowser.h>
#import "WGDataTypeItem.h"
#import "WG_TypeTool.h"
#import "WGDataBaseTool.h"
#import "WG_CityItem.h"

#import "WGBasixInfoSaveParam.h"
#import "WG_UserDefaults.h"
#import "WGRequestManager.h"

#import "PickerDateView.h"
#import "WGPickerCityView.h"

@interface WGBasicInfoViewController () <WGBasicInfoPhotoCellDelegate, MWPhotoBrowserDelegate, WGBasicInfoSexCellDelegate, WGBasicInfoIdentifyCellDelegate, WGBasicInfoMoreCellDelegate, WGBasicInfoEducationCellDelegate, WGBasicInfoAddressCellDelegate>
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) WGBasicInfoFootView *footView;
@property (nonatomic, strong) WGBasicInfo *info;

@property (nonatomic, copy) NSArray *photos;
@end

@implementation WGBasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本信息";
    
}

- (void)wg_loadData {
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:self.requestUrl];
    
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            WGBasicInfo *info = [WGBasicInfo wg_modelWithDictionry:response.responseJSON];
            self.info = info;
            
            NSArray *locationList = [WGDataBaseTool getObjectById:kCityListKey];
            NSArray <WG_CityItem *> *list = [WG_CityItem wg_modelArrayWithDictArray:locationList];
            for (WG_CityItem *cityItem in list) {
                if (cityItem.cityCode == info.parentLocationId) {
                    self.cityItem = cityItem;
                    break;
                }
            }
            
            self.moreCellIsOn = NO;
            self.dataArray = [self getCellItemsWithInfo:self.info moreCellIsOn:self.moreCellIsOn];
            [self.tableView wg_reloadData];
            self.tableView.tableFooterView = self.footView;
        }
    }];
    
}
#pragma mark - 代理方法
- (NSInteger)wg_numberOfSections {
    return self.dataArray.count;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    NSArray *itemList = self.dataArray[section];
    return [itemList count];
}
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGBasicInfoCellItem *cellItem = self.dataArray[indexPath.section][indexPath.row];
    if (cellItem.cellType == 0) {
        WGBasicInfoPhotoCell *cell = [WGBasicInfoPhotoCell wg_cellWithTableView:self.tableView];
        cell.cellItem = cellItem;
        cell.delegate = self;
        return cell;
    } else if (cellItem.cellType == 1 ||cellItem.cellType == 5||cellItem.cellType == 6|| cellItem.cellType == 12||cellItem.cellType == 13||cellItem.cellType == 14) {
        WGBasicInfoNameCell *cell = [WGBasicInfoNameCell wg_cellWithTableView:self.tableView];
        cell.cellItem = cellItem;
        return cell;
    } else if (cellItem.cellType == 2 || cellItem.cellType == 3) {
        WGBasicInfoSexCell *cell = [WGBasicInfoSexCell wg_cellWithTableView:self.tableView];
        cell.cellItem = cellItem;
        cell.delegate = self;
        return cell;
    } else if (cellItem.cellType == 4) {
        WGBasicInfoIdentifyCell *cell = [WGBasicInfoIdentifyCell wg_cellWithTableView:self.tableView];
        cell.cellItem = cellItem;
        cell.delegate = self;
        return cell;
    } else if (cellItem.cellType == 7) {
        WGBasicInfoExperienceCell *cell = [WGBasicInfoExperienceCell wg_cellWithTableView:self.tableView];
        cell.cellItem = cellItem;
        return cell;
    } else if (cellItem.cellType == 8) {
        WGBasicInfoAddressCell *cell = [WGBasicInfoAddressCell wg_cellWithTableView:self.tableView];
        cell.cellItem = cellItem;
        cell.delegate = self;
        return cell;
    } else if (cellItem.cellType == 9) {
        WGBasicInfoEducationCell *cell = [WGBasicInfoEducationCell wg_cellWithTableView:self.tableView];
        cell.cellItem = cellItem;
        cell.delegate = self;
        return cell;
    } else if (cellItem.cellType == 10) {
        WGBasicInfoDriveCell *cell = [WGBasicInfoDriveCell wg_cellWithTableView:self.tableView];
        cell.cellItem = cellItem;
        return cell;
    } else if (cellItem.cellType == 11) {
        WGBasicInfoMoreCell *cell = [WGBasicInfoMoreCell wg_cellWithTableView:self.tableView];
        cell.cellItem = cellItem;
        cell.delegate = self;
        return cell;
    } else if (cellItem.cellType == 15) {
        WGBasicInfoDescCell *cell = [WGBasicInfoDescCell wg_cellWithTableView:self.tableView];
        cell.cellItem = cellItem;
        return cell;
    }
    
    WGBasicInfoBaseCell *cell = [WGBasicInfoBaseCell wg_cellWithTableView:self.tableView];
    cell.cellItem = cellItem;
    return cell;
    
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 12;
}

- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WGBasicInfoCellItem *cellItem = self.dataArray[indexPath.section][indexPath.row];
    if (cellItem.cellType == 7) {
        __weak typeof(self) weakself = self;
        WGWorkExperienceViewController *workVC = [WGWorkExperienceViewController instanceWithCallBackHandle:^(NSArray<WGWorkExperienceItem *> *items, NSString *markNameList) {
            __strong typeof(weakself) strongself = weakself;
            [strongself wg_popToVC:strongself];
            cellItem.name_content = markNameList;
            strongself.info.personalMarkStr = markNameList;
            [strongself.tableView wg_reloadData];
            
        }];
        [self wg_pushVC:workVC];
    }
}

#pragma mark - WGBasicInfoPhotoCellDelegate
- (void)wg_deletePicLifeWithItem:(WGBasicInfoPhotoItem *)item {
    [self.view endEditing:YES];
    if (item) {
        [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
            if (index) {
                [self deleteItem:item];
            }
        } cancel:@"取消" others:@[@"删除"]];
    }
    
}
- (void)deleteItem:(WGBasicInfoPhotoItem *)item {
    
    NSDictionary *param = @{@"sysPicId":@(item.lifePicId)};
    NSString *url = @"/linggb-ws/ws/0.1/person/deletePersonLifePhotos";
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = param;
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
                NSString *message = response.responseJSON[@"content"];
                [MBProgressHUD wg_message:message];
            }
            [self wg_loadData];
        }
    }];
    
}
- (void)wg_addPicLife {
    [self.view endEditing:YES];
    NSMutableArray *others = @[@"相册"].mutableCopy;
    if ([UIDevice wg_hasCamera]) {
        [others wg_insertObject:@"拍照" atIndex:0];
    }
    [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
        if (index) {
            if (index == others.count) { // 相册
                if ([UIDevice wg_isAccessPhoto]) {
                    [self pickerWithType:WGImagePickerPhoto];
                } else {
                    [UIDevice wg_showPhotoAlert];
                }
            } else {
                if ([UIDevice wg_isAccessCamera]) {
                    [self pickerWithType:WGImagePickerCamera];
                } else {
                    [UIDevice wg_showCameraAlert];
                }
            }
        }
    } cancel:@"取消" others:others];
    
}
- (void)pickerWithType:(WGImagePickerSourceType)type {
    [self wg_presentImagePickerWithSourceType:type allowEditing:YES completionHandle:^(UIImage *image, NSDictionary *editingInfo) {
//        UIImage *image = [editingInfo objectForKey:UIImagePickerControllerEditedImage];
        
        [MBProgressHUD wg_showHub_CanTap];
        UIImage *newImage = [image wg_resizedImageWithNewSize:CGSizeMake(800, 800)];
        NSString *url = @"/linggb-ws/ws/0.1/file/uploadLifePhotosClient";
        WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
        request.wg_imageArray = @[newImage];
        
        [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
            [MBProgressHUD wg_hideHub];
            if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
                NSString *message = response.responseJSON[@"content"];
                [MBProgressHUD wg_message:message];
            }
            if (response.statusCode == 200) {
                [self wg_loadData];
            }
        }];
        
    }];
}

- (void)wg_clickPicLifeWithItem:(WGBasicInfoPhotoItem *)item {
    
    [self.view endEditing:YES];
    
    __block NSInteger index = 0;
    NSMutableArray<MWPhoto *> *photoList = @[].mutableCopy;
    [self.info.lifePics enumerateObjectsUsingBlock:^(WGBasicInfoPhotoItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *url = obj.picUrlB;
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:url]];
        if (obj.lifePicId == item.lifePicId) {
            index = idx;
        }
        [photoList addObject:photo];
    }];
    self.photos = photoList;
    [self showPhotosWithIndex:index];
}
- (void)showPhotosWithIndex:(NSInteger)index {
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.enableSwipeToDismiss = NO;
    
    // Customise selection images to change colours if required
    //    browser.customImageSelectedIconName = @"ImageSelected.png";
    //    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:index];
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    WG_BaseNavViewController *nav = [[WG_BaseNavViewController alloc] initWithRootViewController:browser];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self wg_presentVC:nav];
    
}
#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self wg_dismiss];
}

#pragma mark - WGBasicInfoSexCellDelegate
- (void)actionSheetWithItem:(WGBasicInfoCellItem *)item {
    [self.view endEditing:YES];
    if (item.cellType == 2) { // 性别
        NSArray *others = @[@"男", @"女"];
        NSMutableArray *sexItems = @[].mutableCopy;
        for (NSInteger i = 0; i < others.count; i++) {
            WGBasicInfoSexItem *item = [WGBasicInfoSexItem new];
            item.sexCode = i+1;
            item.name = others[i];
            [sexItems wg_addObject:item];
        }
        
        
        [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
            if (index) {
                if (index <= others.count) {
//                    item.sexItem.name = others[index-1];
                    item.sexItem = sexItems[index-1];
                    item.info.sex = item.sexItem.sexCode;
                    [self.tableView wg_reloadData];
                }
            }
        } cancel:@"取消" others:others];
    } else if (item.cellType == 3) { // 出生日期
        
        PickerDateItem *dateItem = [[PickerDateItem alloc] init];
        dateItem.currentDate = item.birthItem.date;
        
        PickerDateView *picker = [PickerDateView showPickerWithcurrentItem:dateItem];
        picker.sureBlock = ^(PickerDateItem *dateItem) {
            
            WGBasicInfoBirthItem *birthItem = [[WGBasicInfoBirthItem alloc] init];
            birthItem.date = dateItem.currentDate;
            birthItem.dateStr = [birthItem.date wg_stringWithDateFormat:@"yyyy-MM-dd"];
            item.birthItem = birthItem;
            item.info.birthday = birthItem.dateStr;
            
            [self.tableView reloadData];
        };
        
    }
    
}
#pragma mark - WGBasicInfoIdentifyCellDelegate
- (void)modifyIdentifyWithCellItem:(WGBasicInfoCellItem *)cellItem {
    // 修改 identFlag
    NSInteger identFlag = (cellItem.identFlag == 1) ? 2:1;
//    cellItem.identFlag = identFlag;
    self.info.identFlag = kIntToStr(identFlag);
    self.dataArray = [self getCellItemsWithInfo:self.info moreCellIsOn:self.moreCellIsOn];

    [self.tableView wg_reloadData];
}
#pragma mark - WGBasicInfoAddressCellDelegate
- (void)modifyaddressItemWithCellItem:(WGBasicInfoCellItem *)cellItem {
    [self.view endEditing:YES];
    
    WGPickerCityItem *currentItem = nil;
    
    NSMutableArray *cityItemList = @[].mutableCopy;
    NSArray *dataList = [WGDataBaseTool getObjectById:kCityListKey];
    
    for (NSDictionary *dict in dataList) {
        WGPickerCityItem *cityItem = [WGPickerCityItem wg_modelWithDictionry:dict];
        if (cityItem.cityCode == self.info.parentLocationId) {
            currentItem = cityItem;
        }
        [cityItemList wg_addObject:cityItem];
    }
    __block NSInteger index = 0;
    if (currentItem) {
        [currentItem.subItems enumerateObjectsUsingBlock:^(WGPickerCityItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.cityCode == self.info.locationCodeId) {
                index = idx;
            }
        }];
        currentItem.index_sel = index;
    }
    [WGPickerCityView pickerWithCityItems:cityItemList currentCityItem:currentItem completionHandle:^(WGPickerCityItem *item) {
        if (item) {
            WGPickerCityItem *subcityItem = item.subItems[item.index_sel];
            cellItem.subcityItem = subcityItem;
            self.info.locationCodeId = subcityItem.cityCode;
            [self.tableView wg_reloadData];
        }
    }];
    
    return;
    
    
    NSArray<WG_CityItem *> *subcityItems = self.cityItem.subItems;
    
    NSMutableArray *others = @[].mutableCopy;
    NSInteger count = subcityItems.count;
    for (NSInteger i = 0; i < count; i++) {
        WG_CityItem *subcityItem = subcityItems[i];
        NSString *title = subcityItem.city;
        [others addObject:title];
    }
    
    
    WGActionSheet *sheet = [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
        if (index) {
            if (index) { // 相册
                if (index-1 < subcityItems.count) {
                    WG_CityItem *subcityItem = subcityItems[index-1];
                    cellItem.subcityItem = subcityItem;
                    self.info.locationCodeId = subcityItem.cityCode;
                    [self.tableView wg_reloadData];
                }
                
            }
        }
    } cancel:@"取消" others:others];
    sheet.canScroll = YES;
    sheet.maxHeight = 220;
    
}
#pragma mark - WGBasicInfoEducationCellDelegate
- (void)modifyHeightWithCellItem:(WGBasicInfoCellItem *)cellItem {
    [self.view endEditing:YES];
    
    NSMutableArray *others = @[].mutableCopy;
    NSInteger begin = 150;
    NSInteger space = 1;
    NSInteger count = 50;
    for (NSInteger i = 0; i <= count; i++) {
        NSString *title = kIntToStr(begin + i*space);
        [others addObject:title];
    }
    
    WGActionSheet *sheet = [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
        if (index) {
            if (index) { // 相册
                if (index-1 < others.count) {
                    NSString *title = others[index-1];
                    cellItem.height = [title integerValue];
                    self.info.height = cellItem.height;
                    [self.tableView wg_reloadData];
                }
                
            }
        }
    } cancel:@"取消" others:others];
    sheet.canScroll = YES;
    sheet.maxHeight = 220;
    
}
- (void)modifyWeightWithCellItem:(WGBasicInfoCellItem *)cellItem {
    [self.view endEditing:YES];
    
    NSMutableArray *others = @[].mutableCopy;
    NSInteger begin = 40;
    NSInteger space = 1;
    NSInteger count = 50;
    for (NSInteger i = 0; i <= count; i++) {
        NSString *title = kIntToStr(begin + i*space);
        [others addObject:title];
    }
    
    WGActionSheet *sheet = [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
        if (index) {
            if (index) { // 相册
                if (index-1 < others.count) {
                    NSString *title = others[index-1];
                    cellItem.weight = [title integerValue];
                    self.info.weight = cellItem.weight;
                    [self.tableView wg_reloadData];
                }
                
            }
        }
    } cancel:@"取消" others:others];
    sheet.canScroll = YES;
    sheet.maxHeight = 220;
    
}
- (void)modifyEducationWithCellItem:(WGBasicInfoCellItem *)cellItem {
    [self.view endEditing:YES];
    
    NSArray *educationItems = [WG_TypeTool wg_typeEducationPositionList];
    
    NSMutableArray *others = @[].mutableCopy;
    NSInteger count = educationItems.count;
    for (NSInteger i = 0; i < count; i++) {
        WGDataTypeItem *educationItem = educationItems[i];
        NSString *title = educationItem.name;
        [others addObject:title];
    }
    
    WGActionSheet *sheet = [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
        if (index) {
            if (index) { // 相册
                if (index-1 < educationItems.count) {
                    WGDataTypeItem *educationItem = educationItems[index-1];
                    cellItem.educationItem = educationItem;
                    self.info.degree = educationItem.code;
                    self.info.degreeName = educationItem.name;
                    [self.tableView wg_reloadData];
                }
                
            }
        }
    } cancel:@"取消" others:others];
    sheet.canScroll = YES;
    sheet.maxHeight = 220;
    
}
#pragma mark - WGBasicInfoMoreCellDelegate
- (void)modifyMoreCellStatuWithItem:(WGBasicInfoCellItem *)cellItem {
    self.moreCellIsOn = !cellItem.moreCellIsOn;
    self.dataArray = [self getCellItemsWithInfo:self.info moreCellIsOn:self.moreCellIsOn];
    
    [self.tableView wg_reloadData];
}
#pragma mark - private
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/getPersonBasicInfo";
}

- (WGBasicInfoFootView *)footView {
    if (!_footView) {
        __weak typeof(self) weakself = self;
        _footView = [WGBasicInfoFootView footViewWithHandle:^{
            __strong typeof(weakself) strongself = weakself;
            [strongself saveData];
        }];
        _footView.wg_height = 80;
    }
    return _footView;
}
#pragma mark - 保存
- (void)saveData {
    
    WGBasixInfoSaveParam *param = [WGBasixInfoSaveParam new];
    for (NSArray *sections in self.dataArray) {
        for (WGBasicInfoCellItem *cellItem in sections) {
            if (cellItem.cellType == 1) {
                param.personName = cellItem.name_content;
                if (!param.personName.length) {
                    [MBProgressHUD wg_message:@"请填写姓名"];
                    return;
                }
            } else if (cellItem.cellType == 2) {
                param.sex = cellItem.sexItem.sexCode;
                if (param.sex == 0) {
                    [MBProgressHUD wg_message:@"请选择性别"];
                    return;
                }
            } else if (cellItem.cellType == 3) {
                param.birthday = cellItem.birthItem.dateStr;
                if (!param.birthday.length) {
                    [MBProgressHUD wg_message:@"请选择出生日期"];
                    return;
                }
            } else if (cellItem.cellType == 4) {
                param.identFlag = [self.info.identFlag integerValue];
                if (param.identFlag == 0) {
                    [MBProgressHUD wg_message:@"请选择个人身份"];
                    return;
                }
            } else if (cellItem.cellType == 5) {
                param.school = cellItem.name_content;
                if (param.school.length == 0) {
                    [MBProgressHUD wg_message:@"请填写学校"];
                    return;
                }
            } else if (cellItem.cellType == 6) {
                param.profession = cellItem.name_content;
                if (param.profession.length == 0) {
                    [MBProgressHUD wg_message:@"请填写专业"];
                    return;
                }
            } else if (cellItem.cellType == 7) {
                param.personalMarkStr = cellItem.name_content;
                if (param.personalMarkStr.length == 0) {
                    [MBProgressHUD wg_message:@"请选择工作经验"];
                    return;
                }
            } else if (cellItem.cellType == 8) {
                param.cityCode = cellItem.subcityItem.cityCode;
                param.cityName = cellItem.subcityItem.city;
                param.address = cellItem.name_content;
                if (param.cityCode == 0) {
                    [MBProgressHUD wg_message:@"请选择工作区域"];
                    return;
                }
            } else if (cellItem.cellType == 9) {
                if (cellItem.height > 0) {
                    param.height = @(cellItem.height);
                }
                if (cellItem.weight > 0) {
                    param.weight = @(cellItem.weight);
                }
                if (cellItem.educationItem) {
                    param.degreeId = @(cellItem.educationItem.code);
                }
            } else if (cellItem.cellType == 10) {
                param.healthCard = cellItem.healthCard;
                param.driveLicense = cellItem.driveLicense;
            } else if (cellItem.cellType == 11) {
//                param.healthCard = cellItem.healthCard;
//                param.driveLicense = cellItem.driveLicense;
            } else if (cellItem.cellType == 12) {
                param.mobile = cellItem.name_content;
            } else if (cellItem.cellType == 13) {
                param.wechatNo = cellItem.name_content;
            } else if (cellItem.cellType == 14) {
                param.qqNo = cellItem.name_content;
            } else if (cellItem.cellType == 15) {
                param.resume = cellItem.name_content;
            }
        }
    }
    
    if (!self.moreCellIsOn) {
        param.mobile = self.info.mobile;
        param.wechatNo = self.info.wechatNo;
        param.qqNo = self.info.qqNo;
        param.resume = self.info.resume;
    }
    
    
    WGLog(@"-------Begin---------");
    WGLog(@"param:%@", [param wg_keyValues]);
    WGLog(@"-------End---------");

//    return;
    [self wg_saveDataWithParam:param];
    
}
- (void)wg_saveDataWithParam:(WGBasixInfoSaveParam *)param {
    
    NSString *url = [self saveUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = [param wg_keyValues];
    [MBProgressHUD wg_showHub_CanTap];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        [MBProgressHUD wg_hideHub];
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *message = response.responseJSON[@"content"];
            [MBProgressHUD wg_message:message];
        }
        if (response.statusCode == 200) {
            [WG_UserDefaults shareInstance].userName = param.personName;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self wg_pop];
            });
        }
    }];
    
}
- (NSString *)saveUrl {
    return @"/linggb-ws/ws/0.1/person/updatePersonalBasic";
}
- (void)dealloc {
    
    [WGRequestManager cancelTaskWithUrl:[self saveUrl]];
}
@end
