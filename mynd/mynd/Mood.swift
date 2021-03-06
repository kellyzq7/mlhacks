//
//  Mood.swift
//  mynd
//
//  Created by Kelly Jia on 6/25/22.
//

import Foundation
import UIKit

struct Mood : Codable {
    var date: String
    var overallMood: Int
    var somethingFun: Bool
    var highlights: String
    var onMyMind: String

    
    init(date: String, overallMood: Int = 5, somethingFun: Bool = true, highlights: String = "", onMyMind: String = "") {
        self.date = date
        self.overallMood = overallMood
        self.somethingFun = somethingFun
        self.highlights = highlights
        self.onMyMind = onMyMind
    }
    
    mutating func update(overallMood: Int = 5, somethingFun: Bool = true, highlights: String = "", onMyMind: String = "") {
        self.overallMood = overallMood
        self.somethingFun = somethingFun
        self.highlights = highlights
        self.onMyMind = onMyMind
    }
    
    func getWeekdayName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let today = dateFormatter.date(from: self.date)!
        
        let weekFormatter = DateFormatter()
        weekFormatter.dateFormat = "EEEE"
        return weekFormatter.string(from: today)
    }
}

struct MoodBook {
    static var moods = [Mood]()
    static var selectedIndex : Int = 0
    
    static func initMoods() {
        moods = loadMoods();
        if (moods.isEmpty) {
            moods.append(Mood(date: "2022-06-23", overallMood: 9, somethingFun: true, highlights: "lunch with friends", onMyMind: "need more sleep"))
            moods.append(Mood(date: "2022-06-24", overallMood: 7, somethingFun: true, highlights: "hackathon starts", onMyMind: "lots of errors in xcode"))
            moods.append(Mood(date: "2022-06-25", overallMood: 8, somethingFun: false, highlights: "hackathon", onMyMind: "sophomore bench kickoff planning"))
        }
    }
    
    static func count() -> Int {
        return moods.count
    }
    
    static func getItem(index: Int) -> Mood {
        return moods[index];
    }
    
    static func getTodayMood() -> Mood {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayID = dateFormatter.string(from: today)
        if (moods.isEmpty || moods.last!.date < todayID) {
            moods.append(Mood(date: todayID))
        }
        return moods.last!
    }
    
    static func setTodayMood(m: Mood) {
        moods[moods.count - 1].update(overallMood: m.overallMood, somethingFun: m.somethingFun, highlights: m.highlights, onMyMind: m.onMyMind)
    }
    
    static func setSelectedItem(index: Int){
        selectedIndex = index
    }
    
    static func getSelectedItem() -> Mood {
        return moods[selectedIndex]
    }
    
    static func moodsFileName() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("moods.json")
    }
    
    static func loadMoods() -> [Mood] {
        do {
            // Read json string from file
            let filePath = moodsFileName()
            let jsonString = try String(contentsOf: filePath, encoding: .utf8)
            
            print ("JSON String from file:")
            print(jsonString) // MyTest
            
            // convert json string to mood array
            if let moodsData = jsonString.data(using: .utf8),
               let moods = try? JSONDecoder().decode([Mood].self, from: moodsData) {
                  return moods
            }
        }
        catch { }
        
        return [Mood]()
    }
    
    static func saveMoods() {
        let moodsArray = moods
        
        // Convert mood array to json string
        if let jsonData = try? JSONEncoder().encode(moodsArray),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print ("JSON String to file:")
            print(jsonString) // MyTest
            if let stringData = jsonString.data(using: .utf8) {
                // Save json string to file
                let filePath = moodsFileName()
                try? stringData.write(to: filePath)
            }
        }
    }
}


