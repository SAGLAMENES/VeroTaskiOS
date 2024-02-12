//
//  QRCodeViewController.swift
//  Task
//
//  Created by Enes Saglam on 11.02.2024.
//

import UIKit
import VisionKit

final class QrCodeViewController: UIViewController {

    var scannerAvaible : Bool {
        DataScannerViewController.isSupported && DataScannerViewController.isAvailable
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()

        
        }
    
   
    @IBAction func startScannigPressed(_ sender: Any) {
        guard scannerAvaible == true else {
            print("Error")
            return
        }
        
        let dataScanner = DataScannerViewController(recognizedDataTypes: [.barcode()], isHighlightingEnabled: true)
        dataScanner.delegate = self
        present(dataScanner, animated: true) {
            try? dataScanner.startScanning()
        }
        
    }
    
}

extension QrCodeViewController : DataScannerViewControllerDelegate {
    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        switch item {
        case .barcode(let barcode):
            guard let barcodeString = barcode.payloadStringValue else { return }
            let destinationVC = TaskListBuilder.make()
            destinationVC.receivedText = barcodeString
            dataScanner.dismiss(animated: true, completion: nil)
            show(destinationVC, sender: nil)
        default:
            print("error")
        }
    }
}


