//
//  NewListViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/25.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit
import SVProgressHUD

class NewListViewController: UIViewController {
    
    var pushButton = UIButton()
    var newListView = NewListView()
    var picker = UIImagePickerController()
    var tableView = UITableView()
    var arrayList:[String] = ["标题","评分","分类","书评"]
    //书评标题
    var Book_Title = ""
    var Book_Description = ""
    var showScore = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)  //返回按钮文字空
        //加载发布按钮
        loadPushButtons()
        //加载封面，书名，作者视图
        loadNewsListView()
        //加载tableView
        loadTableView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pushBookNotification:", name: "pushBookNotification", object: nil)
    }

    func loadPushButtons(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.Plain, target: self, action: "push")
    }
    
    func loadNewsListView(){
        self.newListView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT / 3)
        self.newListView.imageButton.addTarget(self, action: "addCoverAlert", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.newListView)
    }
    
    func loadTableView(){
        self.tableView = UITableView(frame: CGRectMake(0, 40 + SCREEN_HEIGHT / 3 , SCREEN_WIDTH, 2 * SCREEN_HEIGHT / 3 - 40), style: UITableViewStyle.Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //清除tableView多余的cell的分割线
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
    }
    
    func push(){
        self.newListView.Book_Name.resignFirstResponder()
        self.newListView.Book_Author.resignFirstResponder()
        
        let dic = [
            "Book_Title":self.newListView.Book_Name.text!,
            "Book_Author":self.newListView.Book_Author.text!,
            "BookComment_Title":self.Book_Title,
            "BookComment_Description":self.Book_Description
        ]
        
        BookCommentModel.loadData(dic)
    }
    
    func pushBookNotification(notification: NSNotification){
        let info = notification.userInfo
        if info!["result"]as! String == "true"{
            SVProgressHUD.showSuccessWithStatus("上传成功")
        }else{
            SVProgressHUD.showErrorWithStatus("上传失败")
        }
    }
    //imageButton的Action方法
    func addCoverAlert(){
        //设置picker的代理
        self.picker.delegate = self
        self.picker.allowsEditing = true

        let coverAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        coverAlertController.addAction(cancelAction)
        
        let cameraAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.openCamera()
        }
        coverAlertController.addAction(cameraAction)
        
        let chooseAction = UIAlertAction(title: "从相册中选取", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.openPhotoLibrary()
        }
        coverAlertController.addAction(chooseAction)
        presentViewController(coverAlertController, animated: true, completion: nil)
    }
    //打开相机
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            self.picker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(self.picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "此相机机型没有", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "关闭", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    //打开相册
    func openPhotoLibrary(){
        self.picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(self.picker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Swift内存管理是ARC方式，没有发生内存泄露会执行
    deinit{
        print("NewListViewController released")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "pushBookNotification", object: nil)

    }
}

extension NewListViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = arrayList[indexPath.row]
        if indexPath.row != 1{
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }

        let index = indexPath.row
        switch index{
        case 0:
            cell.detailTextLabel?.text = self.Book_Title
        case 1:
    
            break
        case 2:
            break
        case 3:
            break
        case 4:
            cell.accessoryType = UITableViewCellAccessoryType.None
            let textView = UITextView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 88))
            textView.text = self.Book_Description
            textView.editable = false
            cell.contentView.addSubview(textView)
        default:
            break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var index = indexPath.row
        
        if self.showScore == false && index > 1{
            index = index - 1
        }
        
        switch index{
        case 0:
            let vc = NewList_TitleViewController()
            //Swift闭包不会造成内存泄露
            vc.callback = {(title: String) -> Void in
                self.Book_Title = title
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: false)
        case 1:
            //点击cell插入一行
            let path = [NSIndexPath(forRow: 2, inSection: 0)]
            self.tableView.beginUpdates()
            if self.showScore{
            self.arrayList.insert("  评分等级", atIndex: 2)
            self.tableView.insertRowsAtIndexPaths(path, withRowAnimation: UITableViewRowAnimation.Left)
                self.showScore = false
            }else{
                self.arrayList.removeAtIndex(2)
                self.tableView.deleteRowsAtIndexPaths(path, withRowAnimation: UITableViewRowAnimation.Right)
                self.showScore = true
            }
            self.tableView.endUpdates()
        case 2:
            self.navigationController?.pushViewController(NewList_CategoryViewController(), animated: true)
        case 3:
            let vc = NewList_DescriptionViewController()
            vc.callback = {(description: String) -> Void in
                self.Book_Description = description
                //如果书评description不为空，则增加一个cell展示
                if self.Book_Description != ""{
                self.arrayList.append("")
                self.tableView.reloadData()
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
    }
}

extension NewListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    /**
     Description:选择完照片之后进行的回调方法
     */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.newListView.imageButton.setImage(image, forState: UIControlState.Normal)
        //选取好图片之后，跳回到原页面
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    /**
     Description:cancel之后的回调方法
     */
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
