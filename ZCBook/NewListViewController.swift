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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载发布按钮
        loadCloseButton()
        //加载发布按钮
        loadPushButton()
        
    }

    func loadCloseButton(){
        self.closeButton.frame = CGRectMake(0, 20, 45, 30)
        self.closeButton.setTitleColor(BACK_COLOR, forState: UIControlState.Normal)
        self.closeButton.setTitle("关闭", forState: UIControlState.Normal)
        self.closeButton.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.closeButton)
    }
    
    func loadPushButton(){
        self.pushButton.frame = CGRectMake(SCREEN_WIDTH - 45, 20, 45, 30)
        self.pushButton.setTitleColor(BACK_COLOR, forState: UIControlState.Normal)
        self.pushButton.setTitle("发布", forState: UIControlState.Normal)
        self.pushButton.addTarget(self, action: "push", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.pushButton)
    }
    
    func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func push(){
        print("发布")
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
