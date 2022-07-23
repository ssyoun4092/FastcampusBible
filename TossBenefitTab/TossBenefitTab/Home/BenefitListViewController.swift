import UIKit

class BenefitListViewController: UIViewController {
    // 사용자는 포인트를 볼 수 있다.
    // 사용자는 오늘의 혜택을 볼 수 있다.
    // 사용자는 나머지 헤택 리스트를 볼 수 있다.

    // 사용자는 포인트 셀을 눌렀을 때, 포인트 상세 뷰로 넘어간다.
    // 사용자는 혜택 관련 셀을 눌렀을 때, 혜택 상세뷰로 넘어간다.

    // 기획, 디자인 -> 설계 ->

    @IBOutlet weak var collectionView: UICollectionView!

    typealias Item = AnyHashable

    enum Section: Int {
        case today
        case other
    }

    var datasource: UICollectionViewDiffableDataSource<Section, Item>!

    var todaySectionItems: [AnyHashable] = TodaySectionItem(point: .default, today: .today).sectionItems
    var otherSectionItems: [AnyHashable] = Benefit.others

    override func viewDidLoad() {
        super.viewDidLoad()

        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            let cell = self.configureCell(for: section, item: item, collectionView: collectionView, indexPath: indexPath)

            return cell
        })

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.today, .other])
        snapshot.appendItems(todaySectionItems, toSection: .today)
        snapshot.appendItems(otherSectionItems, toSection: .other)
        datasource.apply(snapshot)

        collectionView.collectionViewLayout = layout()

        navigationItem.title = "혜택"
    }

    private func configureCell(for section: Section, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        switch section {
        case .today:
            if let point = item as? MyPoint {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPointCell", for: indexPath) as! MyPointCell
                cell.configure(item: point)
                return cell
            } else if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayBenefitCell", for: indexPath) as! TodayBenefitCell
                cell.configure(item: benefit)
                return cell
            } else {

                return nil
            }
        case .other:
            if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
                cell.configure(item: benefit)
                return cell
            } else {

                return nil
            }
        }
    }

    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}
