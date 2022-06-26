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
    
    static func initMoods() {
        moods = loadMoods();
        if (moods.isEmpty) {
            moods.append(Mood(date: "2022-06-01", overallMood: 5, somethingFun: true, highlights: "camp", onMyMind: "hackathon"))
            moods.append(Mood(date: "2022-06-02", overallMood: 8, somethingFun: true, highlights: "bench kickoff", onMyMind: "asg training"))
            moods.append(Mood(date: "2022-06-03", overallMood: 10, somethingFun: true, highlights: "TA", onMyMind: "birthday"))
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


