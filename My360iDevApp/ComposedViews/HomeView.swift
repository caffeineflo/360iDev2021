import Foundation
import SwiftUI

struct LoginView: View {
    @ObservedObject var loginManager: LoginManager
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Group {
                TextField("Username", text: $username)
                TextField("Password", text: $password)
            }.padding(EdgeInsets(top: 0,
                                 leading: 16,
                                 bottom: 0,
                                 trailing: 0))
            Button("Login") {
                loginManager.login(username: username, password: password)
            }
        }
    }
}

struct HomeView: View {
    @StateObject var loginManager = LoginManager()
    
    var body: some View {
        VStack {
            if let user = loginManager.loggedInUser {
                Text("Welcome \(user)")
            } else {
                LoginView(loginManager: loginManager)
            }
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    @StateObject static var loginManager = LoginManager()
    
    static var previews: some View {
        LoginView(loginManager: LoginManager())
    }
}
#endif
