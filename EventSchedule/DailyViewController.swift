//
//  DailyViewController.swift
//  CalendarExampleTutorial
//
//  Created by CallumHill on 31/8/21.
//

import UIKit
import Foundation


class DailyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	@IBOutlet weak var hourTableView: UITableView!
	@IBOutlet weak var dayOfWeekLabel: UILabel!
	@IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var previousDayButton: UIButton!
    @IBOutlet weak var nextDayButton: UIButton!
    
    var hours = [Int]()
    var dateFormatterEVENT = DateFormatter()
    var eventsList = [Event]()
    var selectedDate = Date()
    
	override func viewDidLoad ()
	{
		super.viewDidLoad()
        let dateStr = "2019-11-15T08:00:00.000Z"
        dateFormatterEVENT.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        selectedDate = dateFormatterEVENT.date(from: dateStr)!
        getSchedule()
        sleep(1)
		initTime()
		setDayView()
	}
    
    func getSchedule(){
        let modelData = ModelData()
        modelData.getScheduleList { (errorHandle, schedules) in
            
            if let _ = errorHandle.errorType, let errorMessage =
                 errorHandle.errorMessage {
                    print(errorMessage)
                }
            
            else {
                for schedule in schedules ?? []{
                    let neweventDate = self.dateFormatterEVENT.date(from: schedule.fields.start)!
                    let speaker = schedule.fields.speakers?[0]
                    let location =  schedule.fields.location?[0]
                    let newEvent = Event(id: schedule.id, name: schedule.fields.activity, date: neweventDate , speaker: speaker ?? "UNDEFINED", location: location ?? "UNDEFINED")
                    self.eventsList.append(newEvent)
                }
            }
        }
    }
	
	func initTime()
	{
		for hour in 0...23
		{
			hours.append(hour)
		}
	}
	
	func setDayView()
	{
        let firstDay = dateFormatterEVENT.date(from: "2019-11-15T08:00:00.000Z")!
        if(selectedDate > firstDay){
            previousDayButton.isHidden = false
            nextDayButton.isHidden = true
        } else if(selectedDate==firstDay){
            previousDayButton.isHidden = true
            nextDayButton.isHidden = false
        }
        dayLabel.text = CalendarHelper().monthDayString(date: selectedDate)
        dayOfWeekLabel.text = CalendarHelper().weekDayAsString(date: selectedDate)
		hourTableView.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return hours.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellDailyID") as! DailyCell
		
		let hour  = hours[indexPath.row]
		cell.time.text = formatHour(hour: hour)
		
		let events = eventsForDateAndTime(date: selectedDate, hour: hour)
		setEvents(cell, events)
		
		return cell
	}
    
    func eventsForDateAndTime(date: Date, hour: Int) -> [Event]
    {
        var daysEvents = [Event]()
        for event in eventsList
        {
            var order = Calendar.current.compare(date, to: event.date, toGranularity: .day)

            switch order {
            case .orderedDescending:
                break
            case .orderedAscending:
                break
            case .orderedSame:
                let eventHour = CalendarHelper().hourFromDate(date: event.date)
                if eventHour == hour
                {
                    daysEvents.append(event)
                }
            }
        }
        return daysEvents
    }
	
	func setEvents(_ cell: DailyCell, _ events: [Event])
	{
        cell.event1.isHidden = true
		switch events.count
		{
		case 1:
			setEvent(cell, events[0])
		default:
			break
		}
	}

	func setEvent(_ cell: DailyCell, _ event: Event)
	{
		cell.event1.isHidden = false
		cell.event1.setTitle(event.name, for: UIControl.State.normal)
	}
	
	
	func formatHour(hour: Int) -> String
	{
		return String(format: "%02d:%02d", hour, 0)
	}
    
    func  getEventByName(name: String) -> Event{
        for event in eventsList {
            if event.name == name{
                return event
            }
        }
        return Event(name: "ERROR");
    }
	
	@IBAction func nextDayAction(_ sender: Any)
	{
        let secondDay = dateFormatterEVENT.date(from: "2019-11-16T08:00:00.000Z")!
        if(selectedDate < secondDay){
            selectedDate = CalendarHelper().addDays(date: selectedDate, days: 1)
            setDayView()
        }
	}
	
	@IBAction func previousDayAction(_ sender: Any)
	{
        let firstDay = dateFormatterEVENT.date(from: "2019-11-15T08:00:00.000Z")!
        if(selectedDate > firstDay){
            selectedDate = CalendarHelper().addDays(date: selectedDate, days: -1)
            setDayView()
        }
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		setDayView()
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let eventName = ((sender as! UIButton).titleLabel?.text)!;
        let selectedEvent = getEventByName(name: eventName);
        
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destination as! EventInfoViewController
        destinationVC.destinationEvent = selectedEvent
    }
}
