//
//  ViewController.swift
//  ToDoList
//
//  Created by Mesut Yılmaz on 31.10.2018.
//  Copyright © 2018 Mesut Yılmaz. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController
{
    
    let defaults = UserDefaults.standard
    
    var itemArray = [Item()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.tittle = "Mesut"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.tittle = "Yılmaz"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.tittle = "Cok iyi"
        itemArray.append(newItem3)
        itemArray.remove(at: 0)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }

    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item  = itemArray[indexPath.row]
        cell.textLabel?.text = item.tittle
        
        
        
        /*if item.done == true {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }*/
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // Yukardaki kodun uzun yolu
        /*if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }*/
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark- Yeni birşeyler ekle
    @IBAction func ekle(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Yeni not", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ekle", style: .default) { (action) in
            
            
            let newItem = Item()
            newItem.tittle = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Yeni not ekle"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

