//
//  NewTableViewCell.swift
//  ZCBook
//
//  Created by 曾超 on 16/2/21.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    
    var Book_Title = UILabel()
    var Book_Author = UILabel()
    var Book_Image = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.Book_Title.frame = CGRectMake(78, 8, 242, 25)
        self.Book_Author.frame = CGRectMake(78, 33, 242, 25)
        self.Book_Image.frame = CGRectMake(0, 0, 50, 50)
        self.contentView.addSubview(self.Book_Title)
        self.contentView.addSubview(self.Book_Author)
        self.contentView.addSubview(self.Book_Image)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
