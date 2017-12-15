//
//  SMPickView.m
//  ProjectFramework
//
//  Created by Elroy on 9/26/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMPickView.h"

@interface SMPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, assign) BOOL glide;
@property (nonatomic, strong) NSString *selectStr;
@property (nonatomic, strong) NSMutableArray *dataSource;



@end

@implementation SMPickView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title dataSource:(NSArray *)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = [NSMutableArray arrayWithArray:dataSource];
        _glide = NO;
        self.userInteractionEnabled = YES;
        self.backgroundColor = RGBColor(0, 0, 0, 0.3);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewAction:)];
        [self addGestureRecognizer:tap];
        
        UIView *cycanView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 220, kScreenWidth, 40)];
        cycanView.backgroundColor = [UIColor orangeColor];
        [self addSubview:cycanView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, cycanView.height)];
        titleLabel.text = title;
        titleLabel.font = kFontSize(14);
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [cycanView addSubview:titleLabel];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, cycanView.height)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = kFontSize(14);
        [cancelButton addTarget:self action:@selector(backgroundViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [cycanView addSubview:cancelButton];
        
        UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 48, 0, 48, cycanView.height)];
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirmButton.titleLabel.font = kFontSize(14);
        [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cycanView addSubview:confirmButton];
        
        UIPickerView *selectPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 180, kScreenWidth, 180)];
        // 显示选中框
        selectPickerView.showsSelectionIndicator = NO;
        selectPickerView.backgroundColor = [UIColor whiteColor];
        selectPickerView.delegate = self;
        selectPickerView.dataSource = self;
        selectPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:selectPickerView];
    }
    return self;
}


#pragma mark - 隐藏弹框
- (void)backgroundViewAction:(UITapGestureRecognizer *)sender{
    [self removeFromSuperview];
}
#pragma mark - 弹框确定按钮
- (void)confirmButtonAction:(UIButton *)sender{
    if (!_glide) {
        _selectStr = [NSString stringWithFormat:@"%@", _dataSource[0]];
    }
    if ([self.delegate respondsToSelector:@selector(pickedValue:)]) {
        [self.delegate pickedValue:_selectStr];
    }
    
    [self removeFromSuperview];
}
#pragma mark - UIPickerView代理方法
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataSource.count;
}
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kScreenWidth - 85 * 2;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _glide = YES;
    _selectStr = [NSString stringWithFormat:@"%@",[_dataSource objectAtIndex:row]];
    NSLog(@"selectStr:%@", _selectStr);
}
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_dataSource objectAtIndex:row];
}


//重写方法,改变字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = kFontSize(17);
        pickerLabel.textColor = [UIColor blackColor];
        pickerLabel.textAlignment = 1;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    
    //在该代理方法里添加以下两行代码删掉上下的黑线
    [[pickerView.subviews objectAtIndex:1] setHidden:NO];
    [[pickerView.subviews objectAtIndex:2] setHidden:NO];
    
//    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(85, 55, kScreenWidth - 85 * 2, 1.8)];
//    lineView1.backgroundColor = RGBColor(245, 245, 245, 1.0);
//    [pickerView addSubview:lineView1];
//    
//    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(85, 82, kScreenWidth - 85 * 2, 1.8)];
//    lineView2.backgroundColor = RGBColor(245, 245, 245, 1.0);
//    [pickerView addSubview:lineView2];
    
    return pickerLabel;
}


//#pragma mark - Lazy Loading
//- (NSMutableArray *)dataSource {
//    if (!_dataSource) {
//        _dataSource = [[NSMutableArray alloc] init];
//    }
//    return _dataSource;
//}

@end
