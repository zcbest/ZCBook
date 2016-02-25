//
//  BookCommentAreaCell.swift
//  ZCBook
//
//  Created by 曾超 on 16/2/24.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class BookCommentAreaCell: UITableViewCell {

    var userImage: UIImageView?
    var userName: UILabel?
    var comment: UILabel?
    var date: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initFrame()
    }
    
    func initFrame(){
        //每次复用之前 先删除之前的格式
        for view in self.contentView.subviews{
            view.removeFromSuperview()
        }
        self.userImage = UIImageView(frame:CGRectMake(8, 8 , 40, 30))
        self.userImage?.layer.cornerRadius = 30
        self.userImage?.layer.masksToBounds = true
        self.contentView.addSubview(self.userImage!)
        
        self.date = UILabel(frame: CGRectMake(56,8,SCREEN_WIDTH - 64, 15))
        self.date?.font = UIFont.systemFontOfSize(15)
        self.contentView.addSubview(self.date!)
        
        self.comment = UILabel(frame: CGRectMake(56,23,SCREEN_WIDTH,self.frame.size.height - 23))
        self.comment?.font = UIFont.systemFontOfSize(15)
        self.comment?.numberOfLines = 0
        self.contentView.addSubview(self.comment!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
