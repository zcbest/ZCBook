//
//  MainTabBarController.swift
//  ZCBook
//
//  Created by 曾超 on 16/1/25.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //建立TabBarController的子视图控制器
        setUpAllChildViewController()
    }

    func setUpAllChildViewController(){
        tabBarAddChildViewController(RankingViewController(), title: "排行榜", imageName: "bio", selectedImageName: "bio_red")
        tabBarAddChildViewController(DiscoveryViewController(), title: "发现", imageName: "timer 2", selectedImageName: "timer 2_red")
        tabBarAddChildViewController(NewViewController(), title: "", imageName: "pencil", selectedImageName: "pencil_red")
        tabBarAddChildViewController(CircleViewController(), title: "圈子", imageName: "users two-2", selectedImageName: "users two-2_red")
        tabBarAddChildViewController(MoreViewController(), title: "更多", imageName: "more", selectedImageName: "more_red")
    }
    
    func tabBarAddChildViewController(vc: UIViewController, title: String, imageName: String, selectedImageName: String){
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        let nav = MainNavigationController(rootViewController: vc)
        self.addChildViewController(nav)
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
