//
//  APIEndPoints.swift
//  TestApp
//
//  Created by Thomas Woodfin  on 26/7/19.
//  Copyright © 2019 Thomas Woodfin . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//MARK:- EmployeeData
enum EmployeeDataEndPoint: Endpoint {
    
    case GetEmployeeData
    
    var method: HTTPMethod {
        switch self {
        case .GetEmployeeData:
            return .get
        
        }
    }
    
    var path: String {
        switch self {
        case .GetEmployeeData:
            return KBasePath + OauthPath.getEmployeeList.rawValue
            
        }
    }
    
    var query: [String: Any]  {
        switch self {
        case .GetEmployeeData:
            return [String: Any]()
    
        }
    }
}


//MARK:- EmployeeData
enum HomeDataEndPoint: Endpoint {
    
    case getSearchData
    
    var method: HTTPMethod {
        switch self {
        case .getSearchData:
            return .get
        
        }
    }
    
    var path: String {
        switch self {
        case .getSearchData:
            return KBasePath + OauthPath.searchData.rawValue
            
        }
    }
    
    var query: [String: Any]  {
        switch self {
        case .getSearchData:
            return [String: Any]()
    
        }
    }
}
