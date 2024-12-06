//
//  TagsCollectionView.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//

import UIKit
import Foundation

class TagsCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 5, height: 50)
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    weak var delegate: HomePageViewModel?
    
    private(set) var pressedTag: Int?
    private(set) var tags: [Tag] = []

    init() {
        super.init(frame: .zero)
        setupCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollection() {
        collectionView.register(TagsCollectionViewCell.self, forCellWithReuseIdentifier: TagsCollectionViewCell.reuseIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func disableUserInteraction() {
        collectionView.isUserInteractionEnabled = false
    }
    
    func updateTags(_ newTags: [Tag]) {
        self.tags = newTags
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.reuseIdentifier, for: indexPath) as! TagsCollectionViewCell
        let tag = tags[indexPath.item]
        cell.configureCell(with: tag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagsCollectionViewCell else { return }
        let tag = tags[indexPath.item]
        
        
        if let pressedTag, let previousCell = collectionView.cellForItem(at: IndexPath(item: pressedTag, section: 0)) as? TagsCollectionViewCell {
            previousCell.returnToInitialState()
            
        }
        
        if let pressedTag {
            delegate?.fetchQuestions()
            self.pressedTag = nil
            cell.returnToInitialState()
        } else {
            delegate?.fetchQuestions(tag: tag.name)
            cell.cellPressed(with: tag)
            pressedTag = indexPath.item
        }
    }
}

extension TagsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 10 , height: 24)
    }
}
