//
//  RegisterViewController.swift
//  Trip
//
//  Created by Ryuma Harada on 2019/05/17.
//  Copyright © 2019 Ryuma Harada. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var textMemo: UITextField!
    
    var latitude: CLLocationDegrees!
    var logtitude: CLLocationDegrees!
    var locationManager = CLLocationManager()
    var userLocation: CLLocation!

    let realm = try! Realm()
    let photoLocation = PhotoLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLacation()
        guard let _userLocation = userLocation else { return }
        latitude = _userLocation.coordinate.latitude
        logtitude = _userLocation.coordinate.longitude
    }
    
    //ここでCLLocationManagerを利用して、userLocationを取得している
    func setUpLacation() {
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .authorizedWhenInUse {
            userLocation = locationManager.location
        }
    }
    
    //対応したボタンが押された時の動作を記述
    @IBAction func camera(_ sender: UIButton) {
        //インスタンス作成
        let pickerController = UIImagePickerController()
        
        //ソースタイプを指定(cameraの場合はplistでカメラ使用を許可すること)
        pickerController.sourceType = .camera
        
        
        
        
        
        pickerController.delegate = self
        self.present(pickerController, animated: true, completion: nil)
    }
    
    //写真が選択された時に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: nil)
        
        //画像を出力
        photo.image = info[.originalImage] as? UIImage
    }
    
    
    
    
    
//    func locationManager(didUpdateLocations locations: CLLocation) {
//        latitude = (location?.coordinate.latitude)!
//        logtitude = (location?.coordinate.longitude)
//    }
    
    @IBAction func up() {
        photoLocation.latitude = latitude
        photoLocation.logtitude = logtitude
        
        
        guard let _selectedImage = photo.image else {
            print("画像を選択してください")
            return
        }
        photoLocation.image = _selectedImage.jpegData(compressionQuality: 1)!
        try! realm.write {
            realm.add(photoLocation)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    
}
