//
//  BookCommentAreaViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/2/24.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class BookCommentAreaViewController: UIViewController {

    var tableView: UITableView?
    var dataArray: NSMutableArray = []
    var bookObject: AVObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableView()
        
    }

    func loadTableView(){
        self.tableView = UITableView(frame: CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(BookCommentAreaCell.self, forCellReuseIdentifier: "CommentAreaCell")
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
        
        self.tableView!.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "headerRefresh")
        self.tableView!.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
        self.tableView!.mj_header.beginRefreshing()
    }
    

    func headerRefresh(){
        let query = AVQuery(className: "discuss")
        
        query.orderByDescending("createdAt")
        query.whereKey("Book_Title", equalTo: self.bookObject)
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if results != nil && results.count != 0{
                self.tableView?.mj_header.endRefreshing()
                self.dataArray.removeAllObjects()
                self.dataArray.addObjectsFromArray(results)
                self.tableView?.reloadData()
            }
        }
    }
    
    func footerRefresh(){
        let query = AVQuery(className: "discuss")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = self.dataArray.count
        query.whereKey("Book_Title", equalTo: self.bookObject)
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.tableView!.mj_footer.endRefreshing()
            self.dataArray.addObjectsFromArray(results)
            self.tableView!.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension BookCommentAreaViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentAreaCell") as? BookCommentAreaCell
        let object = self.dataArray[indexPath.row]
        //初始化
        cell?.initFrame()
        cell?.userImage?.image = UIImage(named: "Avatar")
        cell?.userName?.text = object["user"] as? String
        cell?.comment?.text = object["text"] as? String
//        cell?.backgroundColor = BACK_COLOR
        //复制之后进行sizeTofit进行显示
        cell?.comment?.sizeToFit()
        
        let date = object["createdAt"]as? NSDate
        let format = NSDateFormatter()
        format.dateFormat = "yyyy/MM/dd hh:mm"
        cell?.date?.text = format.stringFromDate(date!)
        
        return cell!
    }
    
    //MARK: UILabel自适应高度的计算
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let object = self.dataArray[indexPath.row]
        let text = object["text"] as? NSString
        let textSize = text?.boundingRectWithSize(CGSizeMake(SCREEN_WIDTH - 56, 0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil)
        let height = (textSize?.height)! + 23
        return height > 38 ? height : 38
    }
}