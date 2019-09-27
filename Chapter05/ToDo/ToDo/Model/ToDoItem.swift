//
//  ToDoItem.swift
//  ToDo
//
//  Created by dasdom on 12.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import Foundation

struct ToDoItem: Equatable {
  let title: String
  let itemDescription: String?
  let timestamp: Double?
  let location: Location?
  
  init(title: String,
       itemDescription: String? = nil,
       timestamp: Double? = nil,
       location: Location? = nil) {
    
    self.title = title
    self.itemDescription = itemDescription
    self.timestamp = timestamp
    self.location = location
  }
  
  public static func ==(lhs: ToDoItem,
                        rhs: ToDoItem) -> Bool {
    
    
    if lhs.location != rhs.location {
        //print("location not equal")
      return false
    }
    
    if lhs.timestamp != rhs.timestamp {
        print("timestamp not equal: ")
        print("\t lhs \(String(describing: lhs.timestamp))")
        print("\t rhs \(String(describing: rhs.timestamp))")
      return false
    }
    
    if lhs.itemDescription != rhs.itemDescription {
        //print("itemDescription not equal")
      return false
    }
    
    if lhs.title != rhs.title {
       // print("title not equal")
      return false 
    } 
    
    return true
  }
  
}

