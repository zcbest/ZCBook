//
//  NewViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/25.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit
import SVProgressHUD

class NewViewController: UIViewController {
    //新建书评按钮
    var newButton1 = UIButton()
    var newButton2 = UIButton()
    var imageView = UIImageView()
    var label = UILabel()
    //New控制器的数据源
    var dataArray:NSMutableArray = []
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableView()

        //设置导航栏
        setUpNav()
        //加载背景图片
        loadImageView()
        //标签
        loadLabel()
        
    }
    
    func setUpNav(){
        let button1 = UIBarButtonItem(image: UIImage(named: "plus circle"), style: UIBarButtonItemStyle.Plain, target: self, action: "push")
        let button2 = UIBarButtonItem(title: "新建书评", style: UIBarButtonItemStyle.Plain, target: self, action: "push")
        self.navigationItem.leftBarButtonItems = [button1, button2]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)  //返回按钮文字空

    }
    //action
    func push(){
        //ViewController转场方式 UIModalTransitionStyleCoverVertical 默认值，从下向上覆盖
        //UIModalTransitionStyleFlipHorizontal 水平翻转
        //UIModalTransitionStylePartialCurl 书页翻开显示下面的视图
        let newListVC = NewListViewController()
        self.navigationController?.pushViewController(newListVC, animated: true)
    }
    
    func loadImageView(){
        self.imageView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 220)
        self.imageView.image = UIImage(named: "blank.png")
        self.imageView.alpha = 0.5
        self.view.addSubview(self.imageView)
    }

    func loadLabel(){
        self.label.frame = CGRectMake((SCREEN_WIDTH - 250) / 2, SCREEN_HEIGHT - 150, 250, 30)
        self.label.text = "快来分享你的第一本书吧~~"
        self.label.alpha = 0.2
        self.label.textColor = UIColor.orangeColor()
        self.view.addSubview(self.label)
    }
    
    func loadTableView(){
        self.tableView.frame = UIScreen.mainScreen().bounds
        self.tableView.registerClass(NewTableViewCell.self, forCellReuseIdentifier: "NewCell")
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = 60
        self.view.addSubview(self.tableView)
        //MJRefresh
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "headerRefresh")
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
        self.tableView.mj_header.beginRefreshing()

    }
    //下拉刷新
    func headerRefresh(){
        let query = AVQuery(className: "BookComment")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = 0
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.tableView.mj_header.endRefreshing()
            self.dataArray.removeAllObjects()
            self.dataArray.addObjectsFromArray(results)
            self.tableView.reloadData()
        }
    }
    //上拉加载
    func footerRefresh(){
        let query = AVQuery(className: "BookComment")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = self.dataArray.count
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.tableView.mj_footer.endRefreshing()
            self.dataArray.addObjectsFromArray(results)
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NewViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {         let cell = tableView.dequeueReusableCellWithIdentifier("NewCell", forIndexPath: indexPath) as? NewTableViewCell
        let data = self.dataArray[indexPath.row] as? AVObject
        cell?.Book_Title.text = data!["Book_Title"] as? String
        cell?.Book_Author.text = data!["Book_Author"] as? String
        cell?.Book_Image.image = UIImage(named: "Cover")
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //不加上下面这一句，返回的时候该cell选中状态；加上这一句，返回的时候是非选中状态
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = BookCommentViewController()
        vc.bookObject = (self.dataArray[indexPath.row] as? AVObject)!
        //跳转之后隐藏tabbar
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            let object = self.dataArray[indexPath.row] as? AVObject
            let id = object!["objectId"] as? String
            let commentQuery = AVQuery(className: "BookComment")
            commentQuery.whereKey("objectId", equalTo: id)
            commentQuery.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                for object in results{
                    object.deleteInBackground()
                }
            })
            
            let discussQuery = AVQuery(className: "discuss")
            discussQuery.whereKey("Book_Title", equalTo: object)
            discussQuery.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                if results != nil && results.count != 0{
                    for object in results{
                        object.deleteInBackground()
                    }
                }

            })
            
            let loveQuery = AVQuery(className: "love")
            loveQuery.whereKey("Book_Title", equalTo: object)
            loveQuery.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                if results != nil && results.count != 0{
                    for object in results{
                        object.deleteInBackground()
                    }
                }
            })
            
            object?.deleteInBackgroundWithBlock({ (success, error) -> Void in
                if success{
                    SVProgressHUD.showSuccessWithStatus("删除成功")
                    self.dataArray.removeObjectAtIndex(indexPath.row)
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
                    self.tableView.reloadData()
                }else{
                    SVProgressHUD.showErrorWithStatus("删除失败")
                }
            })

        }
        return [deleteAction]
    }
}
