//
//  RecommendViewController.swift
//  DouYuZG
//
//  Created by 蒋学超 on 16/9/27.
//  Copyright © 2016年 JiangXC. All rights reserved.
//

import UIKit
private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
//设置大小 位置
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
class RecommendViewController: UIViewController {
    //MARK:-懒加载
    lazy var collectionView : UICollectionView = {
        //1 创建布局
         let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
       //2创建UICollectionView
        let collecView = UICollectionView(frame:  self.view.bounds, collectionViewLayout: layout)
            collecView.dataSource = self
            collecView.backgroundColor = UIColor.white
        //注册cell
//         collecView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collecView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
//        
         //注册headView
//        collecView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
         collecView.register(UINib(nibName: "CollectionHeaderViewCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
         collecView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collecView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
       
}

}

//mark:-设置UI
extension RecommendViewController{
    func setupUI(){
        //1 将UICollectionView添加到控制器上
        view.addSubview(collectionView)
       
    }
}
//MARK:-遵守UICollectionViewDataSource的协议
extension RecommendViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 6
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取cell
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
       // cell.backgroundColor = UIColor.blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //获取 sectionHeadView
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
       
        return headView
    }
}
