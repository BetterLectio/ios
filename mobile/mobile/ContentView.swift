//
//  ContentView.swift
//  mobile
//
//  Created by Jonathan on 07/08/2023.
//

import SwiftUI
import WebKit
import SafariServices
import Python

struct ContentView: View {
    var ready = false
    
    var body: some View {
        //SafariView(url: URL(string: "https://dev--betlec.netlify.app/auth?app=iOS")!)
        SafariView(url: URL(string: "http://localhost:5000/betterlectio")!)
        //WebView(url: URL(string: "https://dev--betlec.netlify.app")!)
    }
    
    init() {
        guard let stdLibPath = Bundle.main.path(forResource: "python-stdlib", ofType: nil) else { return }
        guard let libDynloadPath = Bundle.main.path(forResource: "python-stdlib/lib-dynload", ofType: nil) else { return }
        guard let platformSitePath = Bundle.main.path(forResource: "platform-site", ofType: nil) else { return }
        guard let pythonPath = Bundle.main.path(forResource: "PythonScripts", ofType: nil) else { return }
        guard let pythonDependenciesPath = Bundle.main.path(forResource: "PythonDependencies", ofType: nil) else { return }
        setenv("PYTHONHOME", stdLibPath, 1)
        setenv("PYTHONPATH", "\(stdLibPath):\(libDynloadPath):\(platformSitePath):\(pythonPath):\(pythonDependenciesPath)", 1)
        Py_Initialize()
        // we now have a Python interpreter ready to be used
        let backend = Backend()
        backend.start()
        //waitForBackend()
        
        //ready = backend_main()
        //print(ready)
    }
    
    func waitForBackend() {
        print("Wait for backend started")
        
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        //let configuration = URLSessionConfiguration.default
        //configuration.applicationNameForUserAgent = "BetterLectio Mobile"
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.customUserAgent = "BetterLectio Mobile"
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
