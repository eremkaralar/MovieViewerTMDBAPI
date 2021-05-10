//
//  MovieDetailViewController.swift
//  MovieDemoAppTMDBAPI
//
//  Created by Erem Karalar on 10.05.2021.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieDescription: UILabel!
    var MainViewController : ViewController?
    var post: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        if segue.identifier == "unwindToViewController" {
//            let viewController = segue.destination as! ViewController
//            let posts = sender as! Movie
//            viewController.posts = post
//            }
//    }
    
    
    @IBAction func Done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
