//
//  APIClient.swift
//  TestApp
//
//  Created by Thomas Woodfin  on 26/7/19.
//  Copyright © 2019 Thomas Woodfin . All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON

public enum Result<T> {
    case success(T)
    case failure(ErrorResponse)
}

public enum Response<T> {
    case success(T)
}

typealias CompletionHandler<T> = (Result<T>) -> ()
public typealias ErrorResponse = (Int, Data?, Error)
typealias SocialCompletion = (HTTPURLResponse) -> ()
typealias ResponseCompletion<T> = (Response<T>) -> ()


class APIClient {
    
    private static var privateShared : APIClient?
    
    class var shared: APIClient {
        guard let uwShared = privateShared else {
            privateShared = APIClient()
            return privateShared!
        }
        return uwShared
    }
    
    class func destroy() {
        privateShared = nil
    }
    
    deinit {
        print("deinit singleton")
    }
    
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 62 //second as in backend it's 60
        configuration.timeoutIntervalForResource = 62 //second as in backend it's 60
        return SessionManager(configuration: configuration)
    }()
    
    private init() {
        sessionManager.retrier = OAuth2Handler()
    }
    
    private let preLogHeaders = ["platform" : "ios", "appname" : "testApp"]
    
    
    private var saHeaders: [String:String]? {
        return ["token" :  "token"].merging(preLogHeaders) {$1}
    }
    
    func makeAPICall(apiEndPoint: Endpoint, completion: @escaping CompletionHandler<Any>) {
        Alamofire.request(apiEndPoint.path, method: apiEndPoint.method, parameters: apiEndPoint.query, encoding: apiEndPoint.encoding, headers: saHeaders)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(Result.success(value))
                case .failure(let error):
                    print(error.localizedDescription)
                    guard let statusCode = response.response?.statusCode else {
                        let unKnownError = ErrorResponse(-999, response.data, error)
                        completion(Result.failure(unKnownError))
                        return
                    }
                    let mError = ErrorResponse(statusCode, response.data, error)
                    completion(Result.failure(mError))
                }
        }
    }
    
    func objectAPICall<T: Mappable>(apiEndPoint: Endpoint, modelType: T.Type, completion: @escaping CompletionHandler<T>) {
        sessionManager.request(apiEndPoint.path, method: apiEndPoint.method, parameters: apiEndPoint.query, encoding: apiEndPoint.encoding).validate(statusCode: 200..<300).responseObject { (response: DataResponse<T>) in
            
            switch response.result {
            case .success(let value):
                completion(Result.success(value))
            case .failure(let error):
                print(error.localizedDescription)
                guard let statusCode = response.response?.statusCode else {
                    let unKnownError = ErrorResponse(-999, response.data, error)
                    completion(Result.failure(unKnownError))
                    return
                }
                let mError = ErrorResponse(statusCode, response.data, error)
                completion(Result.failure(mError))
            }
        }.responseString { (response) in
            print(response)
        }
    }
    
    func checkMockdata<T: Mappable>(fileName: String, modelType: T.Type, completion: @escaping ResponseCompletion<T>) {
        let jsonData = Helper.loadJSON(jsonFileName: fileName)
        if let data = jsonData {
            do {
                let response = try JSON(data: data)
                guard let model = modelType.init(JSON: response.dictionaryObject!) else {return}
                
                completion(Response.success(model))
            } catch {
            }
        }
    }
   
}





