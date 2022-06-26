//
//  TodayViewController.swift
//  mynd
//
//  Created by Kelly Jia on 6/26/22.
//

import Foundation
import UIKit

class TodayViewController: UIViewController {
    
    @IBOutlet weak var overallMood: UISlider!
    @IBOutlet weak var somethingFun: UISegmentedControl!
    @IBOutlet weak var highlights: UITextView!
    @IBOutlet weak var onMyMind: UITextView!

    var todaysMood: Mood!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overallMood.minimumValue = 0
        overallMood.maximumValue = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todaysMood = MoodBook.getTodayMood()
        overallMood.setValue(Float(todaysMood.overallMood), animated: false)
        somethingFun.selectedSegmentIndex = todaysMood.somethingFun ? 0 : 1
        highlights.text = todaysMood.highlights
        onMyMind.text = todaysMood.onMyMind

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        todaysMood.update(overallMood: Int(overallMood.value),
                          somethingFun: somethingFun.selectedSegmentIndex == 0,
                          highlights: highlights.text ?? "",
                          onMyMind: onMyMind.text ?? "")
        
        MoodBook.setTodayMood(m: todaysMood)
    }
    
}
