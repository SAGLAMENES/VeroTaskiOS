//
//  TaskListCell.swift
//  Task
//
//  Created by Enes Saglam on 10.02.2024.
//

import UIKit

class TaskListCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageVie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 10
        cellView.layer.masksToBounds = false
    }

    func setup(task: TaskPresentations) {
        nameLabel.text = task.name
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        codeLabel.text = task.colorCode
        imageVie.image = UIImage(systemName: "circle")
        imageVie.tintColor = .white.withAlphaComponent(0.0)
        
        imageVie.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageVie.backgroundColor = UIColor(hexString: task.colorCode)
    }

}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.currentIndex = hexString.index(after: scanner.currentIndex)
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask: UInt64 = 0x000000FF
        let r = Int(color >> 16) & Int(mask)
        let g = Int(color >> 8) & Int(mask)
        let b = Int(color) & Int(mask)
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
        return String(format: "#%06x", rgb)
    }
}

