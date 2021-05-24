//
//  ProductCellProvider.swift
//  ShoeApp
//
//  Created by Klimenkov, Kirill on 24.05.21.
//

import UIKit
import ExpandableCell

struct ProductDetailsViewModel {
    let descriptionModel: ProductDescriptionModel
    let compositionModels: [ProductCompositionModel]
    let designerText: String
}

class ProductCellProvider: NSObject, ExpandableDelegate {
    
    private struct Constants {
        static let numberOfLines = 5
        
        struct Cell {
            static let expandableHeight: CGFloat = 50
            static let contactsHeight: CGFloat = 180
            static let unknownHeight: CGFloat = 0
            static let compositionHeight: CGFloat = 88
        }
        
        struct Header {
            static let height: CGFloat = 200
        }
    }
    
    var headerView: UIView?
    
    private let viewModel: ProductDetailsViewModel
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
    }

    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        switch indexPath.row {
        case 0:
            return [viewModel.descriptionModel.getHeight(for: expandableTableView.frame.width)]
        case 1:
            return Array<CGFloat>(repeating: Constants.Cell.compositionHeight, count: viewModel.compositionModels.count)
        default:
            let width = expandableTableView.frame.width
            let font = UIFont.systemFont(ofSize: 14)
            let height = viewModel.designerText.heightWithConstrainedWidth(width: width - 40, font: font)
            return [height + 100]
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        switch indexPath.row {
        case 0:
            guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: ProductDescriptionCell.ID) as? ProductDescriptionCell else {
                return nil
            }
            cell.bind(model: viewModel.descriptionModel)
            return [cell]
            
        case 1:
            let cells = viewModel.compositionModels.map { model -> ProductCompositionCell? in
                guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: ProductCompositionCell.ID) as? ProductCompositionCell else {
                    return nil
                }
                
                cell.bind(model: model)
                return cell
            }.compactMap { $0 }
            return cells
            
        case 2:
            guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: DesignerCell.ID) as? DesignerCell else {
                return nil
            }
            cell.bind(text: viewModel.designerText)
            return [cell]
        default:
            return nil
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0...2:
            return Constants.Cell.expandableHeight
            
        case 3:
            return Constants.Cell.contactsHeight
            
        case 4:
            return UIScreen.main.bounds.height - UIScreen.main.bounds.height / 10
            
        default:
            return Constants.Cell.unknownHeight
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        Constants.numberOfLines
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var resultCell: UITableViewCell?
        
        switch indexPath.row {
        case 0...2:
            let cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandableDescriptionCell.ID) as? ExpandableDescriptionCell
            cell?.bind(title: getExpandableTitle(indexPath))
            resultCell = cell
            
        case 3:
            let cell = expandableTableView.dequeueReusableCell(withIdentifier: ContactsCell.ID) as? ContactsCell
            let firstModel = ContactModel(title: "Телефон", icon: UIImage(named: "call")!) {
                print("Call tapped")
            }
            let secondModel = ContactModel(title: "E-mail", icon: UIImage(named: "email")!) {
                print("Email tapped")
            }
            cell?.bind(firstModel: firstModel, secondModel: secondModel)
            resultCell = cell
            
        case 4:
            let cell = expandableTableView.dequeueReusableCell(withIdentifier: RecomendationCell.ID) as? RecomendationCell
            cell?.bind(model: RecomendationCellModel())
            resultCell = cell
            
        default:
            resultCell = nil
        }
        
        return resultCell ?? UITableViewCell()
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.Header.height
    }
    
    private func getExpandableTitle(_ indexPath: IndexPath) -> String {
        let titles = ["ОПИСАНИЕ", "СОСТАВ И УХОД", "О ДИЗАЙНЕРЕ"]
        return titles[indexPath.row]
    }
    
}
