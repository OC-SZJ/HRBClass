//
//  ImagePickerCollectionViewCell.m
//  ocCrazy
//
//  Created by mac on 2018/4/25.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "ImagePickerImgCell.h"

#import "ImagePickerSelectView.h"

@implementation ImagePickerImgCell
{


    __weak IBOutlet ImagePickerSelectView *_selectView;
    
    __weak IBOutlet UIView *_mark;
    

}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setCanSelect:(BOOL)select{
    _mark.hidden = !select;
}


-(void)setModel:(ImageModel *)model{
    _model = model;
    BOOL select = model.indexOfSelect > 0;
 
    [_selectView setText:@(model.indexOfSelect).stringValue];
    
    if (select) _mark.hidden = YES;
    
}


- (IBAction)selectAction:(UIButton *)sender {
    BOOL select = [_selectView isSelect];
    if (!select){
        [_selectView scaleAnimation:^{
           
        }];
    }
    if (self.block) self.block(!select,self.model);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"needReload" object:nil];
    [_selectView setText:@(_model.indexOfSelect).stringValue];
}




@end


