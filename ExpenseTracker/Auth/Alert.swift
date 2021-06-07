//
//  Alert.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/7/21.
//  Copyright © 2021 INFO449. All rights reserved.
//

import SwiftUI

enum AlertIntent {
    case info, success, question, danger, warning
}

struct Alert : View {
    
    var title: String
    var subtitle: String?
    var intent: AlertIntent = .info
    
    var body: some View {

        HStack(alignment: .top) {
               
                
            
                Image(systemName: "exclamationmark.triangle.fill")
                    .padding(.vertical)
                    .foregroundColor(Color.white)
            
            
            
                
                
                VStack(alignment: .leading) {
                    Text(self.title)
                        .font(.body)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)


                    if (self.subtitle != nil) {
                        Text(self.subtitle!)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)

                    }

                }.padding(.leading)
            
            }
                .padding()
                .background(Color.red)
        
    }
}

#if DEBUG
struct Alert_Previews : PreviewProvider {
    static var previews: some View {
        Alert(
            title: "Alert title",
            subtitle: "Alert subtitle",
            intent: .info
        ).frame(height: 300)
    }
}
#endif
