import gleam/string
import gleam/io
import shellout

fn simple_spawn(run, with) {shellout.command(run: run, with: with, in: ".", opt: [])}

pub type ClipboardError {
    UnsupportedRuntime
    MacError(String)
    AndroidError(String)
}

type Runtime {
  Android
  Mac
  // Windows
  // Linux
  Unsupported
}

fn linux_uname (uname_rest) {
    case string.contains(uname_rest, "android") {
        True -> Android
        False -> Unsupported
    }
}

fn uname_runtime() {
  case simple_spawn("uname", ["-a"]) {
    Ok("Darwin"<>_) -> Mac
    Ok("Linux" <> rest) -> linux_uname(rest) 
    _ -> Unsupported
  }
}


fn runtime() {
  uname_runtime() 
}

pub fn get_clipboard() -> Result(String, ClipboardError) {
  case runtime() {
    Android -> case simple_spawn("termux-clipboard-get", []) {
      Ok(output) -> Ok(output)
      Error(error) -> Error(AndroidError(error.1))
    }
    Mac -> case simple_spawn("pbpaste", []) {
      Ok(output) -> Ok(string.drop_end(output, 1)) // Drop \n
      Error(error) -> Error(MacError(error.1))
    }
    Unsupported -> Error(UnsupportedRuntime)
  }
}

pub fn set_clipboard(content: String) -> Result(Nil, ClipboardError) {
  case runtime() {
    Android -> case simple_spawn("termux-clipboard-set", [content]) {
      Ok(_) -> Ok(Nil)
      Error(error) -> Error(AndroidError(error.1))
    }
    Mac -> case simple_spawn("sh", ["-euc", "echo '" <> content <> "' | " <> "pbcopy"]) {
      Ok(_) -> Ok(Nil)
      Error(error) -> Error(MacError(error.1))
    }
    Unsupported -> Error(UnsupportedRuntime)
  }
}
