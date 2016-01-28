//
//  RegisterViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/28.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {

    var imageView = UIImageView()
    //TextField中可以通过tag来判断是哪一个textfield，不过要进行初始化
    var mail = UITextField()
    var smallName = UITextField()
    var password = UITextField()
    var formView = UIView()
    var topConstraint: Constraint?

    var registerButton = UIButton()

    var backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFormView()
        loadImageView()
        loadMail()
        loadSmallName()
        loadPassWord()
        loadRegisterButton()
        //覆盖在formView上
        loadBackButton()


    }
    func loadBackButton(){
        self.backButton.frame = CGRectMake(10,20,40,50)
        backButton.setTitle("返回", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        backButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.backButton)
    }
    //图片+用户名+密码视图
    func loadFormView(){
        self.formView.backgroundColor = UIColor.whiteColor()
        //添加视图这一行要写在做约束前面
        self.view.addSubview(self.formView)
        
        self.formView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            self.topConstraint = make.top.equalTo(30).constraint
            make.height.equalTo(500)
        }
    }
    
    func loadImageView(){
        self.imageView.image = UIImage(named: "logn")
        self.formView.addSubview(self.imageView)
        self.imageView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(20)
            make.height.equalTo(200)
        }
    }
    
    func loadMail(){
        self.mail.placeholder = "邮箱"
        self.mail.delegate = self
        self.formView.addSubview(self.mail)
        self.mail.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(self.imageView.snp_bottom).offset(30)
            make.height.equalTo(30)
        }
    }
    
    func loadSmallName(){
        self.smallName.placeholder = "昵称"
        self.smallName.delegate = self
        self.formView.addSubview(self.smallName)
        
        self.smallName.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(self.mail.snp_bottom).offset(30)
            make.height.equalTo(30)
        }
    }
    
    func loadPassWord(){
        self.password.placeholder = "密码"
        self.password.delegate = self
        self.formView.addSubview(self.password)
        
        self.password.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(self.smallName.snp_bottom).offset(30)
            make.height.equalTo(30)
        }
    }
    
    func loadRegisterButton(){
        self.registerButton.backgroundColor = UIColor.orangeColor()
        self.registerButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.registerButton.setTitle("注册新账号", forState: UIControlState.Normal)
        self.registerButton.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        self.formView.addSubview(self.registerButton)
        self.registerButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(self.password.snp_bottom).offset(30)
            make.height.equalTo(30)
        }
    }

    func back(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension RegisterViewController: UITextFieldDelegate{
    //当对TextField进行编辑的时候进行的回调
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.topConstraint?.updateOffset(-60)
            self.view.layoutIfNeeded()
        }
    }
    //当TextField return之后进行的回调
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.topConstraint?.updateOffset(30)
            self.view.layoutIfNeeded()
        }
        return true
    }
}
