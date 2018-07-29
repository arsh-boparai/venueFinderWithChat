//
//  LocationModel.swift
//  party4upro
//
//  Created by Arshdeep Singh on 2018-07-16.
//  Copyright © 2018 Nancy Sharma. All rights reserved.
//
import Firebase
import UIKit

class GuestList: NSObject {
    let ref2: DatabaseReference?
    
    var guests: [String]?
    
    init(guests: [String]) {
        self.ref2 = nil
         self.guests = guests
   
    }
    
}
