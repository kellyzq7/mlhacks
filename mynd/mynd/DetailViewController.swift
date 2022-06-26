//
//  DetailViewController.swift
//  mynd
//
//  Created by Kelly Jia on 6/26/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mOverallMood: UISlider!
    @IBOutlet weak var mSomethingFun: UISegmentedControl!
    @IBOutlet weak var mHighlights: UITextView!
    @IBOutlet weak var mOnMyMind: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let m = MoodBook.getSelectedItem()
        mOverallMood.setValue(Float(m.overallMood), animated: false)
        mSomethingFun.selectedSegmentIndex = m.somethingFun ? 0 : 1
        mHighlights.text = m.highlights
        mOnMyMind.text = m.onMyMind
    }

}

