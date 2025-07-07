//
//  AnimationCollectionLayout.swift
//  AutoLayout Practice
//
//  Created by 郭瑋 on 2021/11/20.
//

import UIKit

class AnimationCollectionLayout: UICollectionViewLayout {
    
    public var itemSize:CGSize = CGSize(width: 200 , height: 100)
    
    
    public var spacing:CGFloat = 16.0
    
    public var maxVisibleItem:Int = 4
    
    override func prepare() {
        super.prepare()
        assert(collectionView?.numberOfSections == 1,"Multiple section")
    }
    
    override open var collectionViewContentSize: CGSize{
        if collectionView == nil{ return CGSize.zero}
        let itemCount = CGFloat((collectionView!.numberOfItems(inSection: 0)))
        return CGSize(width: collectionView!.bounds.width * itemCount, height: collectionView!.bounds.height)
        
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        if collectionView == nil { return nil}
        
        let totalItemsCount = collectionView!.numberOfItems(inSection: 0)
        let pageWidth = collectionView!.bounds.width
        let minVisibleIndex = max(0, Int(collectionView!.contentOffset.x / pageWidth))

        let maxVisibleIndex = min(totalItemsCount, minVisibleIndex + maxVisibleItem)

        let contentCenterX = collectionView!.contentOffset.x + pageWidth / 2

        let deltaOffset = collectionView!.contentOffset.x - CGFloat(minVisibleIndex) * pageWidth

        let percentageDeltaOffset = deltaOffset / pageWidth
        
        //print("CollectionView.contentOffset.x",collectionView!.contentOffset.x)
        //print("collectionView!.bounds.width",collectionView!.bounds.width)
        //print("minVisibleIndex",minVisibleIndex)
        //print("maxVisibleIndex",maxVisibleIndex)
        //print("DeltaOffset",deltaOffset)
        
        //print("---------only one ----------")
        
        var attributes = [UICollectionViewLayoutAttributes]()
        
        for i in minVisibleIndex..<maxVisibleIndex {
            let attribute = computeLayoutAttributesForItem(indexPath: IndexPath(item: i, section: 0),
                                                         minVisibleIndex: minVisibleIndex,
                                                         contentCenterX: contentCenterX,
                                                         deltaOffset: deltaOffset,
                                                         percentageDeltaOffset: percentageDeltaOffset)
            
            attributes.append(attribute)
        }
        
        return attributes
        
    }
    
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    func computeLayoutAttributesForItem(indexPath:IndexPath,
                                        minVisibleIndex:Int,
                                        contentCenterX:CGFloat,
                                        deltaOffset:CGFloat,
                                        percentageDeltaOffset:CGFloat) -> UICollectionViewLayoutAttributes{
        
        if collectionView == nil {
            return UICollectionViewLayoutAttributes(forCellWith: indexPath)
        }
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let cardIndex = indexPath.row - minVisibleIndex
        //print("IndexPath.row",indexPath.row,"miniVisibleIndex",minVisibleIndex)
        //print("CardIndex",cardIndex)
        attributes.size = itemSize
        attributes.center = CGPoint(x: contentCenterX + spacing * CGFloat(cardIndex),
                                    y: collectionView!.bounds.midY + spacing * CGFloat(cardIndex))
        //print("ContentCenterX",contentCenterX)
        //print("Attributes.center",attributes.center)
        

        attributes.zIndex = maxVisibleItem - cardIndex
        
        switch cardIndex {
        case 0:
            attributes.center.x -= deltaOffset
            //print("Switch 0:attributes.center.x",attributes.center.x,"DeltaOffset",deltaOffset)
            
        case 1..<maxVisibleItem:
            attributes.center.x -= spacing * percentageDeltaOffset
            attributes.center.y -= spacing * percentageDeltaOffset
            //print("Switch 1:attributes.center.x",attributes.center.x,"PercentageDeltaOffset",percentageDeltaOffset)
            //print("Switch 1:attributes.center.y",attributes.center.y,"PercentageDeltaOffset",percentageDeltaOffset)
            
            
            if cardIndex == maxVisibleItem - 1{
                attributes.alpha = percentageDeltaOffset
                //print("PerventageDeltaOffset",percentageDeltaOffset)
            }
        default:
            break
        }
    
        //print("--------------------------------")
        return attributes
    }

}
