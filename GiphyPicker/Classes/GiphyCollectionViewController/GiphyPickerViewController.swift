//
//  GiphyPickerViewController.swift
//  GiphyPicker
//
//  Created by daniele candotti on 29/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import UIKit

/// Shows a collection of Gifs
/// The controller contains one collectionView to show the gifs and
/// a UISearchbar on the top to perform search with querys

public final class GiphyPickerViewController: UIViewController, GiphyPickerInteractable {
    
    /// User taps on done button
    public var onTapOnDoneButton: (() -> ())?
    /// User taps over the media
    public var onTapOnMedia: ((GiphyInfo?, UIImage?) -> ())?
    /// CollectionView to show gifs
    @IBOutlet weak private var collectionView: UICollectionView!
    /// Searchbar to search the gif by query
    @IBOutlet weak private var searchBar: UISearchBar!
    /// Done button
    @IBOutlet weak private var doneButton: UIButton!
    /// CollectionView dataSource
    private var dataSource: GiphyPickerCollectionViewDataSource?
    /// CollectionView prefetcher
    private var prefetcher: GiphyPickerCollectionViewPrefetcher?
    /// CollectionView handler
    private var collectionViewHandler: CollectionViewInteractable?
    /// Data interactor
    private var dataInteractor: DataInteractable?
    /// Searchbar interactor
    private var searchBarInteractor: SearchBarInteractable?
    /// User interactor provides all actions done by the user
    private var userInteractor: GiphyCollectionViewUserInteractor?
    /// Hide done button
    public var hideDoneButton: Bool = false {
        didSet {
            if isViewLoaded {
                doneButton.isHidden = hideDoneButton
            }
        }
    }

    convenience init(dataInteractor: DataInteractable,
                     searchBarInteractor: SearchBarInteractable,
                     collectionViewHandler: CollectionViewInteractable,
                     userInteractor: GiphyCollectionViewUserInteractor? = nil) {
        let bundle = Bundle(for: GiphyPickerViewController.self)
        self.init(nibName: "GiphyPickerViewController", bundle: bundle)
        self.dataInteractor = dataInteractor
        self.dataSource = GiphyPickerCollectionViewDataSource(dataInteractor: dataInteractor)
        self.prefetcher = GiphyPickerCollectionViewPrefetcher(dataInteractor: dataInteractor)
        self.collectionViewHandler = collectionViewHandler
        self.searchBarInteractor = searchBarInteractor
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        searchBar.delegate = searchBarInteractor
        doneButton.isHidden = hideDoneButton
    }

    /// Setup CollectionView
    fileprivate func setupCollectionView() {
        let bundle = Bundle(for: self.classForCoder)
        let nib = UINib(nibName: "GiphyCollectionViewCell", bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: GiphyCollectionViewCellId)
        collectionView.collectionViewLayout = GiphyCollectionViewFlowLayout(dataInteractor: dataInteractor!)
        collectionView.dataSource = dataSource
        collectionView.isPrefetchingEnabled = true
        collectionView.prefetchDataSource = prefetcher
        collectionView.delegate = collectionViewHandler
        collectionView.keyboardDismissMode = .onDrag
    }

    /// Reload CollectionView and scroll to top
    /// This method must be called on the main thread
    func reloadForNewSearch() {
        collectionView.reloadData()
        if let interactor = dataInteractor, let data = interactor.data, data.count > 0 {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }

    /// Add new items in the CollectionView
    /// This method must be called on the main thread
    func addNewItems(itemsCount: Int) {
        let currentItems = collectionView.numberOfItems(inSection: 0)
        var indexPaths = Array<IndexPath>()
        for n in 0..<itemsCount {
            let indexPath = IndexPath(row: currentItems + n, section: 0)
            indexPaths.append(indexPath)
        }
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexPaths)
        }, completion: nil)

    }

    /// Show popup alert with message
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnDoneButton() {
        guard let onTapOnDoneButton = onTapOnDoneButton else {
            dismiss(animated: true, completion: nil)
            return
        }
        onTapOnDoneButton()
    }
}
