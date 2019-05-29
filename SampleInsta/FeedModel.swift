//
//  FeedModel.swift
//  SampleInsta
//
//  Created by Nibha Aggarwal on 28/05/19.
//  Copyright © 2019 Nibha Aggarwal. All rights reserved.
//

import Foundation

struct FeedModel {
    var linkurl: String?
    var mediatype: Int?
    var modelArray = [FeedModel]()
    
    
    
    mutating func paseData(data: [[String: AnyObject]]) -> [FeedModel] {
        for item in data {
            var modelObj = FeedModel()
            modelObj.linkurl = item["linkurl"] as? String
            modelObj.mediatype  = item["mediatype"] as? Int
            modelArray.append(modelObj)
        }
        return modelArray
    }
    
    
    
    
    
    
    
    mutating func parseData(data: [[String: AnyObject]]) -> [FeedModel] {
        for item in data {
            var modelObj = FeedModel()
            modelObj.linkurl = item["linkurl"] as? String
            modelObj.mediatype = item["mediatype"] as? Int
            modelArray.append(modelObj)
        }
        return modelArray
    }
}
