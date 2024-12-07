//
//  Untitled.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 07.12.24.
//
import UIKit

protocol AddQuestionTagsCollectionDelegate: AnyObject {
    func didSelectTag(_ tag: Tag)
    func removeTag(_ tag: Tag)
}

class AddQuestionTagsCollection: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    weak var delegate: AddQuestionTagsCollectionDelegate?
    
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
    
    private var pressedTag: [Int] = []
    private var tags: [Tag] = []
    
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
    
    func getTag() -> String? {
        guard let id = pressedTag.first else { return nil }
        let tag = tags[id]
        return tag.name
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
        
        if pressedTag.contains(indexPath.item) {
            pressedTag.removeAll { $0 == indexPath.item }
            cell.returnToInitialState()
            delegate?.removeTag(tag)
        } else {
            cell.cellPressed(with: tag)
            pressedTag.append(indexPath.item)
            delegate?.didSelectTag(tag)
        }
    }
}
