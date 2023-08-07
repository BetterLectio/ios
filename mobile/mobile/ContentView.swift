//
//  ContentView.swift
//  mobile
//
//  Created by Jonathan on 07/08/2023.
//

import SwiftUI
import WebKit
import Python

struct ContentView: View {
    var body: some View {
        WebView(url: URL(string: "https://www.google.com/search?q")!)
    }
    
    init() {
        guard let stdLibPath = Bundle.main.path(forResource: "python-stdlib", ofType: nil) else { return }
        guard let libDynloadPath = Bundle.main.path(forResource: "python-stdlib/lib-dynload", ofType: nil) else { return }
        guard let platformSitePath = Bundle.main.path(forResource: "platform-site", ofType: nil) else { return }
        guard let pythonPath = Bundle.main.path(forResource: "PythonScripts", ofType: nil) else { return }
        setenv("PYTHONHOME", stdLibPath, 1)
        setenv("PYTHONPATH", "\(stdLibPath):\(libDynloadPath):\(platformSitePath):\(pythonPath)", 1)
        Py_Initialize()
        // we now have a Python interpreter ready to be used
        backend_main()
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
