//
//  MapViewController.swift
//  Trip
//
//  Created by Ryuma Harada on 2019/05/09.
//  Copyright © 2019 Ryuma Harada. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var number: Int = 0
    
    //CLLocationManagerの入れ物を用意
    var myLocationManager:CLLocationManager!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.mapView.delegate = self
        
        let realm = try! Realm()
        let results = realm.objects(PhotoLocation.self)
        
        
        for i in 0..<results.count {
            let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(results[i].latitude, results[i].logtitude)
            
            
            // ピンを生成.
            var myPin: CustomAnnotation = CustomAnnotation()
            myPin.coordinate = center
            myPin.title = results[i].textMemo
            myPin.tag = i
            
            // MapViewにピンを追加.
            mapView.addAnnotation(myPin)
        }
        //CLLocationManagerをインスタンス化
        myLocationManager = CLLocationManager()
        
        
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        myLocationManager.requestWhenInUseAuthorization()
        
    }
    
//
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //アノテーションを消す
        if let annotation = view.annotation {
            mapView.deselectAnnotation(annotation, animated: true)
        }
        // どのピンがタップされたかを取得
        let title = view.annotation?.title
        print(title)
        var tag = (view.annotation as? CustomAnnotation)?.tag
        performSegue(withIdentifier: "ToDetail", sender: tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            let detail = segue.destination as! DetailViewController
            detail.number = sender as? Int
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        // Identifier
        let myAnnotationIdentifier = "myAnnotation"
        
        // AnnotationViewをdequeue
        var myAnnotationView : MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: myAnnotationIdentifier)
        
        //アノテーションの右側につけるボタンの宣言
        let button:UIButton = UIButton(type: UIButton.ButtonType.infoLight)
        
        if myAnnotationView == nil {
            myAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: myAnnotationIdentifier)
            //アノテーションの右側にボタンを付ける
            myAnnotationView.rightCalloutAccessoryView = button
            myAnnotationView.canShowCallout = true
        }
        return myAnnotationView
    }
    
    
    //位置情報取得に失敗したときに呼び出されるメソッド
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    
    @IBAction func back() {
//        dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
//    try! realm.write {
//    realm.add(location)
//    }
    
}
