//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Chandra Rao on 26/06/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieOverView: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    var dictPopularMovie :NSMutableDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInitialView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Load Data
    
    func loadInitialView() {
        if (dictPopularMovie.object(forKey: Constants.BackgroundImage) as? String) != nil {
            let imageURL : String = String(format: "%@%@",Constants.ImageBASEURL,(dictPopularMovie.object(forKey: Constants.BackgroundImage) as? String)!)
            imgThumbnail.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: Constants.Placeholder))
        }
        
        lblMovieName.text = (dictPopularMovie.object(forKey: Constants.OriginalTitle) as? String)!
        lblMovieOverView.text = (dictPopularMovie.object(forKey: Constants.OverviewKey) as? String)!
        let ratings: Float = Float(truncating: dictPopularMovie.object(forKey: Constants.VoteAverageKey) as! NSNumber)
        lblRatings.text = (String(ratings))
        lblReleaseDate.text = (dictPopularMovie.object(forKey: Constants.ReleaseDateKey) as? String)!
        let popularity: Float = Float(truncating: dictPopularMovie.object(forKey: Constants.PopularityKey) as! NSNumber)
        lblPopularity.text = (String(popularity))
    }
    
}
