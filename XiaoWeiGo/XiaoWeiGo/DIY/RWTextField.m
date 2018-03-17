//
//  RWTextField.m
//  ucupay
//
//  Created by dingxin on 2017/7/11.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "RWTextField.h"
#define RWPlaceHolderColor UIColorFromRGB16(0x999999)
#define RWTextColor UIColorFromRGB16(0x666666)

@implementation RWTextField
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        [[UITextField appearance] setTintColor:UIColorFromRGB16(0x999999)];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setUpUI
{
    //    self.layer.masksToBounds = YES;
    //    self.layer.cornerRadius = 22;
    //    self.backgroundColor = [UIColor whiteColor];
    //    self.layer.borderColor = Default_SeparatorColor.CGColor;
    //    self.layer.borderWidth = 1;
    self.font = [UIFont systemFontOfSize:14];
    //字体颜色
    self.textColor = RWTextColor;
    //光标颜色
//    self.tintColor= RWTextColor;
    
    [self setTintColor:[UIColor textGrayColor]];
    [self setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    //占位符的颜色和大小
    [self setValue:RWPlaceHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    self.delegate = self;
    
}


//控制placeHolder的位置
//-(CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    return inset;
//}
//
////控制显示文本的位置
//-(CGRect)textRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
//}
//
////控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x +20, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
//}
+ (RWTextField *)initTextFieldWithPlaceHolder:(NSString *)placeHolder font:(UIFont *)font textColor:(UIColor *)color keyboardType:(UIKeyboardType)keyboardType{
    RWTextField *field = [[RWTextField alloc] init];
    field.placeholder = placeHolder;
    field.font = font;
    field.textColor = color;
//    field.tintColor = RWTextColor;
    [field setTintColor:[UIColor textGrayColor]];
    [field setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
    field.keyboardType = keyboardType;
    //    field.font = [UIFont systemFontOfSize:16];
    //    field.textColor = UIColorFromRGB16(0x666666);
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    [field setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [field setAutocorrectionType:UITextAutocorrectionTypeNo];
    return field;
}

+ (RWTextField *)initTextFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType {
    RWTextField *field = [[RWTextField alloc] init];
    field.placeholder = placeHolder;
    field.font = [UIFont rw_regularFontSize:15];
    //    field.font = font;
    //    field.textColor = color;
    field.keyboardType = keyboardType;
//    field.tintColor = UIColorFromRGB16(0x666666);
    [field setTintColor:[UIColor textGrayColor]];
    [field setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
    //    field.font = [UIFont systemFontOfSize:16];
    field.textColor = UIColorFromRGB16(0x666666);
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    [field setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [field setAutocorrectionType:UITextAutocorrectionTypeNo];
    field.clearsOnBeginEditing = NO;
    return field;
}

+ (RWTextField *)initTextFieldWithPlaceHolder:(NSString *)placeHolder{
    RWTextField *field = [[RWTextField alloc] init];
    field.placeholder = placeHolder;
    field.font = [UIFont rw_regularFontSize:16];
    field.textColor = UIColorFromRGB16(0x666666);
    [field setTintColor:[UIColor textGrayColor]];
    [field setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    [field setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [field setAutocorrectionType:UITextAutocorrectionTypeNo];
    return field;
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if ([string isEqualToString:@" "]) {
//        return NO;
//    }
//    if (self.textFieldMaxNumberOfCharacters) {
//        // Check maximum length requirement
//        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        if (newString.length > self.textFieldMaxNumberOfCharacters.integerValue) {
//            return NO;
//        }
//    }
//    // Otherwise, leave response to view controller
//    return [self textField:textField shouldChangeCharactersInRange:range replacementString:string];
//}
@end
