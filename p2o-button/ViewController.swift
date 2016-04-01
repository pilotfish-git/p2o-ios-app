//
//  ViewController.swift
//  p2o-button
//
//  Created by Michiel Mayer on 31/03/16.
//  Copyright © 2016 Pilotfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let socket = SocketIOClient(socketURL: NSURL(string:"http://p2o.pilotfish-demo-portal.eu:3001")!)
    @IBOutlet weak var counterLabel: UILabel!
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        socket.on("connect") {data in
            print("socket connected")
        }
        
        socket.on("connection-response") {data in
            print("socket connected")
        }
        
        socket.on("connection-response") {data in
            self.socket.emit("register", "test")
        }
        
//        socket.on("register-response", {data in
//            counterLabel.text = "0"
//        }
        
        socket.on("button-press") {id in
            self.counter = self.counter + 1
            self.counterLabel.text = String(self.counter)
        }
        
        socket.connect()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

