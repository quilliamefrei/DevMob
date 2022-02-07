//
//  DataProtocol.swift
//  EventSchedule
//
//  Created by goldorak on 07/02/2022.
//

import Foundation

protocol DataProtocol {
    func createRequest(urlStr: String, requestType: RequestType, params: [String]?) -> URLRequest
    func getScheduleList(callback: @escaping ((errorType: CustomError?,
     errorMessage: String?), [Schedule]?) -> Void)
    func deleteSchedule(with id: String, callback: @escaping ((errorType:
     CustomError?, errorMessage: String?), Response?) -> Void)
}
