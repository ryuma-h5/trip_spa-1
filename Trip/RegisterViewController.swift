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

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var textMemo: UITextField!
    
    var latitude: CLLocationDegrees!
    var logtitude: CLLocationDegrees!
    var locationManager = CLLocationManager()
    var userLocation: CLLocation!
    
    let realm = try! Realm()
    let photoLocation = PhotoLocation()
    //    let textMemo = PhotoLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textMemo.delegate = self
        
        setUpLacation()
        guard let _userLocation = userLocation else { return }
        latitude = _userLocation.coordinate.latitude
        logtitude = _userLocation.coordinate.longitude
        
        
        favo1Button.setImage(favoImage, for: .normal)
        favo1Button.setImage(favoedImage, for: .selected)
        favo2Button.setImage(favoImage, for: .normal)
        favo2Button.setImage(favoedImage, for: .selected)
        favo3Button.setImage(favoImage, for: .normal)
        favo3Button.setImage(favoedImage, for: .selected)
        favo4Button.setImage(favoImage, for: .normal)
        favo4Button.setImage(favoedImage, for: .selected)
        favo5Button.setImage(favoImage, for: .normal)
        favo5Button.setImage(favoedImage, for: .selected)
        
        favo1Button.isSelected = false
        favo2Button.isSelected = false
        favo3Button.isSelected = false
        favo4Button.isSelected = false
        favo5Button.isSelected = false
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
        photoLocation.textMemo = textMemo.text ?? ""
        try! realm.write {
            realm.add(photoLocation)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //温泉評価
    @IBOutlet var favo1Button: UIButton!
    @IBOutlet var favo2Button: UIButton!
    @IBOutlet var favo3Button: UIButton!
    @IBOutlet var favo4Button: UIButton!
    @IBOutlet var favo5Button: UIButton!
    var favoNumber: Int = 0
    let favoedImage: UIImage = UIImage(named: "spa_mark.png")!
    let favoImage:UIImage = UIImage(named: "spa_unselected.png")!
    
    @IBAction func tapped1() {
        if favoNumber == 1 {
            favo1Button.isSelected = false
            favo2Button.isSelected = false
            favo3Button.isSelected = false
            favo4Button.isSelected = false
            favo5Button.isSelected = false
            favoNumber = 0
        } else {
            favo1Button.isSelected = true
            favo2Button.isSelected = false
            favo3Button.isSelected = false
            favo4Button.isSelected = false
            favo5Button.isSelected = false
            favoNumber = 1
        }
    }
    
    @IBAction func tapped2() {
        if favoNumber == 2 {
            favo1Button.isSelected = false
            favo2Button.isSelected = false
            favo3Button.isSelected = false
            favo4Button.isSelected = false
            favo5Button.isSelected = false
            favoNumber = 0
        } else {
            favo1Button.isSelected = true
            favo2Button.isSelected = true
            favo3Button.isSelected = false
            favo4Button.isSelected = false
            favo5Button.isSelected = false
            favoNumber = 2
        }
    }
    
    @IBAction func tapped3() {
        if favoNumber == 3 {
            favo1Button.isSelected = false
            favo2Button.isSelected = false
            favo3Button.isSelected = false
            favo4Button.isSelected = false
            favo5Button.isSelected = false
            favoNumber = 0
        } else {
            favo1Button.isSelected = true
            favo2Button.isSelected = true
            favo3Button.isSelected = true
            favo4Button.isSelected = false
            favo5Button.isSelected = false
            favoNumber = 3
        }
    }
    
    @IBAction func tapped4() {
        if favoNumber == 4 {
            favo1Button.isSelected = false
            favo2Button.isSelected = false
            favo3Button.isSelected = false
            favo4Button.isSelected = false
            favo5Button.isSelected = false
            favoNumber = 0
        } else {
            favo1Button.isSelected = true
            favo2Button.isSelected = true
            favo3Button.isSelected = true
            favo4Button.isSelected = true
            favo5Button.isSelected = false
            favoNumber = 4
        }
    }
    
    @IBAction func tapped5() {
        if favoNumber == 5 {
            favo1Button.isSelected = false
            favo2Button.isSelected = false
            favo3Button.isSelected = false
            favo4Button.isSelected = false
            favo5Button.isSelected = false
            favoNumber = 0
        } else {
            favo1Button.isSelected = true
            favo2Button.isSelected = true
            favo3Button.isSelected = true
            favo4Button.isSelected = true
            favo5Button.isSelected = true
            favoNumber = 5
        }
    }
    
    
    
    
    
    
}
