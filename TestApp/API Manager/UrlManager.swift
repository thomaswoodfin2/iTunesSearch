//
//  UrlManager.swift
//  TestApp
//
//  Created by Thomas Woodfin  on 26/7/19.
//  Copyright © 2019 Thomas Woodfin . All rights reserved.
//
import Foundation

#if DEVELOPMENT

let KBasePath = "https://itunes.apple.com" // Staging Server
#else

let KBasePath = "https://itunes.apple.com" // Production Server

#endif

enum OauthPath: String {
    
    case getEmployeeList     = "/api/v1/employees"
    
    case searchData          = "/search?term=jack+johnsonm"
}
