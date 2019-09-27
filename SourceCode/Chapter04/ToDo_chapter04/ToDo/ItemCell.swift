//
//  ItemCell.swift
//  ToDo
//
//  Created by dasdom on 25.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!      // 标题
    @IBOutlet var locationLabel: UILabel!   // 地点
    @IBOutlet var dateLabel: UILabel!       // 日期
    
    // 日期格式化对象
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    // 设置对象
    func configCell(with item: ToDoItem,
                    checked: Bool = false) {
        // 如果已检查（完成）
        if checked {
            // 通过title创建属性字符串
            let attributedString = NSAttributedString(
                string: item.title,
                attributes: [NSAttributedString.Key.strikethroughStyle:
                    NSUnderlineStyle.single.rawValue])
            // 设置属性文本属性
            titleLabel.attributedText = attributedString
            // 重置地点标签内容
            locationLabel.text = nil
            // 重置日期标签内容
            dateLabel.text = nil
        }
        // 没有完成
        else {
            // 设置标题文本
            titleLabel.text = item.title
            // 设置地点文本
            locationLabel.text = item.location?.name ?? ""
            // 设置日期文本
            if let timestamp = item.timestamp {
                // 根据对象的时间戳新建日期对象
                let date = Date(timeIntervalSince1970: timestamp)
                // 格式化日期后设置日期标签文本
                dateLabel.text = dateFormatter.string(from: date)
            }
        }
    }
}
