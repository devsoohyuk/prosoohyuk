//
//  MainViewController.swift
//  ProSoohyuk
//
//  Created by soohyuk hong on 2020/11/16.
//

import UIKit
import Alamofire

class MainViewController: BaseViewController, TestProtocol {
    @IBOutlet weak var lblRead: UILabel!
    // unwind Segue
    @IBAction func unwindMainVC(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // title
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        setupMenuButton()
    }
    
    // Action Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TestViewController {
            vc.testTitle = "isTexted"
            vc.delegate = self
        }
    }
    
    func writeAdd(text: String) {
        lblRead.text = text
    }
    
    private func setupMenuButton() {
        // left button
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "btn_menu"),
            style: .plain,
            target: self,
            action: #selector(leftMenu)
        )
    }
    
    @objc func leftMenu() { }
    
}
