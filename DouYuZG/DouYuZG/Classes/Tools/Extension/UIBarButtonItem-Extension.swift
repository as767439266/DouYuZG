//
//  UIBarButtonItem-Extension.swift
//  DouYuZG
//
//  Created by 蒋学超 on 16/9/22.
//  Copyright © 2016年 JiangXC. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
   /* class func createIetm(imageName:String,hightImage:String,size:CGSize)->UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:hightImage), for: .highlighted)
        btn.frame = CGRect(origin:CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
     */
    //便利构造函数 。1
    convenience init(imageName:String,hightImage:String = "",size:CGSize = CGSize.zero){
        //创建btn
        let btn = UIButton()
         btn.setImage(UIImage(named:imageName), for: .normal)
        //设置图片
        if hightImage != ""{
        btn.setImage(UIImage(named:hightImage), for: .highlighted)
        }
        //设置尺寸
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
             btn.frame = CGRect(origin:CGPoint.zero, size: size)
        }
        self.init(customView:btn)
    }
}
