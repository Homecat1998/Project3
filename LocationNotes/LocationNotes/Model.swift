//
//  Model.swift
//  LocationNotes
//
//  Created by Zhong, Zhetao on 12/1/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import Foundation

let kAppGroupBundleID           = "group.com.examples.LocationNotes"

/*
 ** default items
 */
let dAppVersion                 = "app_version"
let dNumLaunches                = "num_launches"
let dAccessDate                 = "accessDate"

struct NoteItem: Equatable, Codable {
    var weather : String
    var temp : String
    var humidity : String
    var lat : String
    var lon : String
    var city : String
    var note : String
    var date : Date
}

class Notes: Codable {
    
    var noteList = [NoteItem]()

    
    func add(note: String, weather: String, temp: String, humidity: String, lat: String, lon: String, city: String) {
        
        let noteItem = NoteItem(weather: weather, temp: temp, humidity: humidity, lat: lat, lon: lon, city: city, note: note, date: Date())
        noteList.insert(noteItem, at: 0)
    }
    
    func removeItem(at index: Int) {
        if let _ = noteList[index] as NoteItem? {
            noteList.remove(at: index)
        }
    }
}
