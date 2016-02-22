//
//  BookCommentModel.swift
//  ZCBook
//
//  Created by 曾超 on 16/2/21.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit
import SVProgressHUD

class BookCommentModel: NSObject {
    
    var Book_Title: String = ""
    var Book_Author: String = ""
    var BookComment_Title: String = ""
    var BookComment_Description: String = ""
    
    init(bTitle: String, author: String, bcTitle: String, bcDesc: String) {
        self.Book_Title = bTitle
        self.Book_Author = author
        self.BookComment_Title = bcTitle
        self.BookComment_Description = bcDesc
    }
    
    static func loadData(dic: NSDictionary){
        let object = AVObject(className: "BookComment")
        object.setObject(dic["Book_Title"], forKey: "Book_Title")
        object.setObject(dic["Book_Author"], forKey: "Book_Author")
        object.setObject(dic["BookComment_Title"], forKey: "BookComment_Title")
        object.setObject(dic["BookComment_Description"], forKey: "BookComment_Description")
        object.setObject(AVUser.currentUser(), forKey: "user")

        object.saveInBackgroundWithBlock { (success, error) -> Void in
            if success{
                NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotification", object: nil, userInfo: ["result":"true"])
            }else{
               NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotification", object: nil, userInfo: ["result":"false"])
            }
        }
    }
}
