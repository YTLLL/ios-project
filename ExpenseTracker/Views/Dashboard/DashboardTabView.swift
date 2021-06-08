//
//  DashboardTabView.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/3/21.
//  Copyright © 2021 INFO449. All rights reserved.
//

import SwiftUI
import CoreData

// Tab View that contains two main subviews: pie chart with total expenses, and the breakdown of the categories
struct DashboardTabView: View {
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State var totalExpenses: Double?
    @State var categoriesSum: [CategorySum]?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                      }
                    if totalExpenses != nil {
                        Text("Total expenses")
                            .font(.largeTitle)
                            .foregroundColor(Color(#colorLiteral(red: 0.6296737591, green: 0.5162123076, blue: 1, alpha: 1)))
                        Text(totalExpenses!.formattedCurrencyText)
                            .font(.largeTitle)
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    } else {
                        Text("No expenses data\nPlease add your expenses in the transactions tab")
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .padding(.horizontal)
                    }
                    
                    if totalExpenses != nil && totalExpenses! > 0 {
                        PieChartView(
                            data: categoriesSum!.map { ($0.sum, $0.category.color) },
                            style: Styles.pieChartStyleOne,
                            form: CGSize(width: 300, height: 240),
                            dropShadow: false
                        )
                    }
                }
                .padding(.top,  100)
                .padding(.bottom, 100)
                .background(Color(#colorLiteral(red: 0.9494244456, green: 0.9222272635, blue: 0.9746300578, alpha: 1)))
                
                Divider()

                if categoriesSum != nil {
                    List {
                        
                    }
                    
                } else {
                    List {
                        Text("Breakdown").font(.headline).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).listRowBackground(Color(#colorLiteral(red: 0.6296737591, green: 0.5162123076, blue: 1, alpha: 1)))
                        ForEach(Category.allCases) { category in
                            NavigationLink(destination: BreakdownCategoryView(selectedCategories: Set(arrayLiteral: category), categoryName: category.rawValue)) {
                                CategoryRowView(category: category, sum: 0.00)
                            }
                        }.listRowBackground(Color(#colorLiteral(red: 0.9494244456, green: 0.9222272635, blue: 0.9746300578, alpha: 1)))
                    }
                }
                
            }
            .onAppear(perform: fetchTotalSums)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea([.top, .bottom])
        }
        
    }
    

    func fetchTotalSums() {
        ExpenseLog.fetchAllCategoriesTotalAmountSum(context: self.context) { (results) in
            guard !results.isEmpty else { return }
            
            let totalSum = results.map { $0.sum }.reduce(0, +)
            self.totalExpenses = totalSum
            self.categoriesSum = results.map({ (result) -> CategorySum in
                return CategorySum(sum: result.sum, category: result.category)
            })
            print(categoriesSum!)
        }
    }
}


struct CategorySum: Identifiable, Equatable {
    let sum: Double
    let category: Category
    
    var id: String { "\(category)\(sum)" }
}


struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
    }
}
