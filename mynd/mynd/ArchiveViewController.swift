//
//  ArchiveViewController.swift
//  mynd
//
//  Created by Kelly Jia on 6/25/22.
//

import Foundation
import UIKit

class ArchiveViewController: UIViewController {
    
    @IBOutlet weak var archiveTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        archiveTableView.delegate = self
        archiveTableView.dataSource = self
        
    }
}

extension ArchiveViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
    }
}

extension ArchiveViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoodBook.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let mood = MoodBook.getItem(index: indexPath.row)
        cell.textLabel!.text = mood.date + " " + mood.week
        cell.detailTextLabel?.text = mood.title
        
        return cell
    }
}
