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
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    fileprivate var storageRef: FIRStorageReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: filePath)!
        let firebaseStorageBucket = dict["STORAGE_BUCKET"] as! String
        self.storageRef = FIRStorage.storage().reference(forURL: "gs://\(firebaseStorageBucket)")
        
        self.loadImage1()
        self.loadImage2()
    }
    
    fileprivate func loadImage1() {
        self.loadImage("1", completion: { image in
            self.image1.image = image
        })
    }
    
    fileprivate func loadImage2() {
        self.loadImage("2", completion: { image in
            self.image2.image = image
        })
    }
    
    fileprivate func loadImage(_ name: String, completion: @escaping (UIImage?)->Void) {
        self.storageRef.child("\(name).png").data(withMaxSize: 1 * 1024 * 1024 /* 1MB */, completion: { data, error in
            if error != nil {
                return
            }
            completion(UIImage(data: data!))
        })
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
