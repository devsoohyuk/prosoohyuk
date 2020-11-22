//
//  BaseViewController.swift
//  ProSoohyuk
//
//  Created by soohyuk hong on 2020/11/22.
//

import UIKit

// 중첩되는 것들 상속으로 사용하기 위해 생성
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // back button white space
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
