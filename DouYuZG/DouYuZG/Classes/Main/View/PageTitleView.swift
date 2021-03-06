//
//  PageTitleView.swift
//  DouYuZG
//
//  Created by 蒋学超 on 16/9/23.
//  Copyright © 2016年 JiangXC. All rights reserved.
//

import UIKit
//MARK:-定义协议
protocol PageTitleViewDelegate :class{
     func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}
// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
class PageTitleView: UIView {
    //懒加载
    //懒加载一个lable 数组
    lazy var titleLabels : [UILabel] = [UILabel]()
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
        
    }()
    
    lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
   //定义属性
    var currentIndex : Int = 0
    var titles :[String]
    weak var delegate : PageTitleViewDelegate?
   //MARK : 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        print(frame)
        //设置UI
        setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

//MARK- 设置UI界面
extension PageTitleView{
     func setupUI(){
        //1 添加ScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2 添加title 的label
        setupTitleLables()
        
        // 3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
        
    }
    private func setupTitleLables()
    {
        
        // 0.确定label的一些frame的值
        let labelW : CGFloat = bounds.width / CGFloat(titles.count)
        let labelH : CGFloat = bounds.height - kScrollLineH
        let labelY : CGFloat = 0
        for (index,title) in titles.enumerated(){
            //创建lable
            let lable = UILabel()
            //设置lable的属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.tintColor = UIColor(r:  kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lable.textAlignment = .center
            
            //3 设置lable 的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            lable.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4 将lable 添加到scroolview
            scrollView.addSubview(lable)
            titleLabels.append(lable)
            
            // 5.给Label添加手势
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action:#selector(PageTitleView.titleLabelClick))
            lable.addGestureRecognizer(tapGes)
           
            
//            //5  给 lable 添加手势
//            lable.isUserInteractionEnabled = true
////            let tapGes = UITapGestureRecognizer(target: self, action:#selector(self.titleLabelClick(_:)))
//            let tapGes = UITapGestureRecognizer(target: self, action: Selector(("titleLabelClick:")))
//            lable.addGestureRecognizer(tapGes)
           

        }
    }
   
    private func setupBottomLineAndScrollLine(){
        //1  添加底线
        let bottomLine  = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r:  kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 2.2.设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}
//MARK:- 手势事件
extension PageTitleView{
    @objc func titleLabelClick(tapGes : UITapGestureRecognizer){
        // 0.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        // 2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)    }
}
// MARK:- 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
    }
}
