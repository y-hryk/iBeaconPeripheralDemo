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
    
    fileprivate var stateLabel: UILabel!
    fileprivate var startButton: UIButton!
    fileprivate var stopbutton: UIButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.peripheralManager = CBPeripheralManager()
        self.peripheralManager?.delegate = self;
        
        
        self.stateLabel = UILabel()
        self.stateLabel.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 50)
        self.stateLabel.textAlignment = .center
        self.stateLabel.font = UIFont.systemFont(ofSize: 25)
        self.stateLabel.text = "未送信"
        self.view.addSubview(self.stateLabel)
        
        self.startButton = UIButton(type: .roundedRect)
        self.startButton.frame = CGRect(x: 0, y: 250, width: self.view.frame.width / 2, height: 50)
        self.startButton.setTitle("Start", for: .normal)
        self.startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        self.view.addSubview(self.startButton)
        
        self.stopbutton = UIButton(type: .roundedRect)
        self.stopbutton.frame = CGRect(x: self.view.frame.width / 2, y: 250, width: self.view.frame.width / 2, height: 50)
        self.stopbutton.setTitle("Stop", for: .normal)
        self.stopbutton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.stopbutton.addTarget(self, action: #selector(stop), for: .touchUpInside)
        self.view.addSubview(self.stopbutton)
    }
    
    func start() {
        
        let uuid = NSUUID(uuidString: "D947DF5D-2FB7-417E-B34B-2D1F72A8DE40")
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid as! UUID, major: 1, minor: 1, identifier: "ibeacon Demo")
        
        let peripheralData = NSDictionary(dictionary: self.beaconRegion!.peripheralData(withMeasuredPower: nil))
            as! [String: Any]
        
        self.peripheralManager!.startAdvertising(peripheralData)
        
        self.stateLabel.text = "送信中"
        self.startButton.isEnabled = false
        self.stopbutton.isEnabled = true
    }
    
    func stop() {
        
        self.peripheralManager?.stopAdvertising()
        
        self.stateLabel.text = "未送信"
        self.startButton.isEnabled = true
        self.stopbutton.isEnabled = false
    }

}

extension ViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        NSLog(">> peripheralManagerDidUpdateState")
        self.start()
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print(">> peripheralManagerDidStartAdvertising")
        
    }
}
