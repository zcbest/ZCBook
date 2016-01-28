//
//  LoginViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/28.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class LoginViewController: UIViewController {

    var imageView = UIImageView()
    //TextField中可以通过tag来判断是哪一个textfield，不过要进行初始化
    var username = UITextField()
    var password = UITextField()
    var formView = UIView()
    var topConstraint: Constraint?
    var loginButton = UIButton()
    var registerButton = UIButton()
    var forgetPasswordButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFormView()
        loadImageView()
        loadUserName()
        loadPassWord()
        loadLoginButton()
        loadForgetPasswordButton()
        loadRegisterButton()
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
    
    func loadUserName(){
        self.username.placeholder = "用户名/邮箱"
        self.username.clearButtonMode = .Always
        self.username.delegate = self
        self.formView.addSubview(self.username)
        self.username.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(self.imageView.snp_bottom).offset(30)
            make.height.equalTo(30)
        }
    }
    
    func loadPassWord(){
        self.password.placeholder = "密码"
        self.password.clearButtonMode = .Always
        //密文
        self.password.secureTextEntry = true
        self.password.delegate = self
        self.formView.addSubview(self.password)

        self.password.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(self.username.snp_bottom).offset(30)
            make.height.equalTo(30)
        }
    }
    
    func loadLoginButton(){
        self.loginButton.backgroundColor = UIColor.orangeColor()
        self.loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.loginButton.setTitle("登录", forState: UIControlState.Normal)
        self.loginButton.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        self.formView.addSubview(self.loginButton)
        self.loginButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(self.password.snp_bottom).offset(30)
            make.height.equalTo(30)
        }
    }
    
    func loadForgetPasswordButton(){
        self.forgetPasswordButton.setTitle("忘记密码", forState: UIControlState.Normal)
        self.forgetPasswordButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.forgetPasswordButton.addTarget(self, action: "forgetPassword", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.forgetPasswordButton)
        self.forgetPasswordButton.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
    }
    
    func loadRegisterButton(){
        self.registerButton.setTitle("注册新用户", forState: UIControlState.Normal)
        self.registerButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.registerButton.addTarget(self, action: "register", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.registerButton)
        
        self.registerButton.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.forgetPasswordButton.snp_left).offset(-40)
            make.bottom.equalTo(-10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }

    func login(){
        AVUser.logInWithUsernameInBackground(self.username.text, password: self.password.text) { (user, error) -> Void in
            if error == nil{
                self.presentViewController(MainTabBarController(), animated: true, completion: nil)
            }else{
                if error.code == 210{
                    SVProgressHUD.showErrorWithStatus("用户名或者密码错误")
                }else if error.code == 211{
                    SVProgressHUD.showErrorWithStatus("不存在该用户")
                }else if error.code == 216{
                    SVProgressHUD.showErrorWithStatus("未验证邮箱")
                }else{
                    SVProgressHUD.showErrorWithStatus("登录失败")
                }
            }
        }
    }
    
    func register(){
        let vc = RegisterViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func forgetPassword(){
        print("忘记密码")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension LoginViewController: UITextFieldDelegate{
    //当对TextField进行编辑的时候进行的回调
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.5) { () -> Void in
            //更新约束
            self.topConstraint?.updateOffset(-50)
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
