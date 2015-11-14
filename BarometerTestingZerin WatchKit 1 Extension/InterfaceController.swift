//
//  InterfaceController.swift
//  BarometerTestingZerin WatchKit 1 Extension
//
//  Created by Zerin A Zisha on 2015-11-13.
//  Copyright © 2015 Zerin A Zisha. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion

class InterfaceController: WKInterfaceController {
    @IBOutlet var ALabelX: WKInterfaceLabel!
    @IBOutlet var ALabelY: WKInterfaceLabel!
    @IBOutlet var ALabelZ: WKInterfaceLabel!
    
    let motionManager = CMMotionManager()
    
    
    @IBOutlet var GlabelX: WKInterfaceLabel!
    @IBOutlet var GLabelY: WKInterfaceLabel!
    @IBOutlet var GLabelZ: WKInterfaceLabel!
    
    var number:Int = 0
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.gyroUpdateInterval = 0.1
    }
    
    
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        //        print("     X :                           Y:                            Z:         ")
        if(motionManager.accelerometerAvailable == true)
        {
            
            let Ahandler:CMAccelerometerHandler = {
                (data:CMAccelerometerData?, error:NSError? ) -> Void in
                self.ALabelX.setText(String(format: "%.2f", data!.acceleration.x))
                self.ALabelY.setText(String(format: "%.2f", data!.acceleration.y))
                self.ALabelZ.setText(String(format: "%.2f", data!.acceleration.z))
                
                
                //        print("\(self.number++)   \(data!.acceleration.x)    \(data!.acceleration.y)     \(data!.acceleration.z)")
                print(" X : \(data!.acceleration.x)")  ; print(" Y : \(data!.acceleration.y)"); print(" Z : \(data!.acceleration.z)")
                
            }//let handler:CMAccelerometerHandler
            
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: Ahandler)
            
        }
        else
        {
            self.ALabelX.setText("not available")
            self.ALabelY.setText("not available")
            self.ALabelZ.setText("not available")
            
        }
        
        if (motionManager.gyroAvailable == true)
        {
            let Ghandler:CMGyroHandler = {
                (data:CMGyroData?, error:NSError? ) -> Void in
                self.GlabelX.setText(String(format: "%.2f", data!.rotationRate.x))
                self.GLabelY.setText(String(format: "%.2f", data!.rotationRate.y))
                self.GLabelZ.setText(String(format: "%.2f", data!.rotationRate.z))
                
            }//let Ghandler:CMGyroHandler
            
            motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: Ghandler)
        }
        else
        {
            self.GlabelX.setText("not available")
            self.GLabelY.setText("not available")
            self.GLabelZ.setText("not available")
        }
        
        
    }
    
    @IBAction func OnclickStart() {
        willActivate()
    }
    
    
    
    @IBAction func OnClickStop() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
    
    
    @IBAction func OnClickReset() {
        self.ALabelX.setText("0.0")
        self.ALabelY.setText("0.0")
        self.ALabelZ.setText("0.0")
    }
    
    
    
    //    override func didDeactivate() {
    //        // This method is called when watch view controller is no longer visible
    //        super.didDeactivate()
    //    }
    
}