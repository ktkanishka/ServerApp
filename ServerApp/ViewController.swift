//
//  ViewController.swift
//  ServerApp
//
//  Created by kanishka raveendra on 12/12/19.
//  Copyright © 2019 Kanishka Raveendra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static let webServer = GCDWebServer()
    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        
        let websitePath = Bundle.main.path(forResource:"server", ofType: nil)
        ViewController.webServer.addGETHandler(forBasePath: "/", directoryPath: websitePath!, indexFilename: nil, cacheAge: 3600, allowRangeRequests: true)
        
        ViewController.webServer.addHandler(forMethod: "GET", pathRegex: "/.*\\.html", request: GCDWebServerRequest.self,
                             processBlock: { request -> GCDWebServerResponse? in
                              
              let writePath = (websitePath! as NSString).appendingPathComponent(request.path)
              return GCDWebServerDataResponse(htmlTemplate: writePath , variables: ["value":"variable"])
        })
        
        ViewController.webServer.addHandler(forMethod: "GET",
                             path: "/",
                             request: GCDWebServerRequest.self) { request -> GCDWebServerResponse? in
           return GCDWebServerResponse(redirect: URL(string: "index.html", relativeTo: request.url)!, permanent: false)
        }
        
        ViewController.webServer.start(withPort: 8080, bonjourName: "GCD Web Server")
        print("Server: \(ViewController.webServer.port)")
        label?.text = "GCDWebServer running locally on http://192.168.0.14:8080/"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

