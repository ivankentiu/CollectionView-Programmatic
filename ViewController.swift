//
//  ViewController.swift
//  CollectionView
//
//  Created by Ivan Ken Tiu on 16/01/2018.
//  Copyright © 2018 Ivan Ken Tiu. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    private var addButton : UIBarButtonItem!
    private var deleteButton : UIBarButtonItem!
    
    var collectionData = ["1 😃", "2 📲", "3 🍘", "4 💲", "5 🐘"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteSelected))
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        collectionView?.refreshControl = refresh
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = editButtonItem
        
        toolbarItems = [deleteButton]
        navigationController?.isToolbarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addItem() {
        collectionView?.performBatchUpdates({
            for _ in 0..<2 {
                let text = "\(collectionData.count + 1) 😆"
                collectionData.append(text)
                let index = IndexPath(row: collectionData.count - 1, section: 0)
                collectionView?.insertItems(at: [index])
            }
        }, completion: nil)
    }
    
    @objc func deleteSelected() {
        if let selected = collectionView?.indexPathsForSelectedItems {
            let items = selected.map{$0.item}.sorted().reversed()
            for item in items {
                collectionData.remove(at: item)
            }
            collectionView?.deleteItems(at: selected)
            navigationController?.isToolbarHidden = true
        }
    }
    
    @objc func refresh() {
        collectionView?.refreshControl?.endRefreshing()
        addItem()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButton.isEnabled = !editing
        deleteButton.isEnabled = editing
        
        collectionView?.allowsMultipleSelection = editing
        
        let indexes = collectionView!.indexPathsForVisibleItems
        
        for index in indexes {
            let cell = collectionView?.cellForItem(at: index) as! CollectionViewCell
            cell.isEditing = editing
        }
        
        if !editing {
            navigationController?.isToolbarHidden = true
        } else {
            navigationController?.isToolbarHidden = false
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = collectionData[indexPath.item]
        cell.isEditing = isEditing
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            let detailsViewController = DetailsViewController()
            detailsViewController.selection = collectionData[indexPath.item]
            navigationController?.pushViewController(detailsViewController, animated: true)
        } else {
            navigationController?.isToolbarHidden = false
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            if let selected = collectionView.indexPathsForSelectedItems,
                selected.count == 0 {
                navigationController?.isToolbarHidden = true
            }
        }
    }
}



