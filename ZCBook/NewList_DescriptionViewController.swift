//
//  NewList_DescriptionViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/27.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class NewList_DescriptionViewController: UIViewController {

    var textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTextView()
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
