//
//  TagsCollectionView.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//

import UIKit
import Foundation

class TagsCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    private var isGeneral = true
    private var selectable = true
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
    
    weak var delegate: QuestionProtocol?
    
    private static var pressedTag: [Int] = []
    private var tags: [Tag] = []

    init() {
        super.init(frame: .zero)
        setupCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func valueDidChange(value: Bool) {
        isGeneral = value
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
        guard let id = TagsCollectionView.pressedTag.first else { return nil }
        let tag = tags[id]
        return tag.name
    }
    
    func disableUserInteraction() {
        selectable = false
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
        guard selectable == true else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagsCollectionViewCell else { return }
        let tag = tags[indexPath.item]
        
        for index in TagsCollectionView.pressedTag {
            if let previousCell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? TagsCollectionViewCell {
                previousCell.returnToInitialState()
            }
        }
        
        if TagsCollectionView.pressedTag.contains(indexPath.item) {
            if isGeneral {
                delegate?.fetchQuestions(tag: nil, search: nil)
            } else {
                delegate?.fetchPersonalQuestions(tag: nil, search: nil)
            }
            TagsCollectionView.pressedTag.removeAll { $0 == indexPath.item }
            cell.returnToInitialState()
        } else {
            if isGeneral {
                delegate?.fetchQuestions(tag: tag.name, search: nil)
            } else {
                delegate?.fetchPersonalQuestions(tag: tag.name, search: nil)
            }
            cell.cellPressed(with: tag)
            TagsCollectionView.pressedTag = [indexPath.item]
        }
    }
}

extension TagsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 10 , height: 24)
    }
}
