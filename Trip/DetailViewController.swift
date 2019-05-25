//
//  DetailViewController.swift
//  Trip
//
//  Created by Ryuma Harada on 2019/05/21.
//  Copyright © 2019 Ryuma Harada. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UIImagePickerControllerDelegate {
    @IBOutlet var image: UIImageView!
    @IBOutlet var memo: UILabel!
    
    let realm = try! Realm()
    var detaliArray: Results<PhotoLocation>!
    var number: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detaliArray = realm.objects(PhotoLocation.self)
        memo.text = detaliArray[number].textMemo
        let images = detaliArray[number].image
        image.image = UIImage(data: images)
        
        
    
       
        
//        let results = realm.objects(textMemo.self)
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func back() {
//        dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }

}
