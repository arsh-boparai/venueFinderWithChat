//
//  LocationModel.swift
//  party4upro
//
//  Created by Arshdeep Singh on 2018-07-16.
//  Copyright © 2018 Nancy Sharma. All rights reserved.
//
import Firebase
import UIKit

class LocationModel: NSObject {
     let ref: DatabaseReference?
    let id: String?
    var name: String?
    var theme: String?
    var place: String?
    
   
    
    var eventdate: String?
 //var guests: [String]?
    
    
  
    
    
    init(name: String,theme: String, place: String, eventdate: String,id: String) {
       // self.guests = guests
        self.name = name
        self.theme = theme
        self.place = place
        self.ref = nil
        self.id = id
        self.eventdate = eventdate
       
        
        
    }
    
    
    //prints object's current stat
    
    
    
}
