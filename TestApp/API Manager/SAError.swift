//
//  SAError.swift
//  TestApp
//
//  Created by Thomas Woodfin  on 26/7/19.
//  Copyright © 2019 Thomas Woodfin . All rights reserved.
//

import Foundation

enum SAError: Int {
    case unauthorized   = 401
    case notFound       = 404
    case timeOut        = 408
    case preconditioned = 412
    case invalidParam   = 422
    case soaDown        = 424
    case serverProblem  = 500
}
