//
//  FifthViewController.swift
//  ProSoohyuk
//
//  Created by soohyuk hong on 2020/11/16.
//

import UIKit
import WebKit

class FifthViewController: UIViewController, WKNavigationDelegate, WKUIDelegate,  WKScriptMessageHandler {
    
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func loadView() {
        super.loadView()
        
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        
        // native -> js call (문서 시작시에만 가능한, 환경설정으로 사용함), source부분에 함수 대신 HTML직접 삽입 가능
        let userScript = WKUserScript(source: "redHeader()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        
        // js -> native call : name의 값을 지정하여, js에서 webkit.messageHandlers.NAME.postMessage("");와 연동되는 것, userContentController함수에서 처리한다
        contentController.add(self, name: "callbackHandler")
        
        config.userContentController = contentController
        

        webView = WKWebView(frame: self.view.frame, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // self.view = self.webView!
        self.view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = Bundle.main.url(forResource: "HtmlTest", withExtension: "html") else { return }
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
        
//        let myBlog = "HtmlTest.html"
//        let url = URL(string: myBlog)
//        let request = URLRequest(url: url!)
//        webView.load(request)
        
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let otherAction = UIAlertAction(title: "OK", style: .default, handler: {action in completionHandler()})
        alert.addAction(otherAction)
            
        self.present(alert, animated: true, completion: nil)
    }

    // JS -> Native CALL
    @available(iOS 8.0, *)
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage){
        if(message.name == "callbackHandler"){
            print(message.body)
            nativeCall()
        }
    }
    
    func nativeCall(){
        print("nativeCall")
        webView.evaluateJavaScript("redHeader()") { (e, error) in
            print(e)
        }
        
//        webView.evaluateJavaScript("document.querySelector('h1').style.color = 'red'") { (e, error) in
//            print(e)
//        }
    }
}
