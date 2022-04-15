//
//  ViewEventsViewController.swift
//  Team-Bravo
//
//  Created by Abdulla Karjikar on 4/13/22.
//

import UIKit
import Firebase

class ViewEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var eventsTableView: UITableView!
    // MARK: - Welcome
    struct Welcome: Decodable {
        let allDataRetrieved: Bool
        let events: [Event]
    }

    // MARK: - Event
    struct Event: Decodable {
        var EID: String
        var org_id: String
        var date: String
        var description: String
        var start_time: String
        var end_time: String
        var location: String
    }
    
    
    
    struct FirebaseEvent: Identifiable{
        var id: String = UUID().uuidString
        var end_date: String
        var end_time: String
        var event_description: String
        var event_name: String
        var location: String
        var start_date: String
        var start_time: String
    }

    var firebasedata = [FirebaseEvent]()
    
    var pastEvents = [FirebaseEvent]()
    
    var eventsList = [Event]()
    var results = [(String, String)]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()


//        retrieveData{
//            data in
//            self.eventsList = data
//            DispatchQueue.main.async {
//                self.eventsTableView.reloadData()
//            }
//        }
        
        fetchDataFromFirebase{
            data in
            self.firebasedata = data
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        }
        eventsTableView.layer.cornerRadius=10
        eventsTableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        eventsTableView.delegate = self
        eventsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func fetchDataFromFirebase(comp: @escaping ([FirebaseEvent])->()){
        let db = Firestore.firestore()
        db.collection("events").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            self.firebasedata = documents.map{(queryDocumentSnapshot) -> FirebaseEvent in
                let data = queryDocumentSnapshot.data()
                
                let end_date_ = data["end_date"] as? String ?? ""
                let end_time_ = data["end_time"] as? String ?? ""
                let event_description_ = data["event_description"] as? String ?? ""
                let event_name_ = data["event_name"] as? String ?? ""
                let location_ = data["location"] as? String ?? ""
                let start_date_ = data["start_date"] as? String ?? ""
                let start_time_ = data["start_time"] as? String ?? ""
                //print("********* ", event_name_, " - ", event_description_, " - ", location_)
                
                
                
                
                return FirebaseEvent(end_date: end_date_, end_time: end_time_, event_description: event_description_, event_name: event_name_, location: location_, start_date: start_date_, start_time: start_time_)
            }
            
            comp(self.firebasedata)
        }
    }
    
    
    func retrieveData(comp: @escaping ([Event])->()){
        
        // Setting the URL
        let urlString =  "https://cs.okstate.edu/~akarjik/retrieveEventsAPI.php"
        guard let url = URL(string: urlString)
        else
        {
            return
        }
        
        // This closure will get the data from URL and will check if the data being returned is empty or is there any error.
        let task = URLSession.shared.dataTask(with: url)
        {(data, response, error) -> Void in
            // Check to see if any error was encountered.
            guard error == nil  else {
                print("URL Session error: \(error!)")
                return
            }
            // Check to see if we received any data.
            guard let data = data else {
                print("No data received")
                return
            }
            var resultLocal: [(String, String)] = []
            do {
                // Decoding the JSON response in the JSONResponse structure.
                let jsonResponse = try JSONDecoder().decode(Welcome.self,
                                                            from: data)
                // Storing just name and nickname for all the rows into local object as we have ID as well in the response being returned.
                //for eachStateDetail in jsonResponse.events{
                    //resultLocal.append((eachStateDetail.description, eachStateDetail.location))
                //}
                comp(jsonResponse.events)
                
            } catch let error as NSError {
                print("Error serializing JSON Data: \(error)")
            }
            
        }
        task.resume()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return eventsList.count
        return firebasedata.count
    }
    
    // This will load the each element on to the table veiw and will reuse the cell if it goes out of screen.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        // Fetching the cell data from the array. indexPath[1] holds the each values for a section.
//        let cellData = eventsList[indexPath[1]]
//        let eventTime = cellData.start_time + " - " + cellData.end_time
//        cell.configure(eventName_: cellData.description, eventTime_: eventTime, month_: "APR", date_: cellData.date)
        let data = firebasedata[indexPath[1]]
        let st_time_sep = data.start_time.split(separator: ":")
        let st_time = st_time_sep[0] + ":" + st_time_sep[1] + " " + st_time_sep[2].split(separator: " ")[1]
        let end_time_sep = data.end_time.split(separator: ":")
        let end_time = end_time_sep[0] + ":" + end_time_sep[1] + " " + end_time_sep[2].split(separator: " ")[1]
        let eventTime = st_time + " - " + end_time
        let st_date = data.start_date.split(separator: " ")
        let month = st_date[0].uppercased()
        let date = st_date[1].replacingOccurrences(of: ",", with: "")
        
        
        var dateComponents = DateComponents()
        dateComponents.year = 1980
        dateComponents.month = 7
        dateComponents.day = 11
        dateComponents.timeZone = TimeZone(abbreviation: "JST") // Japan Standard Time
        dateComponents.hour = 8
        dateComponents.minute = 34

        print(dateComponents.date)


        cell.configure(eventName_: data.event_name, eventTime_: eventTime, month_: month, date_: date)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    
    
    
   
    
}




