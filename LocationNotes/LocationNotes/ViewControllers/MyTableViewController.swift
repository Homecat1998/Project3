//
//  MyTableViewController.swift
//  LocationNotes
//
//  Created by Zhong, Zhetao on 12/1/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    var notes: Notes!
    var module : LocAndWeaModule!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("str_title", comment: "")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            
            if let detailViewController = segue.destination as? DetailViewController  {
                
                if let indexPath = tableView.indexPathForSelectedRow {
                    detailViewController.noteItem = notes?.noteList[indexPath.row]
                    detailViewController.bgColor = module.bgColor
                    
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func addItemAlert() {
        
        var notEmpty1 = false
        
        let alert = UIAlertController(title: NSLocalizedString("str_prompt", comment: ""), message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title:NSLocalizedString("str_save", comment: ""), style: .destructive, handler: { _ in
            
            if let noteField = alert.textFields?[0], let note = noteField.text, !note.isEmpty {
                
                self.notes.add(note: note, weather: self.module.weather, temp: self.module.temp, humidity: self.module.humidity, lat: self.module.lat, lon: self.module.lon, city: self.module.city)
                self.tableView.reloadData()
            }
        })
        
        
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.text = ""
            saveAction.isEnabled = false
            textField.placeholder = NSLocalizedString("str_note", comment: "")
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { _ in
                notEmpty1 = !textField.text!.isEmpty
                saveAction.isEnabled = notEmpty1
            }
        })
        
        
        
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    // Deletion Alert
    
    func deletionAlert(completion: @escaping (UIAlertAction) -> Void) {
        
        let alert = UIAlertController(title: NSLocalizedString("str_warning", comment: ""),
                                      message: "",
                                      preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("str_delete", comment: ""),
                                         style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        /*
         **  In this case we need a source for the popover as well, but don't have a handy UIBarButtonItem.
         **  As alternative we therefore use the sourceView/sourceRect combination and specify a rectangel
         **  centered in the view of our viewController.
         */
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.noteList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)


        let note = notes.noteList[indexPath.row]
        
        let city = note.city
        let time = note.date
        print(time)
        
        cell.textLabel?.text = "\(time.description),  \(city.description)"
        

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            if (notes?.noteList[indexPath.row]) != nil {
                deletionAlert(completion: { _ in
                    self.notes.removeItem(at: indexPath.row)
                    self.tableView.reloadData()
                })
            }
        }
        

    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func toggleEditingMode(_ sender: Any) {
        setEditing(!isEditing, animated: true)
    }
    
    @IBAction func addItems(_ sender: UIBarButtonItem) {
        print("adding")
        addItemAlert()
    }
}
