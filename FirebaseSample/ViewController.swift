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
    
    fileprivate var databaseRef: FIRDatabaseReference!
    fileprivate var databaseHandle: FIRDatabaseHandle!
    
    fileprivate var users: [FIRDataSnapshot] = []
    
    deinit {
        self.databaseRef.child("users").removeObserver(withHandle: self.databaseHandle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.databaseRef = FIRDatabase.database().reference()

        self.databaseHandle = self.databaseRef.child("users").observe(.childAdded, with: { (snapshot) -> Void in
            self.users.append(snapshot)
            self.table.insertRows(at: [IndexPath(row: self.users.count-1, section: 0)], with: .automatic)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func save() {
        guard let name = self.nameField.text, let address = self.addressField.text else {
            return
        }
        var data = ["name": name]
        data["address"] = address

        // Push data to Firebase Database
        self.databaseRef.child("users").childByAutoId().setValue(data)
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let userSnapshot: FIRDataSnapshot! = self.users[indexPath.row]
        let user = userSnapshot.value as! Dictionary<String, String>
        let name = user["name"] as String!
        let address = user["address"] as String!
        cell.textLabel?.text = name! + ": " + address!

        return cell
    }
    
}
