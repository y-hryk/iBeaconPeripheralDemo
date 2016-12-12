//
//  ViewController.swift
//  iBeaconPeripheralDemo
//
//  Created by yamaguchi on 2016/12/12.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController {
    
    fileprivate var peripheralManager: CBPeripheralManager?
    fileprivate var beaconRegion: CLBeaconRegion?

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.peripheralManager = CBPeripheralManager()
        self.peripheralManager?.delegate = self;
    }

}

extension ViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        NSLog("発信開始")
        let uuid = NSUUID(uuidString: "D947DF5D-2FB7-417E-B34B-2D1F72A8DE40")
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid as! UUID, major: 1, minor: 1, identifier: "ibeacon Demo")
        
        let peripheralData = NSDictionary(dictionary: self.beaconRegion!.peripheralData(withMeasuredPower: nil))
            as! [String: Any]
        
        self.peripheralManager!.startAdvertising(peripheralData)
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("peripheralManagerDidStartAdvertising")
        
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if (error != nil) {
            print("サービス追加失敗！ error: \(error)")
            return
        }
        print("サービス追加成功！")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        
        print("サービス追加成功！")
    }
}
