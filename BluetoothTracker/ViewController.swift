//
//  ViewController.swift
//  BluetoothTracker
//
//  Created by Nolan Fuchs on 1/29/19.
//  Copyright © 2019 Nolan Fuchs. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate {
    
    var centralManager: CBCentralManager?
    var names: [String] = []
    var ids: [NSNumber] = []
    
    @IBOutlet weak var bluetoothTableView: UITableView!
    let bluetoothIdentifier: String = "bluetoothCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func refresh(_ sender: Any) {
        startScan()
    }

    func startScan() {
        names = []
        ids = []
        bluetoothTableView.reloadData()
        centralManager?.stopScan()
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if let name = peripheral.name {
            names.append(name)
        } else {
            names.append(peripheral.identifier.uuidString)
        }
        
        ids.append(RSSI)
        bluetoothTableView.reloadData()
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScan()
        } else {
            let alertVC = UIAlertController(title: "Bluetooth Not Working", message: "Make sure your bluetooth is powered on.", preferredStyle: .alert)
            let alertOK = UIAlertAction(title: "Ok", style: .default) { (alert) in
                alertVC.dismiss(animated: true, completion: nil)
            }
            alertVC.addAction(alertOK)
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    // Data Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = bluetoothTableView.dequeueReusableCell(withIdentifier: bluetoothIdentifier, for: indexPath) as? BluetoothCell {
            cell.peripheralName.text = names[indexPath.row]
            cell.rssiName.text = "RSSI: \(ids[indexPath.row])"
            return cell
        } else {
            return UITableViewCell()
        }
    }
    

}

