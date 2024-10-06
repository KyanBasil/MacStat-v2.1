import SwiftUI
import Dispatch
import LocalAuthentication

@main
struct MacStatApp: App {
    
    let windowWidth: CGFloat = 388
    let windowheight: CGFloat = 430
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: windowWidth, height: windowheight)
                .background(VisualEffect().ignoresSafeArea())
                .onAppear {
                    NSApp.appearance = NSAppearance(named: .vibrantDark)
                    authenticateUser()
                }
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .windowSize) {}
        }
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Please authenticate to use MacStat"

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication successful
                    } else {
                        // Authentication failed
                        NSApp.terminate(nil)
                    }
                }
            }
        } else {
            // No biometry available
            NSApp.terminate(nil)
        }
    }
}
