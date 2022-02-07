//
//  LaunchTest.swift
//  EventSchedule
//
//  Created by goldorak on 07/02/2022.
//

import Foundation
import UIKit

class LaunchTest {

    let modelData = ModelData()
    
    modelData.getScheduleList { (errorHandle, schedules) in
        if let _ = errorHandle.errorType, let errorMessage = errorHandle.errorMessage {
            print(errorMessage)
        }
        else if let list = schedules, let schedule = list.last {
            print(schedule.id)
        }
        else {
            print("Houston we got a problem")
        }
    }
}
