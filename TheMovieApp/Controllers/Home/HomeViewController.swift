//
//  HomeViewController.swift
//  TheMovieApp
//
//  Created by Chandra Rao on 26/06/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tblMovieList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var currentPage : Int = 1
    
    var arrPopularMovies :NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        activityIndicator.startAnimating()
        
        tblMovieList.addInfiniteScrolling {
            self.activityIndicator.startAnimating()
            self.currentPage = self.currentPage + 1
            self.getPopularMovies(withPageNumber: self.currentPage)
        }
        
        getPopularMovies(withPageNumber: currentPage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // MARK: - API Call to Get Popular Movies
    
    func getPopularMovies(withPageNumber pageNum: Int) {
        
        var query : String = Constants.EnterApiKey
        
        query = String(format: "%@=%@&%@=%@&%@=%@",query,Constants.APIKey,Constants.LanguageKey,Constants.LanguageEng,Constants.PageKey,String(pageNum))
        
        APIHelperS.sharedInstance.callGetApiWithMethod(withMethod: Constants.PopularMovies, andQueryString: query, successHandler: { (dictData) in
            
            self.stopIndicator()
            self.tblMovieList.infiniteScrollingView.stopAnimating()
            
            if let _ : NSArray = dictData.object(forKey: Constants.ResultsKey) as? NSArray {
                
                if self.arrPopularMovies.count > 0 {
                    self.arrPopularMovies.addObjects(from: dictData.object(forKey: Constants.ResultsKey) as? NSArray as! [Any])
                    DispatchQueue.main.async {
                        self.tblMovieList.reloadData()
                    }
                } else {
                    self.arrPopularMovies = NSMutableArray()
                    self.arrPopularMovies = (dictData.object(forKey: Constants.ResultsKey) as? NSArray)?.mutableCopy() as! NSMutableArray
                    self.sortMoviesBy(withParams: Constants.PopularityKey)
                    print(self.arrPopularMovies)
                    
                }
            } else {
                // Handel Error.
                self.showAlert(withTitleAndMessage: Constants.AlertKey, message: Constants.ProblemOccuredMsg)
            }
            
        }) { (strMessage) in
            self.stopIndicator()
            print(strMessage)
        }
        
    }
    
    // MARK: - Stop Activity Indicator
    
    func stopIndicator()  {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Show Alert
    
    func showAlert(withTitleAndMessage title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Sort Function
    
    func sortMoviesBy(withParams sortBy: String)  {
        
        var sortKey : String = ""
        if sortBy == Constants.DateKey {
            sortKey = Constants.ReleaseDateKey
        } else {
            sortKey = Constants.PopularityKey
        }
        
        let descriptor = NSSortDescriptor(key: sortKey, ascending: false)
        let descriptors = [descriptor]
        let reverseOrder = arrPopularMovies.sortedArray(using: descriptors)
        
        if reverseOrder.count > 0 {
            arrPopularMovies = NSMutableArray()
            arrPopularMovies.addObjects(from: reverseOrder)
            let indexPath = IndexPath(row: 0, section: 0)
            DispatchQueue.main.async {
                self.tblMovieList.reloadData()
                self.tblMovieList.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
            }
            
        }
    }
    
}

extension HomeViewController : UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPopularMovies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell : MoviesTableViewCell = tblMovieList.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        
        let dictMoviesData : NSDictionary = arrPopularMovies.object(at: indexPath.row) as! NSDictionary
        
        tableCell.lblMovieName.text = String(format: "%@",(dictMoviesData.object(forKey: Constants.OriginalTitle) as? String)!)
        if (dictMoviesData.object(forKey: Constants.BackgroundImage) as? String) != nil {
            let imageURL : String = String(format: "%@%@",Constants.ImageBASEURL,(dictMoviesData.object(forKey: Constants.BackgroundImage) as? String)!)
            tableCell.imgMovies.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: Constants.Placeholder))
        }
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dictMoviesData : NSDictionary = arrPopularMovies.object(at: indexPath.row) as! NSDictionary
        
        let detailVCLR : MovieDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        detailVCLR.dictPopularMovie = dictMoviesData.mutableCopy() as! NSMutableDictionary
        self.navigationController?.pushViewController(detailVCLR, animated: true)
    }
}
