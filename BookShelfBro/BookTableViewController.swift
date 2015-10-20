//
//  BookTableViewController.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/17/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    var bookList:Array<Books> = []
    var bookApi: BookShelfAPI!
    let image = "book.jpg"
    var index = Int()
     var selectedBook = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
            }
    override func viewWillAppear(animated: Bool) {
     self.bookApi = BookShelfAPI.sharedInstance
     self.bookList = self.bookApi.fetchFromDataStore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.bookList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath) as! BookTableViewCell
        let bookItem:Books!
        bookItem = bookList[indexPath.row]
        //book title on each cell
        cell.bookTitleOnCell.text = bookItem.bookTitle
        //sample image on each cell
        cell.bookImageOnCell.image = UIImage(named: image)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        index = indexPath.row
        //get the selected index of the cell
    }
    //segue to detailed view controller with the index of the selected row
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let destinationView = segue.destinationViewController as! BookDetailViewController
        let row = index
        print(row)
        destinationView.index = row
            destinationView.bookList = self.bookList
            
           }

    

}
