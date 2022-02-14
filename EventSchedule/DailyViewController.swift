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
    let dateStr = "15/11/2019"
    var dateFormatter = DateFormatter()
    var dateFormatterTEST = DateFormatter()
    var eventsList = [Event]()
    var selectedDate = Date()
    
	override func viewDidLoad()
	{
		super.viewDidLoad()
        dateFormatter.dateFormat = "dd/MM/yy"
        dateFormatterTEST.dateFormat = "dd/MM/yy'T'HH:mm:ss"
        selectedDate = dateFormatter.date(from: dateStr)!
        let event1 = Event(id: 1, name: "EVENT_NUM_1", date: (dateFormatterTEST.date(from: "15/11/2019T15:30:00")!), speaker: "Remi RIANDIERE", location: "Amphi")
        let event2 = Event(id: 1, name: "EVENT_NUM_2", date: (dateFormatterTEST.date(from: "15/11/2019T09:30:00")!), speaker: "Quilliam LECOQ", location: "B007")
        let event3 = Event(id: 2, name: "EVENT_NUM_3", date: (dateFormatterTEST.date(from: "16/11/2019T11:00:00")!), speaker: "Quentin VILCOT", location: "Cafet")
        eventsList.append(event1)
        eventsList.append(event2)
        eventsList.append(event3)
		initTime()
		setDayView()
        let launch = LaunchTest()
        launch.main()
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
        let firstDay = dateFormatter.date(from: "15/11/2019")!
        if(selectedDate > firstDay){
            previousDayButton.isHidden = false
            nextDayButton.isHidden = true
        } else{
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
            print(event.date)
            //print(date)
            if(event.date == date)
            {
                let eventHour = CalendarHelper().hourFromDate(date: event.date)
                print(eventHour)
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
        let secondDay = dateFormatter.date(from: "16/11/2019")!
        if(selectedDate < secondDay){
            selectedDate = CalendarHelper().addDays(date: selectedDate, days: 1)
            setDayView()
        }
	}
	
	@IBAction func previousDayAction(_ sender: Any)
	{
        let firstDay = dateFormatter.date(from: "15/11/2019")!
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
