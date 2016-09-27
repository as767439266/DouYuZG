//
//  PageContentView.swift
//  DouYuZG
//
//  Created by 蒋学超 on 16/9/26.
//  Copyright © 2016年 JiangXC. All rights reserved.
//

import UIKit
private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    var childVcs : [UIViewController]
    weak var parentViewController : UIViewController?
    //MARK:-懒加载
    lazy var collectionView : UICollectionView = {[weak self] in
       //1创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
      //  collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
        
    }()
    //自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
       
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK:- 设置UI
extension PageContentView{
    func setupUI(){
    // 1.将所有的子控制器添加父控制器中
    for childVc in childVcs {
    parentViewController?.addChildViewController(childVc)
    }
    
    // 2.添加UICollectionView,用于在Cell中存放控制器的View
    addSubview(collectionView)
    collectionView.frame = bounds
}

}
//MARK:-遵循UICollectionViewDelegate
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2.给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }

}
// MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        
        // 1.记录需要进制执行代理方法
//        isForbidScrollDelegate = true
        
        // 2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

