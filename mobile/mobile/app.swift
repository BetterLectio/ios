//
//  app.swift
//  mobile
//
//  Created by Jonathan on 07/08/2023.
//

import Foundation
import PythonKit

func backend_main() {
    let app = Python.import("app")
    app.main()
}
