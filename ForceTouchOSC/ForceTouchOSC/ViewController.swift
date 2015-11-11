//
//  ViewController.swift
//  ForceTouchOSC
//
//  Created by Masatatsu Nakamura on 2015/11/11.
//  Copyright © 2015年 Masatatsu Nakamura. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var button: NSButton!
    @IBOutlet var indicator: NSLevelIndicator!
    
    var oscClient: F53OSCClient!
    var host: String = "127.0.0.1"
    var port: UInt16 = 3000
    
    @IBOutlet weak var hostTextField: NSTextField!
    @IBOutlet weak var portTextField: NSTextField!
    
    // to use objective-c library in swift : http://tech.admax.ninja/2014/09/26/about-bridging-header/
    // osc library : http://stackoverflow.com/questions/32169149/swift-ios-osc-library
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hostTextField.stringValue = host
        portTextField.stringValue = String(port)
        
        setup()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func click(sender: AnyObject?) {
        
        // map button.floatValue to 0.0 ~ 1.0
        let f = max(1, button.floatValue) - 1
        indicator.floatValue = f
    
        let message = F53OSCMessage(addressPattern: "/force", arguments: [f])
        oscClient.sendPacket(message)
        
        print("Sent '\(message)' to \(oscClient.host):\(oscClient.port)")

    }
    
    @IBAction func connect(sender: AnyObject) {
        host = hostTextField.stringValue
        port = UInt16(portTextField.integerValue)
        
        setup() // reconnect
    }
    
    func setup() {
        oscClient = F53OSCClient.init()
        oscClient.host = host
        oscClient.port = port
    }

}

