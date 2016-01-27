//
//  NewList_TitleViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/27.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

typealias NewList_TitleViewControllerClosure = (title: String) -> Void

class NewList_TitleViewController: UIViewController {

    var textField = UITextField()
    var button = UIButton()
    var callback: NewList_TitleViewControllerClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载文本框
        loadTextField()
        //设置确定按钮
        loadSureButton()
    }

    func loadTextField(){
        self.textField.frame = CGRectMake(10, 70, SCREEN_WIDTH - 20, 20)
        self.textField.placeholder = "书评标题"
        self.textField.adjustsFontSizeToFitWidth = true
        self.textField.clearButtonMode = .Always
        self.textField.borderStyle = .RoundedRect
        self.view.addSubview(self.textField)
    }
    
    func loadSureButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Plain, target: self, action: "sure")
    }
    
    func sure(){
        self.callback!(title: self.textField.text!)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
