//
//  MHLayout.m
//  Test
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import "MHLayout.h"

@implementation MHLayout

//CollectionView会在初次布局时首先调用该方法
//CollectionView会在布局失效后、重新查询布局之前调用此方法
//子类中必须重写该方法并调用超类的方法
-(void)prepareLayout{
    [super prepareLayout];
  
}



// UICollectionViewLayoutAttributes:cell的布局对象
// 每一个cell对应UICollectionViewLayoutAttributes
// UICollectionViewLayoutAttributes用来描述cell的布局
// UICollectionViewLayoutAttributes就是cell

// 作用:指定一个区域,就会返回这个区域内的所有cell布局
// 这个可以一次性返回所有cell布局,也可以分批方法
// 操作cell布局
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    // 哪些cell需要进行缩放,显示cell才需要做缩放,获取显示出来cell布局,获取显示范围
    // 问题:什么时候缩放,什么时候放大
    // 离中心点越近,cell越大,离中心点越远,cell越小
    // 缩放跟中心点成反比
    // 计算中心点
    
    /*
     获取显示的区域的大小
     */
    CGRect visableRect = self.collectionView.bounds;
    
    CGFloat width = visableRect.size.width;
    
    NSArray *original = [super layoutAttributesForElementsInRect:visableRect];
    
    NSArray *array =  [[NSArray alloc]initWithArray:original copyItems:YES];
    
       
    for (UICollectionViewLayoutAttributes *attr in array) {
        /*
         fabs 获取绝对值   与中心点的距离
         */
        CGFloat delta = fabs(attr.center.x - (self.collectionView.contentOffset.x + width * 0.5));
        
        
        
        /*
           根据 与中心点的距离   确定缩放比例
         */
        float scale = 1 - (delta / width * 0.5) * 0.5;

        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
        
        if (self.collectionView.contentOffset.x == 0 && [array indexOfObject:attr] == 0) {
            
//            [self.collectionView setContentOffset: CGPointMake(attr.center.x - width * 0.5, 0) animated:YES];
        
        }
    }
    
    return array;
} // return an array layout attributes instances for all the views in the given rect

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return nil;
//}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
//return nil;
//}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath{
//    return nil;
//}

// 作用:
// Invalidate:刷新
// 在拖动内容是否允许属性布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}


/**
 *  用来设置collectionView停止滚动那一刻的位置
 *
 *  @param proposedContentOffset collectionView原本停留的位置
 *  @param velocity              滚动的速度
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //1.计算scrollview最`后会停留的范围
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    //计算屏幕最中间的x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width*0.5;
    
    //2.取出这个范围内的所有属性
    NSArray *array1 = [self layoutAttributesForElementsInRect:lastRect];
    
    //遍历所有的属性
    CGFloat adjustOffsetX = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *array2 in array1) {
        
        if (ABS(array2.center.x - centerX) < ABS(adjustOffsetX)) {
            
            adjustOffsetX = array2.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x+adjustOffsetX, proposedContentOffset.y);
}

@end
