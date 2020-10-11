//
//  MovieListVC.swift
//  BookMyShowAssignment
//
//  Created by Sourabh Kumbhar on 11/10/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var searchBar        : UISearchBar!
    @IBOutlet weak var movieTableView   : UITableView!
    @IBOutlet weak var searchTableView  : UITableView!
    @IBOutlet weak var movieTableViewTopConstraint: NSLayoutConstraint!
    
    // MARK: Local variables
    private var activityIndicator       = UIActivityIndicatorView()
    private var moviesArray             = Array<Result>()
    private var filteredMovieArray      = Array<Result>()
    private var recentSearchMovies      = Array<Result>()
    private var progressHud             : ProgressHUD?
    private var isSearch                = false
    private var pageNo                  = 0
    
    // MARK: View Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.callFetchMovies()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRecentSearchTableView()
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        setupMovieTableView()
        setupSearchBar()
        setupActivityIndicator()
    }
    
    private func setupMovieTableView() {
        // Set delegate to tableView
        movieTableView.delegate = self
        movieTableView.dataSource = self
        // Setup tableView UI
        movieTableView.tableFooterView = UIView()
        self.movieTableView.backgroundView = getTableViewBackgroundLabel()
        self.movieTableView.separatorColor = .clear
    }
    
    private func setupRecentSearchTableView() {
        // Set delegate to tableView
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        // Setup tableView UI
        searchTableView.isHidden = true
        searchTableView.tableFooterView = UIView()
        // Get recent movie searches from user default and assign to local variable and assgin it to tableView
        recentSearchMovies = UserDefaultHelper.getRecentSearchMovie()
        self.searchTableView.reloadData()
        self.searchTableView.backgroundView = getSearchTableViewBackgroundLabel()
    }
    
    private func setupProgressView() {
        progressHud = ProgressHUD(text: ConstantKey.fetchingData)
        self.view.addSubview(progressHud!)
    }
    
    private func setupSearchBar() {
        self.searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.smartInsertDeleteType = .no
        searchBar.isTranslucent = false
        searchBar.enablesReturnKeyAutomatically = false
    }
    
    private func setupActivityIndicator() {
        activityIndicator.style = .gray
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
    }

    // MARK: Network call
    private func callFetchMovies() {
        let networkServices = NetworkServices()
        movieTableView.backgroundView?.isHidden = true
        self.setupProgressView()
        // Call to network services
        pageNo = pageNo + 1
        let pageNoString = String(pageNo)
        networkServices.fetchMovieList(pageNo: pageNoString, completion: {
            (isSuccess, message, movie) in
            // Success form api
            if isSuccess {
                if let result = movie {
                    // append data to local variable
                    self.moviesArray.append(contentsOf: result.results)
                    // Handling UI
                    DispatchQueue.main.async {
                        self.progressHud?.hide()
                        self.movieTableView.reloadData()
                        self.movieTableView.backgroundView?.isHidden = true
                        self.activityIndicator.stopAnimating()
                    }
                }
                DispatchQueue.main.async {
                    self.progressHud?.hide()
                }
            } else {
                // Error from api
                DispatchQueue.main.async {
                    // Handling UI
                    self.progressHud?.hide()
                    let okAction = UIAlertAction(title: ConstantKey.ok, style: .default, handler: {
                        action in
                        self.movieTableView.backgroundView?.isHidden = false
                    })
                    self.showAlert(title: ConstantKey.error, message: message ?? ConstantKey.error, actions: [okAction])
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
}

//  MARK:- TableView Delegates and DataSource

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Check condition for which tableView
        if tableView == searchTableView {
            // Set no search found label according to array
            if recentSearchMovies.count == 0 {
                searchTableView.backgroundView?.isHidden = false
            } else {
                searchTableView.backgroundView?.isHidden = true
            }
            return recentSearchMovies.count
        } else {
            // Check condition for is search movie from searchBar
            if isSearch {
                return filteredMovieArray.count
            } else {
                return moviesArray.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create cell object and assign movie data to it.
        if tableView == searchTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellConstant.recentSearchTableViewCell, for: indexPath) as! RecentSearchTableViewCell
            cell.separatorInset = .zero
            // Condition check for array index out of bound
            if indexPath.row < recentSearchMovies.count {
                cell.configureCell(movie: recentSearchMovies[indexPath.row])
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellConstant.movieListTableViewCell, for: indexPath) as! MovieListTableViewCell
            // Condition check for array index out of bound
            if indexPath.row < moviesArray.count {
                // Check condition for is search movie from searchBar
                if isSearch {
                    let filterMovie = filteredMovieArray[indexPath.row]
                    cell.configureCell(movie: filterMovie)
                } else {
                    let movie = moviesArray[indexPath.row]
                    cell.configureCell(movie: movie)
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.searchTableView.isHidden = true
        self.searchBar.searchTextField.resignFirstResponder()
        if tableView == searchTableView {
            self.searchTableView.isHidden = true
            self.searchBar.text = ""
            if indexPath.row < recentSearchMovies.count {
                if let title = recentSearchMovies[indexPath.row].title {
                    self.searchBar.text = title
                    self.searchBar(searchBar, textDidChange: title)
                }
            }
        } else {
            // Create object of storyboard for navigate to next VC
            let mainStoryboard = UIStoryboard(name: ConstantKey.main, bundle: nil)
            if let movieDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifierConstant.movieDetailsVC) as? MovieDetailsVC {
                // Check condition for is search movie from searchBar
                if isSearch {
                    if indexPath.row < filteredMovieArray.count {
                        let selectedMovie = filteredMovieArray[indexPath.row]
                        // Pass the data to next vc
                        movieDetailsVC.movie = selectedMovie
                        // If search movie from search bar then select movie and store into userdefault
                        UserDefaultHelper.storeRecentSearchMoviw(movie: selectedMovie)
                    }
                } else {
                    if indexPath.row < moviesArray.count {
                        // Pass the data to next vc
                        movieDetailsVC.movie = moviesArray[indexPath.row]
                    }
                }
                // Navigate to next vc
                self.navigationController?.pushViewController(movieDetailsVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Show recent search title to tableView for recent search tableView
        if tableView == searchTableView {
            // Create label for recent search show
            let recentSearchLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            recentSearchLabel.text = ConstantKey.recentlySearched
            recentSearchLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            recentSearchLabel.backgroundColor = UIColor.gray
            return recentSearchLabel
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Crete header view for searchTableView
        if tableView == searchTableView {
            return 30
        } else {
            return 0
        }
    }
        
}

// MARK:- SearchBar Delegate and Datasource

extension MovieListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovieArray.removeAll()
        // Search algorithm
        for movie in moviesArray {
            if let movieTitle = movie.title {
                // Get movie title and create string array when more than 1 word
                let titleArray = movieTitle.components(separatedBy: " ")
                // iterate movie title array
                for title in titleArray {
                    // Check search text is prefix of movie title
                    if title.hasPrefix(searchText) {
                        filteredMovieArray.append(movie)
                    } else if searchText.hasPrefix(title) {
                        // Check condition title is prefix of search text
                        filteredMovieArray.append(movie)
                    } else {
                        
                    }
                }
            }
        }
        isSearch = true
        
        if searchText == "" {
            isSearch = false
        }
        movieTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        searchBar.text = ""
        resignFirstResponder()
        self.view.endEditing(true)
        movieTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTableView.isHidden = true
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchTableView.isHidden = false
        // Movie table slide down
        movieTableViewTopConstraint.constant = 150
        self.movieTableView.reloadData()
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        // Movie table slide up
        movieTableViewTopConstraint.constant = 0
        return true
    }
    
}

// MARK:- ScrollView Delegate

extension MovieListVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if  maximumOffset - currentOffset <= 10.0{
            activityIndicator.startAnimating()
            self.callFetchMovies()
        } else {
            activityIndicator.stopAnimating()
        }
         movieTableView.tableFooterView = activityIndicator
    }
}
