//
//  BookListViewController.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/8/17.
//  Copyright (c) 2017 Artem Lyksa. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol BookListViewControllerInput
{
    func displayBookList(viewModel: BookList.GetBookList.ViewModel)
    func displayBookImage(viewModel: BookList.GetBookImage.ViewModel)
}

protocol BookListViewControllerOutput
{
    func getBookList(request: BookList.GetBookList.Request)
    func getImage(request: BookList.GetBookImage.Request)
    func stopLoadingImage(request: BookList.StopLoadingImageProcess.Request)
    func removeBookList(request:BookList.RemoveBookList.Request)
}

class BookListViewController: UIViewController, BookListViewControllerInput
{
    
    var output: BookListViewControllerOutput!
    var router: BookListRouter!
    var dataSource: [Book] = []
    var heights = [IndexPath:CGFloat]()
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    // MARK: - Object lifecycle
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        tabBarController?.navigationItem.hidesBackButton = true
        BookListConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tabBarController?.navigationController?.view.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView.init()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        output.stopLoadingImage(request: BookList.StopLoadingImageProcess.Request())
    }
    
    func displayBookList(viewModel: BookList.GetBookList.ViewModel) {
        dataSource = viewModel.bookList
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func displayBookImage(viewModel: BookList.GetBookImage.ViewModel) {
        guard let row = dataSource.index(of: viewModel.book) else { return }
        let indexPath = IndexPath(row: row, section: 0)
        DispatchQueue.main.async {
            if let visiblePaths = self.tableView.indexPathsForVisibleRows, visiblePaths.contains(indexPath) {
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let bookCell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        let book = dataSource[indexPath.row]
        bookCell.bookNameLabel.text = book.name
        bookCell.bookAuthorLabel.text = book.authors
        if let image = book.image {
            bookCell.bookImageView.image = image
        } else {
            output.getImage(request: BookList.GetBookImage.Request(book: book))
        }
        return bookCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if (cell.frame.size.height > 0) {
            heights[indexPath] = cell.frame.size.height
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if let height = heights[indexPath], height > 10.0 {
            return height
        } else {
            return 100.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        router.navigateToBookDetailsScene(fromIndexPath: indexPath)
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if let text = searchBar.text, text.characters.count > 0 {
            activityIndicator = UIActivityIndicatorView.init(frame: view.frame)
            activityIndicator.activityIndicatorViewStyle = .whiteLarge
            activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            activityIndicator.center = view.center
            activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            UIApplication.shared.keyWindow?.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            output.getBookList(request: BookList.GetBookList.Request(searchString: text))
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.characters.count == 0 {
            output.removeBookList(request: BookList.RemoveBookList.Request())
        }
    }
}
