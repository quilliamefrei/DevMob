//
//  LaunchTest.swift
//  EventSchedule
//
//  Created by goldorak on 07/02/2022.
//

import Foundation
import UIKit

class LaunchTest {
    func main() {
        print("coucou")
        let modelData = ModelData()
        
        modelData.getScheduleList { (errorHandle, schedules) in
            
            if let _ = errorHandle.errorType, let errorMessage =
                 errorHandle.errorMessage {
                    print(errorMessage)
                }
            
            else {
                for schedule in schedules ?? []{
                    print(schedule)
                }
            }
        }
    }
}
