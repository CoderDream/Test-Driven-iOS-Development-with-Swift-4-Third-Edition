//
//  InputViewController.swift
//  ToDo
//
//  Created by dasdom on 28.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!              // 标题输入框
    @IBOutlet var dateTextField: UITextField!               // 日期输入框
    @IBOutlet var locationTextField: UITextField!           // 地点输入框
    @IBOutlet var addressTextField: UITextField!            // 地址输入框
    @IBOutlet var descriptionTextField: UITextField!        // 描述输入框
    @IBOutlet var saveButton: UIButton!                     // 保存按钮
    
    lazy var geocoder = CLGeocoder()                        // 地理位置对象
    var itemManager: ItemManager?                           // 项目管理器
    // 日期格式化器
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    // 保存方法
    @IBAction func save() {
        // 获取标题输入框的内容字符串
        guard let titleString = titleTextField.text,
            titleString.count > 0 else { return }
        // 获取日期文本并转换成日期类型的对象
        let date: Date?
        if let dateText = self.dateTextField.text,
            dateText.count > 0 {
            date = dateFormatter.date(from: dateText)
        } else {
            date = nil
        }
        // 获取描述输入框的内容字符串
        let descriptionString = descriptionTextField.text
        // 获取地点输入框的内容字符串，如果有地点信息，继续
        if let locationName = locationTextField.text,
            locationName.count > 0 {
            // 如果有地址信息
            if let address = addressTextField.text,
                address.count > 0 {
                // 通过地址反解析地理位置
                geocoder.geocodeAddressString(address) {
                    [unowned self] (placeMarks, error) -> Void in
                    // 得到第一个地点标签
                    let placeMark = placeMarks?.first
                    // 打印
                    print("timestamp: \(String(describing: date?.timeIntervalSince1970))")
                    // 根据标题、描述、日期和地点信息创建事项对象
                    let item = ToDoItem(
                        title: titleString,
                        itemDescription: descriptionString,
                        timestamp: date?.timeIntervalSince1970,
                        location: Location(
                            name: locationName,
                            coordinate: placeMark?.location?.coordinate))
                    // 添加事项对象
                    self.itemManager?.add(item)
                }
            }
        }
        dismiss(animated: true)
    }
}
