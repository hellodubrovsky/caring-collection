import UIKit

class ViewController: UIViewController {

    private enum Section {
        case firstSection
    }

    private let elements = (0...30).map { $0 }
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>?

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: CollectionLayout())
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        configureDataSource()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.frame
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 100, left: collectionView.layoutMargins.left, bottom: 0, right: 0)
    }


    // MARK: DataSource

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: self.collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: Int) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.accessibilityIdentifier = String(item)
            cell.backgroundColor = .systemGray5
            cell.layer.cornerRadius = 10
            return cell
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.firstSection])
        snapshot.appendItems(elements)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

