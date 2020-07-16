//
//  TableViewController.swift
//  WordsStorage
//
//  Created by Ezequiel Parada Beltran on 16/07/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var wordsTable: [String] = ["Ezequiel", "ALexis", "Karen"]

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wordsTable.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = wordsTable[indexPath.row]

        return cell
    }
    
    @IBAction func addiWord(_ sender: Any) {
        
        let alert = UIAlertController(title: "New word", message: "Please Add a new word", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            let textField = alert.textFields!.first
            self.wordsTable.append(textField!.text!)
            
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
            
        }
        
        alert.addTextField { (UITextField) in
            
        }
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert,animated: true, completion: nil)
        
    }
    
   
}
