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
    
      let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Not.plist")
    var itemArray = [Item()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
     
    itemArray.remove(at: 0)
        
    /*  if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        } */
        
        loadItems()

    
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
        self.saveItems()
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark- Yeni birşeyler ekle
     func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch {
            print(error)
        }
    }
    
    func loadItems() {
        
        if  let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func ekle(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Yeni not", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ekle", style: .default) { (action) in
            
            
            let newItem = Item()
            newItem.tittle = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItems()
            
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

