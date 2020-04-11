#!/usr/bin/swift

import ScriptingBridge // AppleScript yaaa

/**
 # NOTES TO SELF

 - **EVERYTHING MUST BE EXECUTED ON THE MAIN THREAD FOR THE CLI EDITION.**
 - Use `sleep`, not`DispatchQueue.main.asyncAfter`
 */

/// Generate an AppleScript command to send a system-wide keystroke
func applescriptSource_SendKeystroke(_ keystroke: String) -> String {
    
    debugPrintKeystroke(keystroke)
    
    // We only need the double quotes if we are sending an alphanumeric keystrokes.
    let keystrokeDelimeter = keystroke.count != 1 ? "" : "\""
    
    // return applescript code
    return "tell application \"System Events\" to keystroke \(keystrokeDelimeter)\(keystroke)\(keystrokeDelimeter)"
}

/// Execute AppleScript source code
func execute(appleScript: String) {
    
    /// AppleScript manager object
    guard let scriptObject = NSAppleScript(source: appleScript) else { return }
    
    /// Output of failed AppleScript execution
    var error: NSDictionary?
    
    /// Output of successful AppleScript execution
    guard let _: NSAppleEventDescriptor = scriptObject
        .executeAndReturnError(&error)
        else {
            // shoddy error handling ik
            fatalError(error?.description ?? "Applescript failed")
    }
    
}

/// Send a system-wide keystroke
func sendKeystroke(_ keystroke: Character) {
    
    /// Sanitised keystroke
    ///
    /// - Commas are redundant
    /// - Whitespace is a trigger to newline
    /// - `\n` syntax conversion to AppleScript constant `return`
    /// - For some reason, probably because of a Swift string literal syntax clash, double quotes fuck up the keystroke-into-AS-command interpolation
    let keystrokeToSend = String(keystroke)
        .replacingOccurrences(of: ",",  with: "")
        .replacingOccurrences(of: " ",  with: "return")
        .replacingOccurrences(of: "\n", with: "return")
        .replacingOccurrences(of: "\"", with: "")
    
    /// AppleScript code
    let applescript = applescriptSource_SendKeystroke(keystrokeToSend)
    
    /// YEEEEE
    execute(appleScript: applescript)
    
    // lets just hope it works
}

/// A little assurance that something's happening.
func debugPrintKeystroke(_ keystroke: String) {
    print(keystroke.replacingOccurrences(of: "return", with: "\n"), terminator: "")
}

func getArgument(
    _ index: Int,
    from args: [String],
    description: String
) -> String? {
    guard args.count > index else {
        print("FATAL ERROR: \(description) missing from arguments.")
        return nil
    }
    return args[index]
}

/// I believe a `main` function helps your pp grow.
func main(_ args: [String]) throws {
    
    guard let WORDS_LOCATION = getArgument(1, from: args, description: "Spam text location") else { return }
    
    /// Wordlist
    ///
    /// I would have wanted to wrap this in `@inline(__always)` but I can't because of the `guard` statement.
    guard let spamText = try? String(contentsOf: URL(fileURLWithPath: WORDS_LOCATION)) else {
        print("FATAL ERROR: Could not open specified words file '\(WORDS_LOCATION)'")
        return
    }
    
    // Iterate over the words
    spamText.forEach { keystroke in
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // give the system some breathing space

            // ⤵️ Kinda the whole point...
            sendKeystroke(keystroke)
//        }
    }

    /// Do the last one
    sendKeystroke(" ")
}

//DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Need time to get the right text box selected!
    print("You have 4 seconds to click a text box! Quick!")
    sleep(4)
    try! main(CommandLine.arguments)
    print("Completed")
//}
