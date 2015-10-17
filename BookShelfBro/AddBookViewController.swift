//
//  AddBookViewController.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/17/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
     var bookAPI = BookShelfAPI()
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var bookPages: UITextField!
    @IBOutlet weak var readBook: UISegmentedControl!
    var readbook: String!
    
    
    @IBOutlet weak var barCode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func readBook(sender: AnyObject) {
        if(readBook.selectedSegmentIndex == 0){
         readbook = "Has Read";
            
        }
        else {
            readbook = "Has Not Read"
        }
    }
   
    @IBAction func saveBook(sender: AnyObject) {
        bookAPI.insertIntoDataStore(bookTitle.text!, bookAuthor: bookAuthor.text!, bookPages: bookPages.text!, read: readbook!)
        bookAPI.fetchFromDataStore()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
