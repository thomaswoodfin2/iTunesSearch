//
//  Helper.swift
//  TestApp
//
//  Created by Thomas Woodfin  on 26/7/19.
//  Copyright © 2019 Thomas Woodfin . All rights reserved.
//

import UIKit
import Alamofire

struct Helper{

    
    static func emptyMessageInTableView(_ tableView: UITableView,_ title: String){
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.textColor        = UIColor(red: 67, green: 67, blue: 67)
        noDataLabel.font             = UIFont(name: "Open Sans", size: 15)
        noDataLabel.textAlignment    = .center
        tableView.backgroundView = noDataLabel
        tableView.separatorStyle = .none
        noDataLabel.text = title
    }

    static func getDate(time:Int)->String{
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    static func loadJSON(jsonFileName name: String) -> Data?
    {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("error)")
            }
        }
        return nil
    }

  
    private static func getCompressedImgData(_ image:UIImage) -> Data? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return nil}
        let bytes = imageData.count
        let KB = Double(bytes) / 1024.0 // Note the difference
        let MB = KB/1024
        print("Image Size KB = \(KB), MB = \(MB)")
        return imageData
    }

}

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
