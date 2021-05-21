//
//  MovieDetailViewController.swift
//  MovieDemoAppTMDBAPI
//
//  Created by Erem Karalar on 10.05.2021.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var MovieRDate: UILabel!
    @IBOutlet weak var MovieDescription: UILabel!
    
    @IBOutlet weak var orgLang: UILabel!
    
    @IBOutlet weak var popularityRate: UILabel!
    
    @IBOutlet weak var voteAverage: UILabel!
    
    var MainViewController : ViewController?
    
    var MovieDetail : Movie?
//    var Movietitle = ""
//    var Movieoverview = ""
//    var Moviereleasedate = ""
//    var MovieorgLang = ""
//    var Moviepopularity : Double = 0.0
//    var MovievoteAverage : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
       
        guard let movie = MovieDetail else{
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        self.navigationItem.title = movie.title
        
        MovieRDate.text = "Release Date: \(movie.release_date)"
        MovieDescription.text = "Description: \(movie.overview)"
        MovieDescription.adjustsFontSizeToFitWidth = true
        orgLang.text = "Original Language: \(movie.original_language)"
        popularityRate.text = "Popularity Rate: \(movie.popularity)"
        voteAverage.text = "Vote Average: \(movie.vote_average)"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
