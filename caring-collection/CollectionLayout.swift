import UIKit

final class CollectionLayout: UICollectionViewFlowLayout {

    var itemsCount: CGFloat {
        CGFloat(collectionView?.numberOfItems(inSection: 0) ?? 0)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func prepare() {
        super.prepare()
        self.itemSize = CGSize(width: 300, height: 400)
        self.scrollDirection = .horizontal
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        guard let collection = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                             withScrollingVelocity: velocity)
        }
        let cellWithSpacing = itemSize.width + 10
        let relative = (proposedContentOffset.x + collection.contentInset.left) / cellWithSpacing
        let leftIndex = max(0, floor(relative))
        let rightIndex = min(ceil(relative), itemsCount)
        let leftCenter = leftIndex * cellWithSpacing - collection.contentInset.left
        let rightCenter = rightIndex * cellWithSpacing - collection.contentInset.left

        if abs(leftCenter - proposedContentOffset.x) < abs(rightCenter - proposedContentOffset.x) {
            return CGPoint(x: leftCenter, y: proposedContentOffset.y)
        } else {
            return CGPoint(x: rightCenter, y: proposedContentOffset.y)
        }
    }
}
