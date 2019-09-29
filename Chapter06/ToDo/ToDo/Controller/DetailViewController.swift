//
//  DetailViewController.swift
//  ToDo
//
//  Created by dasdom on 28.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!            // 标题标签
    @IBOutlet var dateLabel: UILabel!             // 日期标签
    @IBOutlet var locationLabel: UILabel!         // 地点标签
    @IBOutlet var descriptionLabel: UILabel!      // 描述标签
    @IBOutlet var mapView: MKMapView!             // 地图对象
    
    var itemInfo: (ItemManager, Int)?             // 项目信息对象
    
    // 日期格式化对象
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    // 视图显示到屏幕之前调用
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 得到项目信息
        guard let itemInfo = itemInfo else { return }
        // 得到第一个项目
        let item = itemInfo.0.item(at: itemInfo.1)
        // 设置视图的标题文本
        titleLabel.text = item.title
        // 设置视图的地点文本
        locationLabel.text = item.location?.name
        // 设置视图的描述文本
        descriptionLabel.text = item.itemDescription
        // 设置视图的时间文本
        if let timestamp = item.timestamp {
            let date = Date(timeIntervalSince1970: timestamp)
            dateLabel.text = dateFormatter.string(from: date)
        }
        // 设置视图的地图视图信息
        if let coordinate = item.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.region = region
        }
    }
    
    // 完成项目
    func checkItem() {
        if let itemInfo = itemInfo {
            itemInfo.0.checkItem(at: itemInfo.1)
        }
    }
}
