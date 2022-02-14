import Foundation


class Event{
	
    var id: Int
	var name: String
	var date: Date
    var speaker: String
    var location: String
    
    init(name: String){
        self.id = -1;
        self.name = name;
        self.date = Date();
        self.speaker = "ERROR";
        self.location = "ERROR";
    }
    
    init(id: Int, name: String,date: Date, speaker: String, location: String){
        self.id = id;
        self.name = name;
        self.date = date;
        self.speaker = speaker;
        self.location = location;
    }
}
