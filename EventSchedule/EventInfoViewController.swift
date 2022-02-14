import UIKit


class EventInfoViewController: UIViewController
{
    
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventSpeakers: UILabel!
    
    var destinationEvent : Event = Event(name: "DEFAULT")
    
	override func viewDidLoad()
	{
		super.viewDidLoad()
        
        eventName.text = destinationEvent.name
        eventLocation.text = destinationEvent.location
        eventSpeakers.text = destinationEvent.speaker
		
	}

}
