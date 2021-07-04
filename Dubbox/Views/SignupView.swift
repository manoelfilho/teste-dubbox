//
//  SignupView.swift
//  Dubbox
//
//  Created by Manoel Filho on 03/07/21.
//

import SwiftUI

struct SignupView: View {
    
    //MARK: Proprerties
    let defaults = UserDefaults.standard
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var userData: UserData
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showing_password: Bool = false
    @State private var showing_confirm_password: Bool = false
    @State private var height: CGFloat = 0
    @State private var showing_modal: Bool = false
    @State private var msg_modal: String = ""
    
    //keyboard
    @State private var confirme_password: String = ""
    
    //MARK: Function
    func register(){
        
        let encoder = JSONEncoder()
        
        let user = User(name: self.name, email: self.email, identity: nil, uuid: nil, phone: nil, birthday: nil, created_at: nil, password: self.password)
        
        Webservice().register(user: user){ result in
            switch result {
            case .success(let response):
                
                if let response_encoded = try? encoder.encode(response) {
                    defaults.set(response_encoded, forKey: "auth")
                    DispatchQueue.main.async {
                        userData.loggedIn = true
                    }
                }
                
            case .failure(let error):
                
                switch error {
                    case .emailAlreadyRegistered:
                        self.showing_modal = true
                        self.msg_modal = "Email já registrado"
                    case .invalidCredentials:
                        self.msg_modal = "Credenciais inválidas"
                    case .custom(errorMessage: let errorMessage):
                        self.msg_modal = errorMessage
                }

            
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
                                    
                                    //MARK: Name
                                    VStack{
                                        HStack{
                                            
                                            Text(LocalizedStringKey("signup_name"))
                                                .font(.footnote)
                                                .foregroundColor(Color("font-gray"))
                                            Spacer()
                                            
                                        }
                                        HStack {
                            
                                            Image(systemName: "person")
                                                .foregroundColor(Color("font-gray"))
                                            
                                            TextField(LocalizedStringKey("signup_write_your_name"), text: $name)
                                                .font(.custom("Nunito-Regular", size: 16))
                                                .foregroundColor(Color("font-gray"))
                            
                                        }
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(lineWidth: 1)
                                                .foregroundColor(Color("font-gray"))
                                        )
                                    }
                                    // Name
                                    
                                    //MARK: Email
                                    VStack{
                                        HStack{
                                            
                                            Text(LocalizedStringKey("signup_email"))
                                                .font(.footnote)
                                                .foregroundColor(Color("font-gray"))
                                            Spacer()
                                            
                                        }
                                        HStack {
                            
                                            Image(systemName: "envelope")
                                                .foregroundColor(Color("font-gray"))
                                            
                                            TextField(LocalizedStringKey("signup_write_your_email"), text: $email)
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
                                            Text(LocalizedStringKey("signup_password"))
                                                .font(.footnote)
                                                .foregroundColor(Color("font-gray"))
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            
                                            Image(systemName: "lock")
                                                .foregroundColor(Color("font-gray"))
                                            
                                            if showing_password {
                                                TextField(LocalizedStringKey("signup_write_your_password"), text: $password)
                                                    .font(.custom("Nunito-Regular", size: 16))
                                                    .foregroundColor(Color("font-gray"))
                                            }else{
                                                SecureField(LocalizedStringKey("signup_write_your_password"), text: $password)
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
                                    
                                    //MARK: Confirm Password
                                    VStack{
                                        
                                        HStack{
                                            Text(LocalizedStringKey("signup_confirm_password"))
                                                .font(.footnote)
                                                .foregroundColor(Color("font-gray"))
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            
                                            Image(systemName: "lock")
                                                .foregroundColor(Color("font-gray"))
                                            
                                            if self.showing_confirm_password {
                                                TextField(LocalizedStringKey("signup_repeat_password"), text: $confirme_password)
                                                    .font(.custom("Nunito-Regular", size: 16))
                                                    .foregroundColor(Color("font-gray"))
                                            }else{
                                                SecureField(LocalizedStringKey("signup_repeat_password"), text: $confirme_password)
                                                    .font(.custom("Nunito-Regular", size: 16))
                                                    .foregroundColor(Color("font-gray"))
                                            }
                                            
                                            Button(
                                                action:{
                                                    self.showing_confirm_password.toggle()
                                                }
                                            ){
                                                Image(systemName: self.showing_confirm_password ? "eye" : "eye.slash.fill")
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
                                    
                                    //MARK: ALERT
                                    HStack{
                                        if self.showing_modal {
                                            ZStack(){
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(height: 50)
                                                    .accentColor(Color.red)
                                                
                                                Text(self.msg_modal)
                                                    .font(.custom("Nunito-Regular", size: 15))
                                                    .fontWeight(.regular)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                    .padding(.top, 10)
                                    
                                    //MARK: Enter
                                    Button(
                                        action:{
                                            self.register()
                                        }
                                    ){
                                        ZStack{
                                            
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(height: 50)
                                                .accentColor(Color("green-clear"))
                                            
                                            Text(LocalizedStringKey("signup_create"))
                                                .font(.custom("Nunito-Regular", size: 20))
                                                .fontWeight(.regular)
                                                .foregroundColor(.white)
                                            
                                        }
                                    }
                                    .padding(.top, 10)
                                    .disabled(self.email.isEmpty || !self.email.isValidEmail || self.password.isEmpty || (self.password != self.confirme_password))
                                }
                                
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 30)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color("transparent"), radius: 6, x: 0, y: 8)
                            
                        }
                        .padding(.horizontal, 30)
                        
                        Spacer()
                        
                    }
                    
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
            }
            .overlay(
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(LocalizedStringKey("signup_login"))
                        .font(.custom("Nunito-Black", size: 12))
                        .foregroundColor(.white)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .border(Color.white, width: 2)
                        .cornerRadius(5)
                }
                .padding(.leading, 10)
                .padding(.top, 60)
                .frame(width: 130, height: 80)
                ,
                alignment: .topLeading
            )
            
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
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(userData: UserData())
    }
}
