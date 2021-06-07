//
//  SignInView.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/7/21.
//  Copyright © 2021 INFO449. All rights reserved.
//
import SwiftUI

struct SignUpView : View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session: SessionStore
    
    func signUp () {
        print("sign me up")
        loading = true
        error = false
        session.signUp(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                print("\(String(describing: error))")
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body : some View {
        VStack {
            
            Text("Create an account")
                .font(.title)
                .padding(.horizontal)
            
            TextField("Email", text: $email)
                .padding()
            
            VStack(alignment: .leading) {
                SecureField("Password", text: $password)
                Text("At least 8 characters required.").font(.footnote).foregroundColor(Color.gray)
                }.padding(.horizontal)
            
            if (error) {
                Alert(
                    title: "That didn't work.",
                    subtitle: "Are you sure you don't already have an account with that email address?"
                ).padding([.horizontal, .top])
               
            }
            
            CustomButton(
                label: "Sign up",
                action: signUp
                )
                .disabled(loading)
                .padding()
            
            
            Divider()
            
            Text("An account will allow you to save and access recipe information across devices. You can delete your account at any time and your information will not be shared.")
                .font(.footnote)
                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .padding()
            
            Spacer()
            
        }
        
    }
    
}

struct SignInView : View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session: SessionStore
    
    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            
            Group {
                Image("logo")
                    .resizable()
                    .frame(width: 75, height: 75)

                Text("Expense Tracker").font(.title).padding(.bottom)

                Text("The easiest way to track your daily expenses.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Spacer()
            
            Group {
                Divider()
               
            
                
                TextField("Email", text: $email)
                    .padding()
                
                SecureField("Password", text: $password)
                    .padding([.leading, .trailing])

                
                if (error) {
                    Alert(
                        title: "Hmm... That didn't work.",
                        subtitle: "Please check your email and password and try again"
                        ).padding([.horizontal, .top])
                    
                }
                

                NavigationLink(destination: ContentView()) {
                    CustomButton(
                        label: "Sign in",
                        action: signIn,
                        loading: loading
                        )
                        .padding()
                }
                
                
                
            }
            
            
            
            VStack {
                Divider()
                HStack(alignment: .center) {
                    Text("Don't have an account?")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                  
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign up.").font(.footnote)
                    }
                    }
                    .padding()
            }
            
            
        }
        
    }
}

struct CustomButton : View {
    var label: String
    var action: () -> Void
    var loading: Bool = false
    
    
    var body: some View {
        
        Button(action: action) {
            HStack {
                Spacer()
                Text(label)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            
            }
            .padding()
            .background(loading ? Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3) : Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
            .cornerRadius(5)
    }
}
    

struct AuthenticationScreen : View {
    
    
    var body : some View {
        NavigationView {
            SignInView()
        }
    }
}


#if DEBUG
struct Authenticate_Previews : PreviewProvider {
    static var previews: some View {
        AuthenticationScreen()
            .environmentObject(SessionStore())
    }
}
#endif
