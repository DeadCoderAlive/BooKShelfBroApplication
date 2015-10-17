//
//  AddBookViewController.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/17/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    
    var barView = BarViewController()
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var bookPages: UITextField!
    @IBOutlet weak var readBook: UISegmentedControl!
    var readbook: String! = "Has Read"
    var bcode: String! = ""
    var getDetails = GetBookDetails()
    
   
    @IBOutlet weak var EnterDetailsLabel: UILabel!
       var bookAPI = BookShelfAPI()
    
    @IBOutlet weak var bCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func readBook(sender: AnyObject) {
        if(readBook.selectedSegmentIndex == 0){
         readbook = "Has Read";
            
        }
        else {
            readbook = "Has Not Read"
        }
    }
   
    @IBAction func saveBook(sender: AnyObject) {
        /*bookTitle.text! =  ||  bookAuthor.text! = nil ||  bookPages.text! = nil) {
            noDetailsEntered()
        }*/
        bookAPI.insertIntoDataStore(bookTitle.text!, bookAuthor: bookAuthor.text!, bookPages: bookPages.text!, read: readbook!,barCode: bCode.text!)
        let alertController = UIAlertController(title: "Success", message: "Book was added succesfully", preferredStyle: .Alert)
        
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
            self.performSegueWithIdentifier("BackToTable", sender: self)
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
    }
    func noDetailsEntered() {
        self.EnterDetailsLabel.text = "No Details Entered"
    }
    
    @IBOutlet weak var setBarCode: UIButton!
    
    @IBAction func setBarCode(sender: AnyObject) {
               print(bcode)
        bCode.text = bcode
        getDetails.updateLostAndFound()
    }
}
