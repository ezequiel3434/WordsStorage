//
//  TableViewController.swift
//  WordsStorage
//
//  Created by Ezequiel Parada Beltran on 16/07/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var managedObjects: [NSManagedObject] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //A
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        //B
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "List")
        
        //C
        do {
            managedObjects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("No se puede recuperar los datos guardados. El error fue: \(error), \(error.userInfo)")
        }

       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return managedObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let managedObject = managedObjects[indexPath.row]
        
        cell.textLabel?.text = managedObject.value(forKey: "word") as? String

        
        return cell
    }
    
    @IBAction func addiWord(_ sender: Any) {
        
        let alert = UIAlertController(title: "New word", message: "Please Add a new word", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            let textField = alert.textFields!.first
            self.saveWord(word: textField!.text!)
            
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
    func saveWord(word: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "List", in: managedContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        managedObject.setValue(word, forKeyPath: "word")
        
        do {
            try managedContext.save()
            managedObjects.append(managedObject)
        } catch let error as NSError {
            print("No se pudo guardar, error: \(error), \(error.userInfo)")
        }
        
    }
    
   
}
