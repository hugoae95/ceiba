//
//  Utility.swift
//  ceiba
//
//  Created by Macbook on 6/02/21.
//

import Foundation
import UIKit

class Utility{
    
    var vSpinner : UIView?
    
    func alert(viewController:UIViewController, title:String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))

        viewController.present(alert, animated: true)
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
                spinnerView.addSubview(ai)
                onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
        
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
}
