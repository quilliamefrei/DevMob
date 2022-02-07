//
//  ModelData.swift
//  EventSchedule
//
//  Created by goldorak on 07/02/2022.
//

import Foundation

class ModelData: DataProtocol {
     
    internal func createRequest(urlStr: String, requestType: RequestType, params: [String]?) -> URLRequest {
        var url: URL = URL(string: urlStr)!
                if let params = params {
                    var urlParams = urlStr
                    for param in params {
                        urlParams = urlParams + "/" + param
                    }
                    print(urlParams)
                    url = URL(string: urlParams)!
                }
                var request = URLRequest(url: url)
                request.timeoutInterval = 100
                request.httpMethod = requestType.rawValue
                let accessToken = "keyPKn8B0EAKwScNU"
                request.setValue("Bearer \(accessToken)", forHTTPHeaderField:
                 "Authorization")
                return request
    }
    
    func getScheduleList(callback: @escaping ((errorType: CustomError?, errorMessage: String?), [Schedule]?) -> Void) {
        let session = URLSession(configuration: .default)
                let task = session.dataTask(with: createRequest(urlStr: furnitureUrlStr,requestType: .get,params: nil)) { (data, response, error) in
                    if let data = data, error == nil {
                        if let responseHttp = response as? HTTPURLResponse {
                            if responseHttp.statusCode == 200 {
                                if let response = try?
                                 JSONDecoder().decode(Records.self, from: data){
                                    callback((nil, nil), response.records)
                                } else {
                                    callback((CustomError.parsingError, "parsing error"), nil)
                                }
                            } else {
                                callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                                }
                            }
                        } else {
                            callback((CustomError.requestError,
                            error.debugDescription), nil)
                        }
                    }
                task.resume()
    }
    
    func deleteSchedule(with id: String, callback: @escaping ((errorType: CustomError?, errorMessage: String?), Response?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr: furnitureUrlStr,requestType: .delete, params: [id])) { (data, response, error) in
            if let data = data, error == nil {
                        if let responseHttp = response as? HTTPURLResponse {
                            if responseHttp.statusCode == 200 {
                                if let response = try?
                                 JSONDecoder().decode(Response.self, from: data) {
                                    callback((nil, nil), response)
                                }
                                else if let response = try?
                                 JSONDecoder().decode(ErrorResponse.self, from: data) {
                                    callback((CustomError.requestError,
                                     response.error), nil)
                                } else {
                                    callback((CustomError.parsingError, "parsing error"), nil)
                                }
                                              
                            } else {
                                callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                            }
                        }
                    } else {
                        callback((CustomError.requestError,
                         error.debugDescription), nil)
                    }
            }
            task.resume()
    }
}
