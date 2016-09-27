//
//  HomeViewController.swift
//  DouYuZG
//
//  Created by 蒋学超 on 16/9/22.
//  Copyright © 2016年 JiangXC. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {
    // MARK : 懒加载
     lazy var pageTitleView : PageTitleView = { [weak self] in
        
       
        let titleFrame = CGRect(x: 0, y: kNavgationBarH+kStatusBar, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let  pageTitleView = PageTitleView(frame: titleFrame, titles: titles)
//        pageTitleView.backgroundColor = UIColor.yellow
        pageTitleView.delegate = self as PageTitleViewDelegate?
        return pageTitleView
    }()
    
    lazy var pageContentView : PageContentView = {[weak self] in
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBar - kNavgationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBar + kNavgationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
       // childVcs.append(self()())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
       let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        return contentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //设置UI 界面
        setupUI()
        
    }

   
}
//MARK : 设置UI界面
extension HomeViewController{
    
    func setupUI(){
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1 添加导航栏
        setupNavBar()
        //2 添加 TitleView
        view.addSubview(pageTitleView)
        
        // 3.添加ContentView
        view.addSubview(pageContentView)
        
    }
    private func setupNavBar(){

        //设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        
        //设置右侧的item
        let size = CGSize(width: 40, height: 40)
        //历史
        //类方法
//        let historyItem = UIBarButtonItem.createIetm(imageName: "image_my_history", hightImage: "Image_my_history_click", size: size)
        //构造方法 苹果推荐使用
         let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImage: "Image_my_history_click", size: size)
        //搜索
       let searchItem = UIBarButtonItem(imageName: "btn_search", hightImage: "btn_search_clicked", size: size)
       //二维码
       let qrcodeBtnItem =  UIBarButtonItem(imageName: "Image_scan", hightImage: "Image_scan_click", size: size)
       
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeBtnItem]
        
    }
}
//MARK:-遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
             pageContentView.setCurrentIndex(currentIndex: index)
        }
    }
