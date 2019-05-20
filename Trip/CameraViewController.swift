//
//  CameraViewController.swift
//  Trip
//
//  Created by Ryuma Harada on 2019/05/09.
//  Copyright © 2019 Ryuma Harada. All rights reserved.
//

import UIKit


class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //写真表示用ImageView
    @IBOutlet var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //「カメラ」ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedCameraButton() {
        presentPickerController(sourceTypeAvailable: .camera)
    }
    
    @IBAction func onTappedAlbumButton() {
        presentPickerController(sourceTypeAvailable: .photoLibrary)
    }
    
    //カメラ、アルバム呼び出しメソッド（カメラrアルバムのソースタイプが引数）
    func presentPickerController(sourceTypeAvailable: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceTypeAvailable) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceTypeAvailable
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    //写真が選択されたよ時に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        //画像を出力
        photoImageView.image = info[.originalImage] as? UIImage
        
    }
    
    @IBAction func onTappedUploadBottun() {
        if photoImageView.image != nil {
            //共有するアイテムを設定
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        } else {
            print("画像がありません")
        }
    }
    
    
}
