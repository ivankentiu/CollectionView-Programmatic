//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by Ivan Ken Tiu on 16/01/2018.
//  Copyright © 2018 Ivan Ken Tiu. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectionImage: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "Unchecked")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var isEditing : Bool = false {
        didSet {
            selectionImage.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            selectionImage.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 0/255, alpha: 1)
        addSubview(titleLabel)
        addSubview(selectionImage)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        selectionImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        selectionImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        selectionImage.widthAnchor.constraint(equalToConstant: 22).isActive = true
        selectionImage.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
}
