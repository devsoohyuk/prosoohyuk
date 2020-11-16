//
//  FourthViewController.swift
//  ProSoohyuk
//
//  Created by soohyuk hong on 2020/11/16.
//

import UIKit

class FourthViewController: UIViewController, UITextFieldDelegate {
    let textfield: UITextField = {
        let textfield = UITextField(frame: CGRect(x: UIScreen.main.bounds.size.width/2,
                                              y: UIScreen.main.bounds.size.height/2,
                                              width: 100,
                                              height: 50))
        textfield.backgroundColor = .white
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "About"
        self.textfield.delegate = self
//        textfield.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textfield)
//        
//        view.centerXAnchor.
//        blueView.widthAnchor.constraint(equalTo: redView.widthAnchor).isActive = true
//        blueView.heightAnchor.constraint(equalTo: redView.heightAnchor).isActive = true
//        blueView.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 8).isActive = true
        
    }
}

func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    
    //        switch textField {
    //        case self.tfPhone:
    //            tfPhone.text = StringUtils.telFormat(updatedText)
    //            return false
    //        default:
    //            return false
    //        }
    return true
}

/// mask example: `+X (XXX) XXX-XXXX`
func format(with mask: String, phone: String) -> String {
    let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result = ""
    var index = numbers.startIndex // numbers iterator

    // iterate over the mask characters until the iterator of numbers ends
    for ch in mask where index < numbers.endIndex {
        if ch == "X" {
            // mask requires a number in this place, so take the next one
            result.append(numbers[index])

            // move numbers iterator to the next index
            index = numbers.index(after: index)

        } else {
            result.append(ch) // just append a mask character
        }
    }
    return result
}
