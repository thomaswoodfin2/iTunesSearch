//
//  HomeVM.swift
//  TestApp
//
//  Created by Thomas Woodfin on 4/24/20.
//  Copyright © 2020 Thomas Woodfin . All rights reserved.
//

import Foundation
import SVProgressHUD
import SwiftyJSON

class HomeVM{
    
    var searchList: [SearchData]?
    
    
    var dic = [String: [SearchData]]()
    var searchDic = [String: [SearchData]]()
    
    func getData(completion: @escaping (_ success: Bool) -> Void) {
        SVProgressHUD.show()
        
        APIClient.shared.checkMockdata(fileName: "searchResponse", modelType: SearchResponse.self) { (response) in
            switch response {
            case .success(let response ):
                guard let list = response.searchList else {return}
                self.searchList = list
                self.setFilter(searchList: list)
                completion(true)
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func setFilter(searchList: [SearchData]){
        var kindSets = Set<String>()
        dic.removeAll()
        let filterData = searchList.filter({ (model) -> Bool in
            guard let kind = model.kind else {return false}
            return !kind.isEmpty
        })
        for arr in filterData{
            let kind = arr.kind ?? ""
            if !kind.isEmpty{
                kindSets.insert(kind)
            }
        }
        
        let list = filterData
        for data in kindSets{
            let firstSet = list.filter { (model) -> Bool in
                return model.kind == data
            }
            
            dic[data] = firstSet
        }
        
    }
}
