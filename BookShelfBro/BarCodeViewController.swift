//
//  BarCodeViewController.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/17/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import UIKit
import AVFoundation

class BarCodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var session :AVCaptureSession!
    var previewLayer :AVCaptureVideoPreviewLayer!
    var barView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /* self.barView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleTopMargin |UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin */
        self.barView.layer.borderColor = UIColor.redColor().CGColor
        self.barView.layer.borderWidth = 3
        self.view.addSubview(self.barView)
        do {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            } else {
                //create alert here
            }
        } catch let error as NSError {
            print(error)
              //create alert here
        }
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = self.view.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(previewLayer!)
        session.startRunning()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        var highlightRect = CGRectZero
        var barCodeObject: AVMetadataObject!
        var detectedString: String!
        let barCodeTypes = [AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeUPCECode]
        for metaData in metadataObjects {
            for barCodeType in barCodeTypes {
                if metaData.type == barCodeType {
                    barCodeObject = self.previewLayer.transformedMetadataObjectForMetadataObject(metaData as! AVMetadataMachineReadableCodeObject)
                    highlightRect = barCodeObject.bounds
                    detectedString = (metaData as! AVMetadataMachineReadableCodeObject).stringValue
                    self.session.stopRunning()
                    self.createAlert(detectedString)
                    break
                }
            }
         }
        self.barView.frame = highlightRect
        self.view.bringSubviewToFront(self.barView)
        
    }
    func createAlert(detectedString: String!) {
        let alert:UIAlertController = UIAlertController(title: "Success",message: "\(detectedString)",preferredStyle: UIAlertControllerStyle.Alert)
        let action:UIAlertAction = UIAlertAction(title: "OK",style: UIAlertActionStyle.Default, handler:
            {
                (action:UIAlertAction!) in
                self.session.startRunning()
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
