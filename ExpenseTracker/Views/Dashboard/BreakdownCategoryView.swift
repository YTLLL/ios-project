//
//  BreakdownCategoryView.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/3/21.
//  Copyright © 2021 INFO449. All rights reserved.
//

import SwiftUI
import CoreData

// Similar to LogsTabsView except that it only shows 
struct BreakdownCategoryView: View {
    
    @Environment(\.managedObjectContext)
        var context: NSManagedObjectContext
    
    @State private var searchText : String = ""
    @State private var searchBarHeight: CGFloat = 0
    @State private var sortType = SortType.date
    @State private var sortOrder = SortOrder.descending
    
    @State var selectedCategories: Set<Category> = Set()
    @State var isAddFormPresented: Bool = false
    @State var categoryName: String

    var body: some View {
          VStack(spacing: 0) {
            Text(verbatim: "Category: \(categoryName.firstCapitalized)")
                .font(.headline)
                .padding(.top,  5)
                .padding(.bottom, 5)
            SearchBar(text: $searchText, keyboardHeight: $searchBarHeight, placeholder: "Search \(categoryName) expenses")
            Divider()
            SelectSortOrderView(sortType: $sortType, sortOrder: $sortOrder)
            Divider()
            LogListView(predicate: ExpenseLog.predicate(with: Array(selectedCategories), searchText: searchText), sortDescriptor: ExpenseLogSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
        }
        
    }
    
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}

//struct BreakdownCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        BreakdownCategoryView()
//    }
//}
