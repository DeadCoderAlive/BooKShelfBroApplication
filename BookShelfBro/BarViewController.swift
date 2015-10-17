//
//  BarViewController.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/17/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import UIKit
import AVFoundation


class BarViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let session         : AVCaptureSession = AVCaptureSession()
    var previewLayer    : AVCaptureVideoPreviewLayer!
    var highlightView   : UIView = UIView()
    var detectionString : String!
    var bookAPI = BookShelfAPI()

    
    func addPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.bounds = self.view.bounds
        previewLayer?.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
        self.view.layer.addSublayer(previewLayer!)

    }
         
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allow the view to resize freely
        highlightView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        // Select the color you want for the completed scan reticle
        self.highlightView.layer.borderColor = UIColor.greenColor().CGColor
        self.highlightView.layer.borderWidth = 3
        
        // Add it to our controller's view as a subview.
        self.view.addSubview(self.highlightView)
        
        
        // For the sake of discussion this is the camera
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error : NSError?
        let inputDevice: AVCaptureDeviceInput!
        do {
            inputDevice = try AVCaptureDeviceInput(device: captureDevice)
        } catch let error1 as NSError {
            error = error1
            inputDevice = nil
        }
        
        if let inp = inputDevice {
            session.addInput(inp)
        } else {
            print(error)
        }
        addPreviewLayer()

        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        // Start the scanner. You'll have to end it yourself later.
        session.startRunning()
        
    }
    
    // This is called when we find a known barcode type with the camera.
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        var highlightViewRect = CGRectZero
        
        var barCodeObject : AVMetadataObject!
        
        
        let barCodeTypes = [AVMetadataObjectTypeUPCECode,
            AVMetadataObjectTypeCode39Code,
            AVMetadataObjectTypeCode39Mod43Code,
            AVMetadataObjectTypeEAN13Code,
            AVMetadataObjectTypeEAN8Code,
            AVMetadataObjectTypeCode93Code,
            AVMetadataObjectTypeCode128Code,
            AVMetadataObjectTypePDF417Code,
            AVMetadataObjectTypeQRCode,
            AVMetadataObjectTypeAztecCode
        ]
        
        
      
        for metadata in metadataObjects {
            
            for barcodeType in barCodeTypes {
                
                if metadata.type == barcodeType {
                    barCodeObject = self.previewLayer.transformedMetadataObjectForMetadataObject(metadata as! AVMetadataMachineReadableCodeObject)
                    
                    highlightViewRect = barCodeObject.bounds
                    
                    detectionString = (metadata as! AVMetadataMachineReadableCodeObject).stringValue
                    
                    self.session.stopRunning()
                    break
                }
                
            }
        }
        
        print(detectionString!)
        bookAPI.setDetectedString(detectionString! as String)
        /*self.highlightView.frame = highlightViewRect*/
        self.view.bringSubviewToFront(self.highlightView)
        self.performSegueWithIdentifier("toAddBook", sender: self)
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var code = detectionString!
        let destinationView = segue.destinationViewController as! AddBookViewController
        destinationView.bcode = code
    }
    
}