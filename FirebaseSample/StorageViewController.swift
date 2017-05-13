//
//  StorageViewController.swift
//  FirebaseSample
//
//  Created by hitting on 2017/05/13.
//  Copyright © 2017年 IOKA Masakazu. All rights reserved.
//

import UIKit
import FirebaseStorage

class StorageViewController: UIViewController {
    
    fileprivate var storageRef: FIRStorageReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: filePath)!
        let firebaseStorageBucket = dict["STORAGE_BUCKET"] as! String
        self.storageRef = FIRStorage.storage().reference(forURL: "gs://\(firebaseStorageBucket)")
    }
    
    @IBAction func uploadImage1() {
        self.uploadImage("1")
    }

    @IBAction func uploadImage2() {
        self.uploadImage("2")
    }
    
    private func uploadImage(_ name: String) {
        let image = UIImage(named: name)!
        self.storageRef.child("\(name).png").put(UIImagePNGRepresentation(image)!, metadata: nil, completion: { metaData, error in
            
        })
    }
    
}
