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
        self.navigationController?.title = NSLocalizedString("str_title", comment: "")

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
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.detailTextLabel?.text = "\(city), \(time)"
        

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
        notes.removeItem(at: indexPath.row)
        self.tableView.reloadData()
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
    }
}
