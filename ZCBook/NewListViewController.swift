//
//  NewListViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/25.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class NewListViewController: UIViewController {

    var closeButton = UIButton()
    var pushButton = UIButton()
    var newListView = NewListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //加载关闭和发布按钮
        loadButtons()
        //加载封面，书名，作者视图
        loadNewsListView()
    }

    func loadButtons(){
        self.closeButton.frame = CGRectMake(0, 20, 45, 20)
        self.closeButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.closeButton.setTitle("关闭", forState: UIControlState.Normal)
        self.closeButton.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.closeButton)

        self.pushButton.frame = CGRectMake(SCREEN_WIDTH - 45, 20, 45, 20)
        self.pushButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.pushButton.setTitle("发布", forState: UIControlState.Normal)
        self.pushButton.addTarget(self, action: "push", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.pushButton)
    }
    
    func loadNewsListView(){
        self.newListView.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT / 3)
        self.newListView.imageButton.addTarget(self, action: "addCoverAlert", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.newListView)
    }
    
    func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func push(){
        print("发布")
    }
    //imageButton的Action方法
    func addCoverAlert(){
        let coverAlertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        coverAlertController.addAction(cancelAction)
        
        let cameraAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: nil)
        coverAlertController.addAction(cameraAction)
        
        let chooseAction = UIAlertAction(title: "从相册中选取", style: UIAlertActionStyle.Default, handler: nil)
        coverAlertController.addAction(chooseAction)
        presentViewController(coverAlertController, animated: true, completion: nil)
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
