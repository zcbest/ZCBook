//
//  BookCommentActionViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/2/24.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit
import SVProgressHUD

class BookCommentActionViewController: UIViewController {

    var textView = UITextView()
    var bookObject = AVObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载文本框
        loadTextView()
        //设置确定按钮
        loadSureButton()
    }
    
    func loadTextView(){
        self.textView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.textView.font = UIFont.systemFontOfSize(20)
        self.textView.editable = true
        self.textView.selectable = true
        //旧内容编辑时全选
        self.textView.clearsOnInsertion = true
        
        self.view.addSubview(self.textView)
    }
    
    func loadSureButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Plain, target: self, action: "sure")
    }
    
    func sure(){
        let object = AVObject(className: "discuss")
        object.setObject(self.textView.text, forKey: "text")
        object.setObject(AVUser.currentUser(), forKey: "user")
        object.setObject(self.bookObject, forKey: "Book_Title")
        object.saveInBackgroundWithBlock { (success, error) -> Void in
            if success{
                SVProgressHUD.showSuccessWithStatus("评论成功")
            }else{
                SVProgressHUD.showErrorWithStatus("评论失败")
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
