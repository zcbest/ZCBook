//
//  LeadPageViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/27.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class LeadPageViewController: UIViewController {

    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func loadScorllView(){
        self.view.addSubview(self.scrollView)
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
