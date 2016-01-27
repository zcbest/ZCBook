//
//  NewViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/25.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    //新建书评按钮
    var newButton1 = UIButton()
    var newButton2 = UIButton()
    var imageView = UIImageView()
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏
        setUpNav()
        //加载背景图片
        loadImageView()
        //标签
        loadLabel()
    }
    
    func setUpNav(){
        let button1 = UIBarButtonItem(image: UIImage(named: "plus circle"), style: UIBarButtonItemStyle.Plain, target: self, action: "push")
        let button2 = UIBarButtonItem(title: "新建书评", style: UIBarButtonItemStyle.Plain, target: self, action: "push")
        self.navigationItem.leftBarButtonItems = [button1, button2]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)  //返回按钮文字空

    }
    //action
    func push(){
        //ViewController转场方式 UIModalTransitionStyleCoverVertical 默认值，从下向上覆盖
        //UIModalTransitionStyleFlipHorizontal 水平翻转
        //UIModalTransitionStylePartialCurl 书页翻开显示下面的视图
        let newListVC = NewListViewController()
        self.navigationController?.pushViewController(newListVC, animated: true)
    }
    
    func loadImageView(){
        self.imageView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 220)
        self.imageView.image = UIImage(named: "blank.png")
        self.imageView.alpha = 0.5
        self.view.addSubview(self.imageView)
    }

    func loadLabel(){
        self.label.frame = CGRectMake((SCREEN_WIDTH - 250) / 2, SCREEN_HEIGHT - 150, 250, 30)
        self.label.text = "快来分享你的第一本书吧~~"
        self.label.textColor = UIColor.orangeColor()
        self.view.addSubview(self.label)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
