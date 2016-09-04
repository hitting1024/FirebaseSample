//
//  ViewController.swift
//  FirebaseSample
//
//  Created by hitting on 2016/09/04.
//  Copyright © 2016年 IOKA Masakazu. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    private var databaseRef: FIRDatabaseReference!
    private var databaseHandle: FIRDatabaseHandle!
    
    private var users: [FIRDataSnapshot] = []
    
    deinit {
        self.databaseRef.child("users").removeObserverWithHandle(self.databaseHandle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.databaseRef = FIRDatabase.database().reference()
        self.databaseHandle = self.databaseRef.child("users").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            self.users.append(snapshot)
            self.table.insertRowsAtIndexPaths([NSIndexPath(forRow: self.users.count-1, inSection: 0)], withRowAnimation: .Automatic)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func save() {
        guard let name = self.nameField.text, address = self.addressField.text else {
            return
        }
        var data = ["name": name]
        data["address"] = address

        // Push data to Firebase Database
        self.databaseRef.child("users").childByAutoId().setValue(data)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = table.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let userSnapshot: FIRDataSnapshot! = self.users[indexPath.row]
        let user = userSnapshot.value as! Dictionary<String, String>
        let name = user["name"] as String!
        let address = user["address"] as String!
        cell.textLabel?.text = name + ": " + address

        return cell
    }
    
}