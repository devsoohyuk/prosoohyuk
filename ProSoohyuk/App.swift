//
//  App.swift
//  ProSoohyuk
//
//  Created by soohyuk hong on 2020/11/18.
//

import UIKit

import Alamofire

struct SMSAuthResponse: Codable {
    struct O_DATA: Codable {
        var sessionId: String?
    }
    
    var O_DATA: String
    var O_CODE: String
    var O_MSG: String
}

class App {
    static let shared = App()

}

struct Update: Codable {
    var version: String?
}

class API {
    static let shared: API = API()
    var serviceURL: ServiceURL = .real
    
    func request<T: Codable>(url: String?, param: [String: Any]?, completionHandler: @escaping (Result<T, Error>) -> Void ) {
        guard let url = url else { return }
        AF.request(url, method: .post, parameters: param).response { response in
            switch response.result {
            case .success(let value):
                guard let data = value else { return }
                let decoder = JSONDecoder()
                do {
                    let d = try decoder.decode(T.self, from: data)
                    completionHandler(.success(d))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}



//import Toast_Swi
enum ServiceURL {
    case dev
    case dev2
    case real
    
    // API 요청 정보
    var baseURL: String {
        switch self {
        case .dev:
            return "http://61.111.2.224:7944/Pay010MobileApi/mobile_api/"
        case .dev2:
            return "http://61.111.2.158:7944/Pay010MobileApi/mobile_api/"
        case .real:
            return "https://thePAY.010pay.co.kr/Pay010MobileApi/mobile_api/"
        }
    }
}

extension ServiceURL {
    //-프리로딩 변경 1.1.18 부터 //1.4.0 에 신규 추가
    var preloading: String {
        return "\(baseURL)pAppPreloadingIosV7.do"
    }
}

/**
 *  Eload
 */
extension ServiceURL {
    //Eload View 관련
    var eload_real: String {
        return "\(baseURL)pAppPreloadingEloadV3.do"
    }
    
    //Eload Dynamic View 관련
    var eload_dynamic: String {
        return "\(baseURL)pAppDynamicView.do"
    }
    
    //Eload Sub Preloading
    var eload_sub_preloading: String {
        return "\(baseURL)pAppSubPreloadingIos.do"
    }
    
    //ELoad 상품조회
    var eload_remote: String {
        return "\(baseURL)pAppRemoteView.do"
    }
}
