//
//  Utils.swift
//  Mymemory
//
//  Created by 한규철 on 4/14/R4.
//

import UIKit
extension UIViewController {
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    func instanceTutorialVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
}
