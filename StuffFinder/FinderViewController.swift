//
//  FinderViewController.swift
//  StuffFinder
//
//  Created by Arpit Lokwani on 12/20/16.
//  Copyright © 2016 Arpit Lokwani. All rights reserved.
//

import UIKit
import CoreData

class FinderViewController: UIViewController,UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource {

    var dataArray = [String]()
    var filteredArray = [String]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var stuffDetails = [NSManagedObject]()
    

    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray.removeAll()
      //  loadListOfCountries()
        configureSearchController()
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
        let managedContext = Helper.sharedDelegate().persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StuffDetail")
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            stuffDetails = results as! [NSManagedObject]

           
            
            let i = stuffDetails.count
            
            for index in 0...i-1 {
                 let stuff = stuffDetails[index]
                dataArray.append(stuff.value(forKey: "name") as! String)
            }
            //dataArray = stuffDetails.count
            //
            //   print(stuff.value(forKey: "imageData"))
           // let image : UIImage = UIImage(data: (stuff.value(forKey: "imageData") as! Data))!
           // print(image)

        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        


        
              // self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    func loadListOfCountries() {
        // Specify the path to the countries list file.
        let pathToFile = Bundle.main.path(forResource: "country", ofType: "txt")
        
        if let path = pathToFile {
            let countriesString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
            dataArray = (countriesString?.components(separatedBy:"\n"))!
            searchResultTableView.reloadData()
        }
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor.orange
        searchController.searchBar.sizeToFit()
        searchResultTableView.tableHeaderView = searchController.searchBar

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath as IndexPath) as! SearchTableViewCell
        let stuff = stuffDetails[indexPath.row]
        
       
     
        
        if shouldShowSearchResults {
            //cell.searchTitleLabel?.text = stuff.value(forKey: "name") as! String?
            cell.searchTitleLabel?.text = filteredArray[indexPath.row]
        }else {
            
          
           // cell.searchTitleLabel?.text = stuff.value(forKey: "name") as! String?
            cell.searchTitleLabel?.text = dataArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let next = self.storyboard?.instantiateViewController(withIdentifier: "FinderDetailViewController") as! FinderDetailViewController
        next.stuffDetails = stuffDetails[indexPath.row]
        self.navigationController?.pushViewController(next, animated: true)

//        let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("storyBoardIdFor your new ViewController") as SecondViewController
//        
//        self.navigationController.pushViewController(secondViewController, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        filteredArray = filterContentForSearchText(searchText: searchString!)
       // print(filteredArray)
        
        if filteredArray.count>0 {
            shouldShowSearchResults = true
            searchResultTableView.reloadData()
        }
    }
    
    func filterContentForSearchText(searchText: String) -> Array<String>{
        let filterdItemsArrays = dataArray.filter { item in
            return item.lowercased().contains(searchText.lowercased())
        }
        return filterdItemsArrays
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            searchResultTableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
        searchResultTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        shouldShowSearchResults = false
        searchResultTableView.reloadData()
    }
}
