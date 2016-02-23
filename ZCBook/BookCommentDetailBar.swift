//
//  BookCommentDetailBar.swift
//  ZCBook
//
//  Created by 曾超 on 16/2/23.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class BookCommentDetailBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        let imageName = ["Pen 4","chat 3","heart","box outgoing"]
        
        for i in 0..<4{
            let btn = UIButton(frame: CGRectMake(CGFloat(i)*frame.size.width/4,0,frame.size.width/4,frame.size.height))
            btn.setImage(UIImage(named: imageName[i]), forState: UIControlState.Normal)
            //tag值不能为0
            btn.tag = i + 1
            self.addSubview(btn)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: 绘制线条的方法
    override func drawRect(rect: CGRect) {
        //获得当前的上下文
        let context = UIGraphicsGetCurrentContext()
        //设置线条的宽度
        CGContextSetLineWidth(context, 0.5)
        //设置线条的颜色
        CGContextSetRGBStrokeColor(context, 231/255,231/255,231/255,1)
        for var i = 1; i < 4; i = i + 1{
            //起始点
            CGContextMoveToPoint(context, CGFloat(i)*rect.size.width/4, rect.size.height*0.1)
            //下一坐标点
            CGContextAddLineToPoint(context, CGFloat(i)*rect.size.width/4, rect.size.height*0.9)
        }
        
        CGContextMoveToPoint(context, 8, 0)
        CGContextAddLineToPoint(context, rect.size.width - 8, 0)
        //连接以上坐标点
        CGContextStrokePath(context)
    }
}
