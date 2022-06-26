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
    var week: String
    var title: String
    var info: String
    var mood: Int
    //let image: UIImage
    
    init(date: String, week: String, title: String, info: String, mood: Int) {
        self.date = date
        self.week = week
        self.title = title
        self.info = info
        self.mood = mood
    }
}

struct MoodBook {
    static var moods = [Mood]()
    
    static func initMoods() {
        moods = loadMoods();
        if (moods.isEmpty) {
            moods.append(Mood(date: "2022-06-01", week: "Wednesday", title: "summer camp", info: "not that tired", mood: 8))
            moods.append(Mood(date: "2022-06-02", week: "Thursday", title: "summer camp", info: "rlly tired but happy ", mood: 9))
            moods.append(Mood(date: "2022-06-03", week: "Friday", title: "Hello World", info: "Hello World!", mood: 6))
        }
    }
    
    static func count() -> Int {
        return moods.count
    }
    
    static func getItem(index: Int) -> Mood {
        return moods[index];
    }
    
    static func getTodayItem() -> Mood {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayID = dateFormatter.string(from: today)
        
        if (!moods.isEmpty && moods[moods.count - 1].date == todayID) {
            return moods[moods.count - 1]
        } else {
            let weekFormatter = DateFormatter()
            weekFormatter.dateFormat = "EEEE"
            let dayInWeek = weekFormatter.string(from: today)
            let todayMood = Mood(date: todayID, week: dayInWeek, title: "", info: "", mood: 0)
            moods.append(todayMood)
            return todayMood
        }
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

