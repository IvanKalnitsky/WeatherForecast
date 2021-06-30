//
//  AddCity.swift
//  Prognoz
//
//  Created by macbookp on 27.06.2021.
//

import UIKit

extension UIViewController {
    func alertPlusCity(name: String, placeholder: String, completionHandler: @escaping(String) -> Void) {
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default) { action in
            let textfieldText = alertController.textFields?.first
            guard let text = textfieldText?.text else { return }
            completionHandler(text)
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { _ in }
        
        alertController.addTextField { tf in
            tf.placeholder = placeholder
        }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        present(alertController, animated: true , completion: nil)
    }
    
    func alertWrongCity(title: String) {
        let alertController = UIAlertController(title: title , message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ок", style: .default) { _ in }
        alertController.addAction(alertOk)
        present(alertController, animated: true , completion: nil)
    }
}

