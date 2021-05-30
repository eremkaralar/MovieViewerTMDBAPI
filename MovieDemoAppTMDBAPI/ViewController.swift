//
//  ViewController.swift
//  MovieDemoAppTMDBAPI
//
//  Created by Erem Karalar on 1.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var searchController : UISearchController!
    
    let networker = NetworkManager.shared
      
    var posts: [Movie] = []
    
    private let spacing: CGFloat = 10
    
    var randosearchWords : [String] = ["Star","Red","Blue","Baby","Fun","Do","Can"]
    var randoNum = Int.random(in: 0..<6)
//    let defaultsearch = randosearchWords[randoNum]
    //var defaultsearch = "Star"
    
 
    @IBAction func SegmentSelected(_ sender: Any) {
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            let defaultsearch = randosearchWords[randoNum]
            NetworkManager.shared.getMovies(name: defaultsearch) { (data, Error) -> (Void) in
                if(data == nil){
                }
                else{
                self.posts = data!
                self.CollectionView.reloadData()
                }
            }
                  DispatchQueue.main.async {
                    self.CollectionView.reloadData()
                }
        }
         if (sender as AnyObject).selectedSegmentIndex == 1 {
            NetworkManager.shared.getpopularMovies{(data, Error) -> (Void) in
                if(data == nil){
                }
                else{
                self.posts = data!
                self.CollectionView.reloadData()
                }
            }
                  DispatchQueue.main.async {
                    self.CollectionView.reloadData()
                }
        }
        else if (sender as AnyObject).selectedSegmentIndex == 2 {
            NetworkManager.shared.getupcomingMovies{(data, Error) -> (Void) in
                if(data == nil){
                }
                else{
                self.posts = data!
                self.CollectionView.reloadData()
                }
            }
                  DispatchQueue.main.async {
                    self.CollectionView.reloadData()
                }
        }
    }
    
    @IBOutlet weak var CollectionView: UICollectionView!
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "The TMDB Movies"
        
       
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        CollectionView.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        let defaultsearch = randosearchWords[randoNum]
        NetworkManager.shared.getMovies(name: defaultsearch) { (data, Error) -> (Void) in
            if(data == nil){
                    
            }
            else{
            self.posts = data!
            self.CollectionView.reloadData()
            }
        }
        
              DispatchQueue.main.async {
                self.CollectionView.reloadData()
            }
              
        let layout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
               layout.minimumLineSpacing = spacing
               layout.minimumInteritemSpacing = spacing
               self.CollectionView?.collectionViewLayout = layout
        
       
        self.searchController = UISearchController(searchResultsController:nil)

        
         self.searchController.delegate = self
         self.searchController.searchBar.delegate = self
         self.searchController.hidesNavigationBarDuringPresentation = false
         self.searchController.obscuresBackgroundDuringPresentation = false
         searchController.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchController.searchBar
        }
    }
extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text != nil else { return }
        if(searchController.searchBar.text == nil){
            searchController.searchBar.text = "Star"
        }
        NetworkManager.shared.getMovies(name: searchBar.text!) { (data, Error) -> (Void) in
            if(data == nil){
            }
            else{
            self.posts = data!
            self.CollectionView.reloadData()
            }
        }
              DispatchQueue.main.async {
                self.CollectionView.reloadData()
            }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
        
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController
       
        vc?.MovieDetail = posts[indexPath.row]

        self.navigationController?.pushViewController(vc!, animated: true)
    }

}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (posts.count == 0) {
                collectionView.setEmptyMessage("It's been a slow year \n Nothing much to show here...")
            }
        else{
            collectionView.restore()
        }
        return posts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
               cell.layer.cornerRadius = 10.0
               cell.layer.borderWidth = 0.0
               cell.layer.shadowColor = UIColor.black.cgColor
               cell.layer.shadowOffset = CGSize(width: 0, height: 0)
               cell.layer.shadowRadius = 5.0
               cell.layer.shadowOpacity = 1
               cell.layer.masksToBounds = false
        
                let post = posts[indexPath.item]
                cell.image = nil
        
            
            func image(data: Data?) -> UIImage? {
              if let data = data {
                return UIImage(data: data)
              }
              return UIImage(systemName: "picture")
            }
        
        networker.image(post: post) { data, error  in
          let img = image(data: data)
          DispatchQueue.main.async {
              cell.image = img
          }
        }
        cell.MovieNameLabel.text = posts[indexPath.row].title
       
        cell.MovieNameLabel.adjustsFontSizeToFitWidth = true
       
            return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 10
    
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
                
                if let collection = self.CollectionView{
                    let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                    return CGSize(width: width, height: width*2)
                }else{
                    return CGSize(width: 0, height: 0)
                }
    }    
}

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            messageLabel.text = message
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
            messageLabel.sizeToFit()

            self.backgroundView = messageLabel;
        }
    
    func restore() {
           self.backgroundView = nil
       }
}
