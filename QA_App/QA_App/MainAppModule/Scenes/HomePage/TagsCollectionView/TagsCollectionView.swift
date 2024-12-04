//
//  TagsCollectionView.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//

import UIKit

class TagsCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    private var collectionView: UICollectionView?
    private var tags: [Tag]?
    
    weak var delegate: ReloadTable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollection()
    }
    
//    init(tags: [Tag]) {
//        super.init(frame: .zero)
//        self.tags = tags
//    }
    init(tags: [Tag], delegate: ReloadTable?) { // Accept delegate in the initializer
            super.init(frame: .zero)
            self.tags = tags
            self.delegate = delegate // Assign the delegate
            setupCollection()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.reuseIdentifier, for: indexPath) as! TagsCollectionViewCell
        guard let tag = tags?[indexPath.item].name else { return cell }
        cell.delegate = delegate
        cell.configureCell(with: tag)
        return cell
    }
}
