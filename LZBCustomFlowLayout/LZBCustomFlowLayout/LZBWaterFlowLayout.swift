//
//  LZBWaterFlowLayout.swift
//  LZBCustomFlowLayout
//
//  Created by zibin on 2017/5/16.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

protocol LZBWaterFlowLayoutDataSource : class {
    func waterFlowLayout(_ waterFlowLayout : LZBWaterFlowLayout , indexPath : IndexPath) -> CGFloat
}

class LZBWaterFlowLayout: UICollectionViewFlowLayout {
    
    var  cols = 2  //设置列数
    weak var dataSoure : LZBWaterFlowLayoutDataSource?
    
    fileprivate  let  defaultItemHeight : CGFloat = 100  //默认高度
    fileprivate  var  conentMaxHeight : CGFloat =  0
    //定义布局好的frame数组
    fileprivate lazy var layoutAttributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var heights : [CGFloat] = Array(repeating:  self.sectionInset.top, count: self.cols)
    

    //1.准备cell的frame
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        
        //获取需要布局的总共item个数
        let count =  collectionView.numberOfItems(inSection: 0)
        let itemW = (collectionView.bounds.width - self.sectionInset.left - self.sectionInset.right - (CGFloat(cols) - 1) * self.minimumInteritemSpacing)/CGFloat(cols)
       
        for i in layoutAttributes.count..<count{
            //1.获取每个item对应的indexPath
            let indexPath = IndexPath(item: i, section: 0)
            
            //2.获取每个indexPath对应的UICollectionViewLayoutAttributes
            let layoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            //3.设置layoutAttribute的frame
            let itemH = dataSoure?.waterFlowLayout(self, indexPath: indexPath) ?? defaultItemHeight
            
            //3.1求x值,后面一个是根据前面几个的高度，谁是最小那就放在谁的后面
            let minH = heights.min()!  //取出数组中最小值
            let minIndex = heights.index(of: minH)!  //取出最小值对应的位置
            //3.2 计算出X Y
            let itemX = self.sectionInset.left + (itemW + self.minimumInteritemSpacing) * CGFloat(minIndex)
            let itemY = i < cols ? minH :minH + self.minimumLineSpacing
            
            layoutAttribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            
            //4.layoutAttribute保存到数组中
            layoutAttributes.append(layoutAttribute)
            
            //5.更新数组里面的高度
            heights[minIndex] = layoutAttribute.frame.maxY
            
        }
        
        //6.获取最大的高度
        conentMaxHeight = heights.max()!
    }
    
    //2.准备好的frame数组布局
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
          return layoutAttributes
    }
    
    //3.设置可以滚动的最大距离
    override var collectionViewContentSize: CGSize{
       return CGSize(width: 0, height: conentMaxHeight + self.sectionInset.bottom)
    }
}


