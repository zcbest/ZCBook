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
        //隐藏导航栏
        self.navigationController?.navigationBarHidden = true
        //+号按钮
        loadNewButton1()
        //新建书评按钮
        loadNewButton2()
        //背景图片
        loadImageView()
        //标签
        loadLabel()
    }

    func loadNewButton1(){
        self.newButton1.frame = CGRectMake(0,20,30,30)
        self.newButton1.setImage(UIImage(named: "plus circle"), forState: UIControlState.Normal)
        self.newButton1.addTarget(self, action: "push", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.newButton1)
    }
    
    func loadNewButton2(){
        self.newButton2.frame = CGRectMake(40, 20, 80, 30)
        self.newButton2.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.newButton2.setTitle("新建书评", forState: UIControlState.Normal)
        self.newButton2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.newButton2.addTarget(self, action: "push", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.newButton2)
    }
    //按钮的action
    func push(){
        //ViewController转场方式 UIModalTransitionStyleCoverVertical 默认值，从下向上覆盖
        //UIModalTransitionStyleFlipHorizontal 水平翻转
        //UIModalTransitionStylePartialCurl 书页翻开显示下面的视图
        let newListVC = NewListViewController()
        newListVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.presentViewController(newListVC, animated: true, completion: nil)
    }
    
    func loadImageView(){
        self.imageView.frame = CGRectMake(0, 35, SCREEN_WIDTH, SCREEN_HEIGHT - 220)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
