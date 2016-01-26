//
//  NewListViewController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/25.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class NewListViewController: UIViewController {

    var closeButton = UIButton()
    var pushButton = UIButton()
    var newListView = NewListView()
    
    var picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        //加载关闭和发布按钮
        loadButtons()
        //加载封面，书名，作者视图
        loadNewsListView()
    }

    func loadButtons(){
        self.closeButton.frame = CGRectMake(0, 20, 45, 20)
        self.closeButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.closeButton.setTitle("关闭", forState: UIControlState.Normal)
        self.closeButton.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.closeButton)

        self.pushButton.frame = CGRectMake(SCREEN_WIDTH - 45, 20, 45, 20)
        self.pushButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.pushButton.setTitle("发布", forState: UIControlState.Normal)
        self.pushButton.addTarget(self, action: "push", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.pushButton)
    }
    
    func loadNewsListView(){
        self.newListView.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT / 3)
        self.newListView.imageButton.addTarget(self, action: "addCoverAlert", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.newListView)
    }
    
    func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func push(){
        print("发布")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
