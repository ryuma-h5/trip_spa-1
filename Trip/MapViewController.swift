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

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var number: Int = 0
    
    //CLLocationManagerの入れ物を用意
    var myLocationManager:CLLocationManager!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let realm = try! Realm()
        let results = realm.objects(PhotoLocation.self)
        
        
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(results[number].latitude, results[number].logtitude)
        
        
        // ピンを生成.
        var myPin: MKPointAnnotation = MKPointAnnotation()
        myPin.coordinate = center
        
        // MapViewにピンを追加.
        mapView.addAnnotation(myPin)
        //CLLocationManagerをインスタンス化
        myLocationManager = CLLocationManager()
        
        
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        myLocationManager.requestWhenInUseAuthorization()
        
    }
    
    
    //位置情報取得に失敗したときに呼び出されるメソッド
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    
    
//    try! realm.write {
//    realm.add(location)
//    }
    
}
