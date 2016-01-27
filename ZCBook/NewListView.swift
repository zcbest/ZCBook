//
//  NewListView.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/25.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class NewListView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var imageButton = UIButton()
    var Book_Name = UITextField()
    var Book_Author = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        //加载封面按钮
        loadImageButton()
        //加载书名和作者
        loadNameAndAnthor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImageButton(){
        self.imageButton.frame = CGRectMake(10, 10, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 3.8)
        self.imageButton.setImage(UIImage(named: "Cover"), forState: UIControlState.Normal)
        self.addSubview(self.imageButton)
    }
    
    func loadNameAndAnthor(){
        self.Book_Name.frame = CGRectMake(SCREEN_WIDTH / 3 + 10, SCREEN_HEIGHT / 7.5, SCREEN_WIDTH * 2 / 3 - 10 , 20)
        self.Book_Name.placeholder = "书名"
        //文本框的样式 下面为圆角矩形边框
        self.Book_Name.borderStyle = UITextBorderStyle.RoundedRect
        //设置return键的样式
        self.Book_Name.returnKeyType = UIReturnKeyType.Done
        //文字大小超过文本框长度自动缩小字号
        self.Book_Name.adjustsFontSizeToFitWidth = true
        //输入框内右侧小叉，清除内容
        self.Book_Name.clearButtonMode = UITextFieldViewMode.Always
        self.addSubview(self.Book_Name)
        
        self.Book_Author.frame = CGRectMake(SCREEN_WIDTH / 3 + 10, SCREEN_HEIGHT / 4 - 3, SCREEN_WIDTH * 2 / 3 - 10 , 20)
        self.Book_Author.placeholder = "作者"
        //文本框的样式 下面为圆角矩形边框
        self.Book_Author.borderStyle = UITextBorderStyle.RoundedRect
        //设置return键的样式
        self.Book_Author.returnKeyType = UIReturnKeyType.Done
        //文字大小超过文本框长度自动缩小字号
        self.Book_Author.adjustsFontSizeToFitWidth = true
        //输入框内右侧小叉，清除内容
        self.Book_Author.clearButtonMode = UITextFieldViewMode.Always
        self.addSubview(self.Book_Author)
    }
    
}
