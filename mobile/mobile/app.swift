//
//  app.swift
//  mobile
//
//  Created by Jonathan on 07/08/2023.
//

import Foundation
import PythonKit

class Backend: Thread {
    override func main() {
        let app = Python.import("app")
        app.main()
    }
}

func backend_main() -> Bool {
    let app = Python.import("app")
    let _ready = app.main()
    
    var ready = false
    if (_ready == "True") {
        ready = true
    }
    
    return ready
}
