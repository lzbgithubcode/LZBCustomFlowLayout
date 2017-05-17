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
         collectionView.delegate = self
         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kLZBCollectionViewCellID)
        
         return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
       
        
    }
}

//MARK:- collectionView协议方法
extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate{
   
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
        
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.bounds.size.height{
             itemCount += itemCount
            collectionView.reloadData()
        }
    }
    
}

//MARK:- LZBWaterFlowLayoutDataSource

extension ViewController : LZBWaterFlowLayoutDataSource{
    func waterFlowLayout(_ waterFlowLayout: LZBWaterFlowLayout, indexPath: IndexPath) -> CGFloat {
        let  width = view.bounds.width
        return  indexPath.item%2==0 ? width * 2/3 : width * 0.5
    }
}
