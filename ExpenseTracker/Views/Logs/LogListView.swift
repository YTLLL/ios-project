//
//  LogListView.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/3/21.
//  Copyright © 2021 INFO449. All rights reserved.
//

import SwiftUI
import CoreData

// List with each of the expenses. Includes functions such as tap to edit, and swipe right to delete transaction.
struct LogListView: View {
    
    @State private var logToEdit: ExpenseLog?
    @State private var editMode = EditMode.inactive
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @FetchRequest(
        entity: ExpenseLog.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ExpenseLog.date, ascending: false)
        ]
    )
    private var result: FetchedResults<ExpenseLog>

    init(predicate: NSPredicate?, sortDescriptor: NSSortDescriptor) {
        let fetchRequest = NSFetchRequest<ExpenseLog>(entityName: ExpenseLog.entity().name ?? "ExpenseLog")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        _result = FetchRequest(fetchRequest: fetchRequest)
    }
    
    var body: some View {
        List {
            ForEach(result, id: \.id) { (log: ExpenseLog) in
                Button(action: {
                    logToEdit = log
                }) {
                    HStack(spacing: 16) {
                        CategoryImageView(category: log.categoryEnum)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(log.nameText).font(.headline).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            Text(log.dateText).font(.subheadline).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        }
                        Spacer()
                        Text(log.amountText).font(.headline).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    }
                }
                .sheet(item: $logToEdit) { item in
                    LogFormView(
                        logToEdit: item,
                        context: self.context,
                        name: item.name ?? "",
                        amount: item.amount?.doubleValue ?? 0,
                        category: Category(rawValue: item.category ?? "") ?? .food,
                        date: item.date ?? Date()
                    )
                    
                }
            }
            .onDelete(perform: onDelete)
            .listRowBackground(Color(#colorLiteral(red: 0.9494244456, green: 0.9222272635, blue: 0.9746300578, alpha: 1)))

        }
    }
    
    // swipe right to delete expense
    private func onDelete(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let log = result[index]
            context.delete(log)
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

struct LogListView_Previews: PreviewProvider {
    static var previews: some View {
        let stack = CoreDataStack(containerName: "ExpenseTracker")
        let sortDescriptor = ExpenseLogSort(sortType: .date, sortOrder: .descending).sortDescriptor
        return LogListView(predicate: nil, sortDescriptor: sortDescriptor)
            .environment(\.managedObjectContext, stack.viewContext)
    }
}
