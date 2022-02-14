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
    let type: String
    let start: String
    let location: [String]?
    let topics: [String]?
    let speakers: [String]?
    let notes: String?
    enum CodingKeys: String, CodingKey {
        case end = "End"
        case activity = "Activity"
        case type = "Type"
        case start = "Start"
        case location = "Location"
        case topics = "Topic / theme"
        case speakers = "Speaker(s)"
        case notes = "Notes"
    }
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
 "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule"
