//
//  MainViewController.swift
//  DouYuZG
//
//  Created by 蒋学超 on 16/9/22.
//  Copyright © 2016年 JiangXC. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        addChildVc(storyBordName: "Home")
        addChildVc(storyBordName: "Live")
        addChildVc(storyBordName: "Follow")
        addChildVc(storyBordName: "User")
        
       
    }
    private func addChildVc(storyBordName : String){
        //1  通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyBordName, bundle: nil).instantiateInitialViewController()!
        //2 childVc 作为子控制器子控制器
        addChildViewController(childVc)
    }

  
}
