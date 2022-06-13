//
//  ViewController.swift
//  YapılacaklarListesi
//
//  Created by Doğan seçilmiş on 6.06.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    
    var girdiler = [String]()
    var kalsınGirdi = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.girdiler = UserDefaults.standard.stringArray(forKey: "girdiler") ?? []
        tableView.dataSource = self
        tableView.delegate = self
  
    
    }
    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "Saving Area", message: "Please write the activity.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Saving Area... "
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self](_) in
                
                if let girdi = alert.textFields?.first{
                    if let text = girdi.text, !text.isEmpty {
                        
                        DispatchQueue.main.async {
                            var kalsınGirdi = UserDefaults.standard.stringArray(forKey: "girdiler") ?? []
                            kalsınGirdi.append(text)
                            UserDefaults.standard.set(kalsınGirdi, forKey: "girdiler")
                            
                            self?.girdiler.append(text)
                            self?.tableView.reloadData()
                        }
                        
                        
                    
                    }
                }
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_     tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return girdiler.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = girdiler[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       
   
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { Action, indexPath in
            self.girdiler.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            UserDefaults.standard.set(self.girdiler, forKey: "girdiler")
            tableView.reloadData()

        }
        return [deleteAction]
    }
    
 
}

