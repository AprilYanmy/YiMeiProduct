//
//  DAUserCenterVC.m
//  Divination
//
//  Created by iMac-1 on 2018/3/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DAStarSMUserCenterVC.h"
#import "DateTimePickerView.h"
#import "ZHPickView.h"
#import "DAStarAWMineEmailVC.h"
#import "Solar.h"
#import "Lunar.h"
#import "CalendarDisplyManager.h"
//#import "DCHomeChooseStarVC.h"

#import "ZLPhotoActionSheet.h"

@interface DAStarSMUserCenterVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate,DateTimePickerViewDelegate,ZHPickViewDelegate>
{
    UIImagePickerController *imagePicker;
    NSString *_brithdayStr;
    NSArray *imageArr;
}
@property (weak, nonatomic) IBOutlet UIImageView *img_userHeader;

@property (weak, nonatomic) IBOutlet UILabel *lab_nickname;
@property (weak, nonatomic) IBOutlet UILabel *lab_brithDay;
@property (weak, nonatomic) IBOutlet UILabel *lab_sex;
@property (weak, nonatomic) IBOutlet UILabel *lab_work;
@property (weak, nonatomic) IBOutlet UILabel *lab_marriage;
@property (weak, nonatomic) IBOutlet UILabel *lab_email;
@property (weak, nonatomic) IBOutlet UILabel *lab_starName;

@end

@implementation DAStarSMUserCenterVC

- (void)loadData{
    
    self.lab_nickname.text = [DANewUserInfo sharedInstance].nickName;
    self.lab_marriage.text = [DANewUserInfo sharedInstance].maritalStatus;
    self.lab_work.text = [DANewUserInfo sharedInstance].workInfo;
   
    NSArray *brithdayArr = [[DANewUserInfo sharedInstance].birthday componentsSeparatedByString:@"/"];
    if (brithdayArr.count == 3) {
        self.lab_brithDay.text = [NSString stringWithFormat:@"%@年%@月%@日",brithdayArr[0],brithdayArr[1],brithdayArr[2]];
    }
    
    self.lab_sex.text = [DANewUserInfo sharedInstance].sex;
    self.lab_email.text = [DANewUserInfo sharedInstance].email;
    _brithdayStr = [DANewUserInfo sharedInstance].birthday;
    [self.img_userHeader sd_setImageWithURL:[NSURL URLWithString:[DANewUserInfo sharedInstance].user_headerUrl] placeholderImage:[UIImage imageNamed:@"no_login"]];
    
//    NSString *starName = [DAStarLHMyTool setObtainObject:Star_ChooseName];
    
//    if ([NSString isInputNil:starName]) {
//        self.lab_starName.text = @"请点击选择";
//    }else{
//        self.lab_starName.text = starName;
//    }

    imageArr = @[@"水瓶座",
                 @"双鱼座",
                 @"白羊座",
                 @"金牛座",
                 @"双子座",
                 @"巨蟹座",
                 @"狮子座",
                 @"处女座",
                 @"天秤座",
                 @"天蝎座",
                 @"射手座",
                 @"摩羯座"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"用户资料";
    [self loadData];
}

/**
 选择生日
 */
- (IBAction)chooseTimeClick:(UIButton *)sender {
    
    DateTimePickerView *pickerView = [DateTimePickerView creatView];
    pickerView.delegate = self;
    pickerView.pickerViewMode = DatePickerViewDateMode;
    [self.view addSubview:pickerView];
    [pickerView showDateTimePickerView];
    
}

#pragma mark ---  性别选择
- (IBAction)chooseSexClick:(UIButton *)sender {
    
    NSArray *array = @[@"男",@"女"];
    ZHPickView *_pickview = [[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    _pickview.tag = 100;
    [_pickview setToolbarTintColor:[UIColor whiteColor]];
    _pickview.delegate = self;
    [_pickview show];
}

#pragma mark ——————————————————————  星座选择
- (IBAction)chooseStarClick:(UIButton *)sender {
    
//    DCHomeChooseStarVC *vc = [DCHomeChooseStarVC new];
//    [vc setBlock:^(NSString *code) {
//
//        self.lab_starName.text = self->imageArr[[code integerValue]-401];
//
//    }];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self presentViewController:vc animated:YES completion:nil];
    
}


#pragma mark ---  工作选择
- (IBAction)chooseProfessionClick:(UIButton *)sender {
    
    NSArray *array = @[@"上班族",@"自由职业",@"学生",@"个体户",@"其他"];
    ZHPickView *_pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    _pickview.tag = 101;
    [_pickview setToolbarTintColor:[UIColor whiteColor]];
    _pickview.delegate = self;
    [_pickview show];
}

#pragma mark ---  婚姻选择
- (IBAction)chooseMarriageClick:(UIButton *)sender {
    
    NSArray *array = @[@"已婚",@"未婚",@"离异"];
    ZHPickView *_pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    _pickview.tag = 102;
    [_pickview setToolbarTintColor:[UIColor whiteColor]];
    _pickview.delegate = self;
    [_pickview show];
}

- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    switch (pickView.tag-100) {
        case 0:
            self.lab_sex.text = resultString;
            break;
        case 1:
            self.lab_work.text = resultString;
            break;
        case 2:
            self.lab_marriage.text = resultString;
            break;
        default:
            break;
    }
    
}

#pragma mark ---  邮箱认证
- (IBAction)chooseEmailClick:(UIButton *)sender {
    
    WS(weakSelf);
    DAStarAWMineEmailVC *vc = [[DAStarAWMineEmailVC alloc] init];
    [vc setContentBack:^(NSString *content, NSInteger type) {
        weakSelf.lab_email.text = content;
    }];
    [self aw___pushViewController:vc];
    
}

#pragma mark ---  昵称
- (IBAction)chooseNickNameClick:(UIButton *)sender {
    
    WS(weakSelf);
    DAStarAWMineEmailVC *vc = [[DAStarAWMineEmailVC alloc] init];
    vc.type = 1;
    [vc setContentBack:^(NSString *content, NSInteger type) {
        weakSelf.lab_nickname.text = content;
    }];
    [self aw___pushViewController:vc];
    
}

#pragma mark - delegate   生日代理返回事件
- (void)aw____dateTimePickerView:(DateTimePickerView *)pirckerView didClickFinishDateTimePickerView:(NSString *)date{
    
    NSArray *showCurrentArrs = [[NSString getHomeTimes] componentsSeparatedByString:@"."];

    NSArray *showArrs = [date componentsSeparatedByString:@"-"];
    
    NSString *nowStr = [[NSString getHomeTimes] stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *chooseStr = [date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    
    if ([chooseStr integerValue] >= [nowStr integerValue]) {
        self.lab_brithDay.text = [NSString stringWithFormat:@"%@年%@月%@日",showCurrentArrs[0],showCurrentArrs[1],showCurrentArrs[2]];
        _brithdayStr = [NSString stringWithFormat:@"%@/%@/%@",showCurrentArrs[0],showCurrentArrs[1],showCurrentArrs[2]];
    }else{
        _brithdayStr = [NSString stringWithFormat:@"%@/%@/%@",showArrs[0],showArrs[1],showArrs[2]];
        self.lab_brithDay.text = [NSString stringWithFormat:@"%@年%@月%@日",showArrs[0],showArrs[1],showArrs[2]];
    }
    
    
}

#pragma mark --- 更换头像
- (IBAction)changHeader:(UIButton *)sender {
    
//    if ([[UIDevice currentDevice].systemVersion doubleValue] <= 10.0) {
//        return;
//    }
//
//    __weak __typeof__(self)weakSelf = self;
//
//
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
//
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册选择"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
//        [weakSelf album];
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
//        [weakSelf takePhoto];
//    }]];

//    [self presentViewController:alertController animated:YES completion:nil];
    
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
    
    ac.configuration.navBarColor = ColorMainBG;
    //如调用的方法无sender参数，则该参数必传
    ac.sender = self;
    
    //相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
    ac.configuration.maxSelectCount = 1;
    ac.configuration.maxPreviewCount = 10;
    
    //选择回调
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        //your codes
        if (images.count>0) {
            [self commitUserHeader:images[0]];
        }
    }];
    
    //调用相册
    [ac showPreviewAnimated:YES];
    
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)commitUserHeader:(UIImage *)headerImge{
    NSData *image = UIImageJPEGRepresentation(headerImge, 0.75f);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[DANewUserInfo sharedInstance].userID forKey:@"id"];
    
    [SVProgressHUD showWithStatus:@"上传中..."];
    [DataRequest filesPost:[URLRequest url_uploadAppFile] parametes:dic files:image success:^(id responObject) {
        NSDictionary *data = [responObject objectForKey:@"data"];
        
        NSString *img = [data objectForKey:@"fileId"];
        
        self.img_userHeader.image = headerImge;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[DANewUserInfo sharedInstance].userID forKey:@"id"];
        [dic setObject:img forKey:@"headPortrait"];
        
        [DataRequest Post:[URLRequest url_saveUserInfo] parametes:dic success:^(id responObject) {
            
            [SVProgressHUD dismiss];
        } failure:^(id responObject) {
            
        } error:^(id error) {
            
        }];
        
    } failure:^(id responObject) {
        
    } error:^(id error) {
        
    }];
    
}


#pragma mark -
#pragma mark  UIActionSheetdelegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self album];
        
    }else if (buttonIndex == 1){
        [self takePhoto];
    }
}

#pragma mark 拍照
- (void)takePhoto {
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imagePicker.allowsEditing = YES;
    //媒体类型,默认情况下此数组包含kUTTypeImage，所以拍照时可以不用设置；但是当要录像的时候必须设置，可以设置为kUTTypeVideo（视频，但不带声音）或者kUTTypeMovie（视频并带有声音）
    //    imagePicker.mediaTypes = @[(__bridge NSString *)kUTTypeMovie,(__bridge NSString *)kUTTypeImage];
    //视频最大录制时长(s)
    //    imagePicker.videoMaximumDuration = 15;
    [imagePicker topViewController].view.frame = CGRectMake(0, 0, 320, 300);
    [self presentViewController:imagePicker animated:YES completion:nil];
}



#pragma mark 从相册中选择
- (void)album {
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *_headerImge = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    

    
    NSData *image = UIImageJPEGRepresentation(_headerImge, 0.75f);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[DANewUserInfo sharedInstance].userID forKey:@"id"];
    
    [SVProgressHUD showWithStatus:@"上传中..."];
    
    [DataRequest filesPost:[URLRequest url_uploadAppFile] parametes:dic files:image success:^(id responObject) {
        NSDictionary *data = [responObject objectForKey:@"data"];
        
        NSString *img = [data objectForKey:@"fileId"];
        
        self.img_userHeader.image = _headerImge;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[DANewUserInfo sharedInstance].userID forKey:@"id"];
        [dic setObject:img forKey:@"headPortrait"];
        
        [DataRequest Post:[URLRequest url_saveUserInfo] parametes:dic success:^(id responObject) {
            
            [SVProgressHUD dismiss];
        } failure:^(id responObject) {
            
        } error:^(id error) {
            
        }];
        
    } failure:^(id responObject) {
        
    } error:^(id error) {
        
    }];
    
}

#pragma mark ---  确认提交
- (IBAction)commitActionClick:(UIButton *)sender {
    
    if ([_lab_nickname.text isEqualToString:@"设置昵称"]) {
        [SVProgressHUD showErrorWithStatus:@"请设置昵称"];
        return;
    }
    if (_lab_nickname.text.length > 6) {
        [SVProgressHUD showErrorWithStatus:@"请设置不多于11位昵称"];
        return;
    }
    if ([_lab_brithDay.text isEqualToString:@"请点击选择"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择生日"];
        return;
    }
    if ([_lab_sex.text isEqualToString:@"请点击选择"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择性别"];
        return;
    }
//    if ([_lab_work.text isEqualToString:@"请点击选择"]) {
//        [SVProgressHUD showErrorWithStatus:@"请选择工作"];
//        return;
//    }
//    if ([_lab_marriage.text isEqualToString:@"请点击婚姻"]) {
//        [SVProgressHUD showErrorWithStatus:@"请选择婚姻"];
//        return;
//    }
//    if ([_lab_email.text isEqualToString:@"请认证邮箱"]) {
//        [SVProgressHUD showErrorWithStatus:@"请认证邮箱"];
//        return;
//    }

    NSMutableDictionary *upLodateDic = [NSMutableDictionary dictionary];
    [upLodateDic setObject:[DANewUserInfo sharedInstance].userID forKey:@"id"];
    /*
    if ([self.lab_work.text isEqualToString:@"上班族"]) {
        [upLodateDic setObject:@"1" forKey:@"spouseSocialIdentity"];
    }else if ([self.lab_work.text isEqualToString:@"个体户"]){
        [upLodateDic setObject:@"2" forKey:@"spouseSocialIdentity"];
    }else if ([self.lab_work.text isEqualToString:@"企业主"]){
        [upLodateDic setObject:@"3" forKey:@"spouseSocialIdentity"];
    }else if ([self.lab_work.text isEqualToString:@"学生"]){
        [upLodateDic setObject:@"4" forKey:@"spouseSocialIdentity"];
    }else{
        [upLodateDic setObject:@"5" forKey:@"spouseSocialIdentity"];
    }
    
    if ([self.lab_marriage.text isEqualToString:@"已婚"]) {
        [upLodateDic setObject:@"1" forKey:@"maritalStatus"];
    }else if ([self.lab_marriage.text isEqualToString:@"未婚"]){
        [upLodateDic setObject:@"2" forKey:@"maritalStatus"];
    }else {
        [upLodateDic setObject:@"3" forKey:@"maritalStatus"];
    }
    
    if ([self.lab_sex.text isEqualToString:@"男"]) {
        [upLodateDic setObject:@"1" forKey:@"sex"];
    }else{
        [upLodateDic setObject:@"0" forKey:@"sex"];
    }
    
    [upLodateDic setObject:self.lab_nickname.text forKey:@"nickName"];
//    [upLodateDic setObject:self.lab_email.text forKey:@"sesameCredit"];
    [upLodateDic setObject:_brithdayStr forKey:@"birthdayRoma"];
    
    NSArray *dateArrs = [_brithdayStr componentsSeparatedByString:@"/"];
    
    Solar *s = [[Solar alloc]initWithYear:[dateArrs[0] intValue]
                                 andMonth:[dateArrs[1] intValue]
                                   andDay:[dateArrs[2] intValue]];
    //得出阴历
    Lunar *l = [CalendarDisplyManager obtainLunarFromSolar:s];
    
    NSString *chinaBrithday = [NSString stringWithFormat:@"%02d/%02d/%02d",l.lunarYear,l.lunarMonth,l.lunarDay];
    [upLodateDic setObject:chinaBrithday forKey:@"birthdayChina"];
     */
    sender.userInteractionEnabled = NO;
    [SVProgressHUD show];
    [DataRequest Post:[URLRequest url_perfectUser] parametes:upLodateDic success:^(id responObject) {
        [MyTool setAddObject:@"change" key:OldTime];
        [MyTool setAddObject:self.lab_starName.text key:Star_ChooseName];
        [self.navigationController popViewControllerAnimated:YES];
        sender.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
        
        [DANewUserInfo sharedInstance].nickName = self.lab_nickname.text;
        [DANewUserInfo sharedInstance].birthday = self->_brithdayStr;
        [DANewUserInfo sharedInstance].sex = self.lab_sex.text;
        [DANewUserInfo sharedInstance].maritalStatus = self.lab_marriage.text;
        [DANewUserInfo sharedInstance].workInfo = self.lab_work.text;
        [DANewUserInfo synchronize];

    } failure:^(id responObject) {
        sender.userInteractionEnabled = YES;
    } error:^(id error) {
        sender.userInteractionEnabled = YES;
    }];
    
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
