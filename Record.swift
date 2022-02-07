//
//  Record.swift
//  EventSchedule
//
//  Created by goldorak on 07/02/2022.
//

import Foundation

//structure de schedule

struct Records: Codable {
    let records: [Schedule]?
}

struct Schedule: Codable {
    let id: String
    let fields: Fields
    let createdTime: String
}
    
struct Fields: Codable{
    let end: String
    let activity: String
    let typeM: String
    let start: String
    let location: [String]
    let topics: [String]
    let speakers: [String]
    let notes: String
}

enum CustomError: Error {
    case requestError
    case statusCodeError
    case parsingError
}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

struct Response: Codable {
    let id: String
    let deleted: Bool
}

struct ErrorResponse: Codable {
    let error: String
}

let furnitureUrlStr =
 "https://api.airtable.com/v0/appurgriHL535VVAP/Furniture"
