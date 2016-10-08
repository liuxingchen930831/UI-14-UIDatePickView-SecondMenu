//
//  ViewController.m
//  生日键盘
//
//  Created by liuxingchen on 16/10/8.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import "ViewController.h"
#import "CityModel.h"
@interface ViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *SRLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityLabel;
@property(nonatomic,strong)UIDatePicker * datePicker ;
/** dataSouce */
@property(nonatomic,strong)NSMutableArray  * citys ;
@property(nonatomic,strong)UIPickerView * pickerView ;
@end

@implementation ViewController
-(NSMutableArray *)citys
{
    if (_citys ==nil) {
        _citys = [NSMutableArray arrayWithCapacity:0];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"provinces.plist" ofType:nil];
        NSArray *cityArray = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in cityArray) {
            CityModel *city = [CityModel cityModelWithDict:dict];
            [_citys addObject:city];
        }
    }
    return _citys;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.SRLabel.delegate = self;
    self.cityLabel.delegate = self;
    [self setUpKeyboard];
    [self setUpCityKeyboard];
}
-(void)setUpCityKeyboard
{
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.cityLabel.inputView = self.pickerView;
}
-(void)setUpKeyboard
{
    self.datePicker = [[UIDatePicker alloc]init];
    //选择datePickerMode样式
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    //设置语言本地化 zh == 中国
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    //设置textFiled的键盘
    self.SRLabel.inputView = self.datePicker;
}
#pragma mark - Keyboard
-(void)dateChange:(UIDatePicker *)pickerView
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [fmt stringFromDate:self.datePicker.date];
    self.SRLabel.text = dateString;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ( textField==self.SRLabel) {
        [self dateChange:self.datePicker];
    }else{
        [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
    }
    
}

#pragma mark - CityKeyboard
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2 ;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component ==0) {//获取省
        return self.citys.count;
    }else{//获取市
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        CityModel *city = self.citys[index];
        return city.cities.count;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component ==0) {//获取省每一行名字
        CityModel *city = self.citys[row];
        return city.name;
    }else{//获取市每一行名字
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        CityModel *city = self.citys[index];
        return city.cities[row];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component ==0) {//滚动省，刷新市
        [self.pickerView reloadComponent:1];
    }
    //获取选中省的角标
    NSInteger index = [self.pickerView selectedRowInComponent:0];
    //获取选中的省
    CityModel *model = self.citys[index];
    //获取选中的市的角标
    NSInteger cityIndex = [self.pickerView selectedRowInComponent:1];
    //获取选中的市
    NSString *shi = model.cities[cityIndex];
    self.cityLabel.text = [NSString stringWithFormat:@"%@ %@",model.name,shi];
}
@end
