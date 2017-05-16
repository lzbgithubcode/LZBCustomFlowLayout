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
    
    fileprivate lazy var collectionView : UICollectionView = {
        
         let  waterLayout = LZBWaterFlowLayout()
         waterLayout.itemSize = CGSize(width: 100, height: 100)
         waterLayout.minimumInteritemSpacing = 10
         waterLayout.minimumLineSpacing = 10
         waterLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
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
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kLZBCollectionViewCellID, for: indexPath)
        cell.backgroundColor = UIColor.getRandomColor()
        return cell
    }
    
}
