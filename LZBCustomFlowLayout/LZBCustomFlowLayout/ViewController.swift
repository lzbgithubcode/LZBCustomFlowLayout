//
//  ViewController.swift
//  LZBCustomFlowLayout
//
//  Created by zibin on 2017/5/16.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

private let kLZBCollectionViewCellID = "kLZBCollectionViewCellID"

class ViewController: UIViewController {
    
    fileprivate var itemCount = 30
    
    fileprivate lazy var collectionView : UICollectionView = {
        
         let  waterLayout = LZBWaterFlowLayout()
         waterLayout.itemSize = CGSize(width: 100, height: 100)
         waterLayout.minimumInteritemSpacing = 10
         waterLayout.minimumLineSpacing = 10
         waterLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
         waterLayout.dataSoure = self
        
         let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: waterLayout)
         collectionView.dataSource = self
         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kLZBCollectionViewCellID)
        
         return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
       
        
    }
}

//MARK:- collectionView协议方法
extension ViewController : UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kLZBCollectionViewCellID, for: indexPath)
        cell.backgroundColor = UIColor.getRandomColor()
        
        var contentLabel : UILabel? = cell.contentView.subviews.first as? UILabel
        if contentLabel == nil{
            contentLabel = UILabel(frame: cell.bounds)
            contentLabel?.textAlignment = .center
            cell.contentView.addSubview(contentLabel!)
        }
          contentLabel?.text = "\(indexPath.item)"

        if indexPath.item == itemCount - 1{
           itemCount += itemCount
            collectionView.reloadData()
        }
        
        return cell
    }
    
}

//MARK:- LZBWaterFlowLayoutDataSource

extension ViewController : LZBWaterFlowLayoutDataSource{
    func waterFlowLayout(_ waterFlowLayout: LZBWaterFlowLayout, indexPath: IndexPath) -> CGFloat {
        return   CGFloat(arc4random_uniform(100) + 100)
    }
}
