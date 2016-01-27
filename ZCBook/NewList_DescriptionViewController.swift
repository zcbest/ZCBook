//
//  NewList_DescriptionViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/27.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

typealias NewList_DescriptionViewControllerClosure = (description: String) -> Void

class NewList_DescriptionViewController: UIViewController {

    var textView = UITextView()
    
    var callback: NewList_DescriptionViewControllerClosure?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载文本框
        loadTextView()
        //设置确定按钮
        loadSureButton()
    }

    func loadTextView(){
        self.textView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.textView.text = "你可以在这里撰写详细的介绍、评价、吐槽"
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
        self.callback!(description: self.textView.text)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
