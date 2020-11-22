//
//  TestViewController.swift
//  ProSoohyuk
//
//  Created by soohyuk hong on 2020/11/22.
//

import UIKit

protocol TestProtocol {
    func writeAdd(text: String)
}

class TestViewController: BaseViewController {
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    
    var delegate: TestProtocol?
    var testTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDesc.text = testTitle
        tfInput.delegate = self
        tfInput.clearButtonMode = .whileEditing
        
        // title
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
    }
    @IBAction func textChanged(_ sender: UITextField) {
        delegate?.writeAdd(text: sender.text ?? "")
    }
    
    // Menual Segue
    @IBAction func nextButton(_ sender: Any) {
        self.performSegue(withIdentifier: "Next", sender: self)
    }
}

extension TestViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == tfInput {
            if updatedText.count > 5 {
                return false
            }
            
            tfInput.text = updatedText.uppercased()
        }
        
        return false
    }
}
