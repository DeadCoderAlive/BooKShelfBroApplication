

      BookShelfBroApplication

Need to run it on a live phone to scan the barcode  and 
Click on  the get the scanned barcode to get the barcode. And enter the details of the book and click save to save the book.

BookTableViewController
This controller enables the list of books in the datastore to be listed on each cell of the table.
Each cell contains a label and an image which is the image of the book and the label is the title of the book.

BarViewController
The camera preview layer is set on the view from the AV device and the device has to be held in landscape orientation to scan the barcode and as soon as the barcode is scanned.
It converts the image data is compared with available barcode formats  and the appropriate barcode string is retrived and it segues to the next controller

AddBookViewController
It has the necessary text fields to input the attributes of the book and it passes these attributes to the CRUDPersistAPI which stores this info into the dataStore.

BookDetailViewController
The book detail controller lists the attributes of the selected book from the BookTableviewController.

CRUDPersistAPI
This initiates to load the available data from the datastore or create a new datastore for the application.
All the objects to be stored are stored through this API and to fetch from the datastore are fetched using the helper methods of the API.
