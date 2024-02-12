//
//  QRScannerBuilder.swift
//  Task
//
//  Created by Enes Saglam on 11.02.2024.
//

import Foundation
import UIKit

final class QrScannerBuilder {
    
    static func make() -> QrCodeViewController {
        let storyboard = UIStoryboard(name: "QrCodeScanner", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "QrCodeScanner") as! QrCodeViewController
    
        return view
    }
    
}
