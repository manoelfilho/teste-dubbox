//
//  LoginView.swift
//  Dubbox
//
//  Created by Manoel Filho on 02/07/21.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: Proprerties
    let defaults = UserDefaults.standard
    @ObservedObject var userData: UserData

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showing_password: Bool = false
    @State private var height: CGFloat = 0
    @State private var showing_signupview: Bool = false
    
    //MARK: Functions
    func login(){
        let encoder = JSONEncoder()
        Webservice().login(email: self.email, password: self.password){ result in
            switch result {
            case .success(let response):
                
                if let response_encoded = try? encoder.encode(response) {
                    defaults.set(response_encoded, forKey: "auth")
                    DispatchQueue.main.async {
                        userData.loggedIn = true
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        
        ScrollView(self.height == 0 ? .init() : .vertical, showsIndicators: false){
            
            ZStack{
                
                VStack{
                    
                    //MARK: Background top
                    GeometryReader{ reader in
                        
                        ZStack{
                            
                            //imagem do bg
                            Image("bg-auth")
                                .resizable()
                                .scaledToFill()
                            
                            //simulacao overlay
                            Rectangle()
                                .fill(Color("bg"))
                                .opacity(0.9)
                            
                        }
                        //deixando a imagem presa no topo
                        .offset(y: -reader.frame(in: .global).minY)
                        
                    }
                    .frame(height: 15)
                    // Background top
                    
                    VStack(alignment: .leading){
                        
                        //MARK: Logo
                        HStack(alignment: .center){
                            Spacer()
                            Text("Logo")
                                .font(.custom("Nunito-Black", size: 70))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        // Logo
                        
                        VStack{
                            
                            HStack{
                                
                                VStack{
                                    
                                    //MARK: Email
                                    VStack{
                                        HStack{
                                            
                                            Text(LocalizedStringKey("login_email"))
                                                .font(.footnote)
                                                .foregroundColor(Color("font-gray"))
                                            Spacer()
                                            
                                        }
                                        HStack {
                            
                                            Image(systemName: "envelope")
                                                .foregroundColor(Color("font-gray"))
                                            
                                            TextField(LocalizedStringKey("login_write_your_email"), text: $email)
                                                .font(.custom("Nunito-Regular", size: 16))
                                                .foregroundColor(Color("font-gray"))
                                                .keyboardType(.emailAddress)
                                                .autocapitalization(.none)
                            
                                        }
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(lineWidth: 1)
                                                .foregroundColor(Color("font-gray"))
                                        )
                                    }
                                    // Email
                                    
                                    //MARK: Password
                                    VStack{
                                        
                                        HStack{
                                            Text(LocalizedStringKey("login_password"))
                                                .font(.footnote)
                                                .foregroundColor(Color("font-gray"))
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            
                                            Image(systemName: "lock")
                                                .foregroundColor(Color("font-gray"))
                                            
                                            if self.showing_password {
                                                TextField(LocalizedStringKey("login_write_password"), text: $password)
                                                    .font(.custom("Nunito-Regular", size: 16))
                                                    .foregroundColor(Color("font-gray"))
                                            }else{
                                                SecureField(LocalizedStringKey("login_write_password"), text: $password)
                                                    .font(.custom("Nunito-Regular", size: 16))
                                                    .foregroundColor(Color("font-gray"))
                                            }
                                            
                                            Button(
                                                action:{
                                                    self.showing_password.toggle()
                                                }
                                            ){
                                                Image(systemName: self.showing_password ? "eye" : "eye.slash.fill")
                                                    .foregroundColor(Color("font-gray"))
                                            }
                            
                                        }
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(lineWidth: 1)
                                                .foregroundColor(Color("font-gray"))
                                        )
                                    }
                                    //Password
                                    
                                    //MARK: Did you lost your password
                                    HStack{
                                        Button(
                                            action: {
                                                //action
                                            }
                                        ){
                                            Text(LocalizedStringKey("login_did_you_lost_your_password"))
                                                .font(.custom("Nunito-Regular", size: 15))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("bg"))
                                            Spacer()
                                        }
                                    }
                                    .padding(.top, 10)
                                    
                                    //MARK: Enter
                                    Button(
                                        action:{
                                            self.login()
                                        }
                                    ){
                                        ZStack{
                                            
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(height: 50)
                                                .accentColor(Color("green-clear"))
                                            
                                            Text(LocalizedStringKey("login_enter"))
                                                .font(.custom("Nunito-Regular", size: 20))
                                                .fontWeight(.regular)
                                                .foregroundColor(.white)
                                            
                                        }
                                    }
                                    .padding(.top, 20)
                                    .disabled(self.email.isEmpty || !self.email.isValidEmail || self.password.isEmpty)
                                    
                                    Text(LocalizedStringKey("login_or"))
                                        .font(.custom("Nunito-Regular", size: 15))
                                        .foregroundColor(Color("font-gray"))
                                    
                                    //MARK: Login with google and facebook
                                    HStack{
                                        Spacer()
                                        
                                        Button(
                                            action:{
                                                //action
                                            }
                                        ){
                                            Image("icon-google")
                                        }
                                        .padding(.horizontal)
                                                                        
                                        Button(
                                            action:{
                                                //action
                                            }
                                        ){
                                            Image("icon-facebook")
                                        }
                                        .padding(.horizontal)
                                        
                                        Spacer()
                                    }
                                    
                                }
                                
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 30)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color("transparent"), radius: 6, x: 0, y: 8)
                            
                            //MARK: Your first time?
                            HStack{
                                Text(LocalizedStringKey("login_your_first_time"))
                                    .font(.custom("Nunito-Regular", size: 15))
                                    .foregroundColor(Color("font-gray"))
                                Button(
                                    action: {
                                        self.showing_signupview.toggle()
                                    }
                                ){
                                    Text(LocalizedStringKey("login_join_us"))
                                        .font(.custom("Nunito-Regular", size: 15))
                                        .foregroundColor(Color("bg"))
                                }
                            }
                            .padding(.top, 15)
                            .padding(.bottom, 15)
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal, 30)
                        
                        Spacer()
                        
                    }
                    
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
            }
            
        }
        .padding(.bottom, self.height) //move o conteudo para cima de acordo com o valor de height
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { (not) in
                let data = not.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
                let heiht = data.cgRectValue.height - (UIApplication.shared.windows.first?.safeAreaInsets.bottom)!
                self.height = heiht
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { (_) in
                self.height = 0
            }
        }
        .fullScreenCover(isPresented: $showing_signupview){
            SignupView(userData: self.userData)
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(userData: UserData())
    }
}
