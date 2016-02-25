//
//  BookCommentViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/2/22.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit
import SVProgressHUD

class BookCommentViewController: UIViewController {

    var bookObject = AVObject()
    var imageView = UIImageView()
    var book_Author =  UILabel()
    var book_Title = UILabel()
    var date = UILabel()
    //BookCommentView界面上的部分
    var baseView = UIView()
    
    //FirstView
    var firstView = UIView()
    
    var book_Discription = UITextView()
    var detailBar = BookCommentDetailBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBaseView()
        
        loadDiscription()
        
        loadDetailBar()
        
        loadDetailBarAction()
        //判断该书是否已经被点赞
        isLoved()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)  //返回按钮文字空

    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func loadBaseView(){
        self.baseView.frame = CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT / 3)
        self.baseView.backgroundColor = UIColor.redColor()
        
        self.imageView.frame = CGRectMake(0, 0, 80, 120)
        self.imageView.image = UIImage(named: "Cover")
        self.baseView.addSubview(self.imageView)
        
        self.book_Author.frame = CGRectMake(90, 20, 20, 20)
        self.book_Author.text = self.bookObject["Book_Author"] as? String
        self.book_Author.textColor = UIColor.blackColor()
        self.book_Author.textAlignment = NSTextAlignment.Center
        self.baseView.addSubview(self.book_Author)
        
        self.book_Title.text = self.bookObject["Book_Title"] as? String
        self.book_Title.frame = CGRectMake(90, 45, 20, 20)
        self.book_Title.textAlignment = NSTextAlignment.Center
        self.baseView.addSubview(self.book_Title)
        //日期的使用
        let date = self.bookObject["createdAt"]as? NSDate
        let format = NSDateFormatter()
        format.dateFormat = "yyyy/MM/dd hh:mm"
        self.date.frame = CGRectMake(120, 20, 150, 30)
        self.date.text = format.stringFromDate(date!)
        self.baseView.addSubview(self.date)
        
        self.view.addSubview(self.baseView)
    }
    
    func loadDiscription(){
        self.book_Discription.frame = CGRectMake(0, 44 + SCREEN_HEIGHT / 3.5, SCREEN_WIDTH, 2*SCREEN_HEIGHT/3 - 44)
        self.book_Discription.text = self.bookObject["BookComment_Description"] as? String
        self.book_Discription.editable = false
        self.book_Discription.backgroundColor = UIColor.greenColor()
        self.view.addSubview(self.book_Discription)
    }
    
    func loadDetailBar(){
        //这里要调用BookCommentDetailBar的init方法
        self.detailBar = BookCommentDetailBar(frame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40))
        self.view.addSubview(self.detailBar)
    }
    
    func loadDetailBarAction(){
        let btn0 = self.detailBar.viewWithTag(1) as? UIButton
        btn0?.addTarget(self, action: "FirstAction", forControlEvents: UIControlEvents.TouchUpInside)
        let btn1 = self.detailBar.viewWithTag(2) as? UIButton
        btn1?.addTarget(self, action: "SecondAction", forControlEvents: UIControlEvents.TouchUpInside)
        let btn2 = self.detailBar.viewWithTag(3) as? UIButton
        btn2?.addTarget(self, action: "ThirdAction:", forControlEvents: UIControlEvents.TouchUpInside)
        let btn3 = self.detailBar.viewWithTag(4) as? UIButton
        btn3?.addTarget(self, action: "ForthAction", forControlEvents: UIControlEvents.TouchUpInside)
        
    }

    func FirstAction(){
        let vc = BookCommentActionViewController()
        vc.title = "评论"
        vc.bookObject = self.bookObject
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func SecondAction(){
        let vc = BookCommentAreaViewController()
        vc.title = "讨论区"
        vc.bookObject = self.bookObject
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func ThirdAction(btn: UIButton){
        //prevent action
        btn.enabled = false
        let query = AVQuery(className: "love")
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.whereKey("Book_Title", equalTo: self.bookObject)
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if results != nil && results.count != 0{
                for object in results{
                    object.deleteEventually()
                }
                btn.setImage(UIImage(named: "heart"), forState: UIControlState.Normal)
            }else{
                let object = AVObject(className: "love")
                object.setObject(AVUser.currentUser(), forKey: "user")
                object.setObject(self.bookObject, forKey: "Book_Title")
                object.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success{
                        btn.setImage(UIImage(named: "solidheart"), forState: UIControlState.Normal)
                    }else{
                        SVProgressHUD.showErrorWithStatus("操作失败")
                    }
                })
            }
            btn.enabled = true
        }
    }
    
    func ForthAction(){
        print("Forth")
    }
    
    //是否已经被点赞
    func isLoved(){
        let query = AVQuery(className: "love")
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.whereKey("Book_Title", equalTo: self.bookObject)
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if results != nil && results.count != 0{
                let btn = self.detailBar.viewWithTag(3) as? UIButton
                btn?.setImage(UIImage(named: "solidheart"), forState: UIControlState.Normal)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
