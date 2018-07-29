//
//  SavedViewController.swift
//  party4upro
//
//  Created by Arshdeep Singh on 2018-07-16.
//  Copyright © 2018 Nancy Sharma. All rights reserved.
//
import Firebase
import UIKit

class SavedViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var refArtists: DatabaseReference!
    @IBOutlet weak var listTableView: UITableView!
   
    var partyList = [LocationModel]()

    var ref = Database.database().reference().child("events");
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        refArtists = Database.database().reference().child("events");
        refArtists.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                self.partyList.removeAll()
                for parties in snapshot.children.allObjects as![DataSnapshot]{
                    let partyObject = parties.value as? [String: AnyObject]
                    let partyName = partyObject?["eventName"]
                    let partyTheme = partyObject?["eventTheme"]
                    let partyDate = partyObject?["eventDate"]
                    let partyPlace = partyObject?["eventPlace"]
                  let partyId = partyObject?["id"]
                    
                    
                    let event = LocationModel(name: partyName as! String, theme: partyTheme as! String, place: partyPlace as! String, eventdate: partyDate as! String,id: partyId as! String)
                    self.partyList.append(event)
                }
                self.listTableView.reloadData()
            }
        })

    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            let party: LocationModel
            party = partyList[indexPath.row]
            ref = self.ref.child(party.id!)
            ref.removeValue()
self.partyList.remove(at: indexPath.row)
        self.listTableView.deleteRows(at: [indexPath], with: .automatic)
    listTableView.reloadData()
          
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return partyList.count
        
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! ViewControllerTableViewCell
        
        //the artist object
        let artist: LocationModel
        
        //getting the artist of selected position
        artist = partyList[indexPath.row]
        
        //adding values to labels
        cell.label1.text = "Event Name : "+"\(String(describing: artist.name!))"
        cell.label2.text = "Event Theme : "+"\(artist.theme!)"
        cell.label3.text = "Event Place : "+"\(artist.place!)"
        cell.label4.text = "Event Date : "+"\(artist.eventdate!)"
        
        //returning cell
        return cell
    }

    
}
