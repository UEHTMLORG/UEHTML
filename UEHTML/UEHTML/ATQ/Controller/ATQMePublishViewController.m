//
//  ATQMePublishViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/16.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMePublishViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Masonry.h"
#import "ATQMePublishFTableViewCell.h"
#import "ATQMePublishPTableViewCell.h"
#import "ATQMepublishTTableViewCell.h"
#import "UIColor+LhkhColor.h"
#import "KZPhotoManager.h"
@interface ATQMePublishViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,MPMediaPickerControllerDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    float height;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ATQMePublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(publish)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;
    height = 90;
    NSLog(@"----%@",self.typeStr);
    [self setTableView];
}

-(void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)publish{
    NSLog(@"发表");
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        [tableView registerNib:[UINib nibWithNibName:@"ATQMePublishFTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMePublishFTableViewCell"];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQMePublishPTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMePublishPTableViewCell"];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQMepublishTTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMepublishTTableViewCell"];
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //    [self.tableView.mj_header beginRefreshing];
//    self.tableView.mj_footer = [self loadMoreDataFooterWith:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(0);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
        return 3;
    }else{
        return 4;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
        if (section == 2) {
            return 2;
        }else{
            return 1;
        }
        
    }else{
        if (section == 3) {
            return 2;
        }else{
            return 1;
        }
        
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakself = self;
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
        if (indexPath.section == 0) {
            static NSString *CellIdentifier = @"ATQMePublishFTableViewCell" ;
            ATQMePublishFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            static NSString *CellIdentifier = @"ATQMepublishTTableViewCell" ;
            ATQMepublishTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            if (indexPath.section == 1) {
                cell.typeImg.image = [UIImage imageNamed:@"aotuquan-dingwei"];
                cell.typeTitleLab.text = @"所在位置";
                cell.subLab.hidden = YES;
            }else{
                if (indexPath.row == 0) {
                    cell.typeImg.image = [UIImage imageNamed:@"aotuquan-kejian"];
                    cell.typeTitleLab.text = @"谁可以看";
                    cell.subLab.hidden = NO;
                }else{
                    cell.typeImg.image = [UIImage imageNamed:@"aotuquan-"];
                    cell.typeTitleLab.text = @"提醒谁看";
                    cell.subLab.hidden = YES;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
    
        if (indexPath.section == 0) {
            static NSString *CellIdentifier = @"ATQMePublishFTableViewCell" ;
            ATQMePublishFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.section == 1){
            static NSString *CellIdentifier = @"ATQMePublishPTableViewCell" ;
            ATQMePublishPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.xuanZeTuPianBlock = ^(){//选择图片
                [KZPhotoManager getImage:^(UIImage *image) {
                    ATQMePublishPTableViewCell *cell  =[weakself.tableView cellForRowAtIndexPath:indexPath];
                    [cell.imgsArray insertObject:image atIndex:0];
                    [cell.publishCollectionView reloadData];
                    CGFloat width = (ScreenWidth - 50)/4;
                    NSLog(@"+++++%ld",cell.imgsArray.count);
                    if (cell.imgsArray.count >0 && cell.imgsArray.count <= 4) {
                        height = 90;
                    }else if (cell.imgsArray.count >4 && cell.imgsArray.count <= 8){
                        height = 90 + width + 20;
                    }else{
                        height = 90 + 2*width + 30;
                    }
                    [weakself.tableView reloadData];
                } showIn:weakself AndActionTitle:@"请选择照片"];
            };
            return cell;
            
        }else {
            static NSString *CellIdentifier = @"ATQMepublishTTableViewCell" ;
            ATQMepublishTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            if (indexPath.section == 2) {
                cell.typeImg.image = [UIImage imageNamed:@"aotuquan-dingwei"];
                cell.typeTitleLab.text = @"所在位置";
                cell.subLab.hidden = YES;
            }else{
                if (indexPath.row == 0) {
                    cell.typeImg.image = [UIImage imageNamed:@"aotuquan-kejian"];
                    cell.typeTitleLab.text = @"谁可以看";
                    cell.subLab.hidden = NO;
                }else{
                    cell.typeImg.image = [UIImage imageNamed:@"aotuquan-"];
                    cell.typeTitleLab.text = @"提醒谁看";
                    cell.subLab.hidden = YES;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else if(indexPath.section == 1){
        if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
            return 44;
        }else{
            return height;
        }
        
    }else{
        return 44;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
        if (section == 1) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
            view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
            return view;
        }else if(section == 2){
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
            view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
            return view;
        }else{
            return nil;
        }
    }else{
        if (section == 2) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
            view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
            return view;
        }else if(section == 3){
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
            view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
            return view;
        }else{
            return nil;
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
        if (section == 1) {
            return 1;
        }else if(section == 2){
            return 30;
        }else{
            return 0;
        }
    }else{
        if (section == 2) {
            return 1;
        }else if(section == 3){
            return 30;
        }else{
            return 0;
        }
    }
    
}


#pragma UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger sourcetype = 0;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 2:
                return;
                break;
            case 1:
                sourcetype = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 0:
                sourcetype = UIImagePickerControllerSourceTypeCamera;
                break;
            default:
                break;
        }
    }else{
        if (buttonIndex == 2) {
            return;
        }else{
            sourcetype = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    UIImagePickerController *imggePickerVc = [[UIImagePickerController alloc]init];
    imggePickerVc.delegate = self;
    //    imggePickerVc.allowsEditing = YES;
    imggePickerVc.sourceType = sourcetype;
    imggePickerVc.mediaTypes = @[(NSString *)kUTTypeMovie];
    [self presentViewController:imggePickerVc animated:NO completion:nil];
}

#pragma UIImagePickerController delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.movie"])
    {
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"found a video");
        
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:videoURL options:NSDataReadingUncached error:&error];
        if (!error) {
            
            double size = (long)data.length / 1024. / 1024.;
            //
            //            self.vediolb.text = [NSString stringWithFormat:@"%.2fMB", size];
            if (size > 30.0) {
                
                //文件过大
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"视频文件不得大于30M" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancle];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                
                //保存数据
                //获取视频的thumbnail
                MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:videoURL] ;
                UIImage  *thumbnail = [player thumbnailImageAtTime:0.01 timeOption:MPMovieTimeOptionNearestKeyFrame];
                player = nil;
            }
        }
        
    }
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
