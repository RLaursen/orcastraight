import gleam/regex
import wemote
import barnacle
import gleam/io
import gleam/erlang/process
import gleam/otp/supervisor
import gleam/list
import gleam/erlang/atom
import gleam/erlang/node
import clipboard

pub fn main() {
  let assert Ok(_) = clipboard.set_clipboard("test")
  io.debug(clipboard.get_clipboard())
  // let supervisor_subject = process.new_subject()

  // let assert Ok(_) =  barnacle.epmd(["node@192.168.1.136", "node@Ryans-MBP.lan"] |> list.map(atom.create_from_string))
  //   |> barnacle.with_poll_interval(15_000)
  //   |> barnacle.with_name("my_barnacle")
  //   |> barnacle.child_spec(supervisor_subject)
  //   |> fn (barnacle_worker) {supervisor.add(_, barnacle_worker)}
  //   |> supervisor.start

  // let assert Ok(barnacle_subject) = process.receive(supervisor_subject, 10_000)
  // io.debug(barnacle_subject)

  // let assert Ok(ret) = barnacle.refresh(barnacle_subject, 10_000)
  // io.debug(ret)

  // //! Currently 1:1
  // let assert [node] = node.visible()

  // let assert Ok(remote_pid) = wemote.call(node, process.new_subject, wemote.Infinity)
  // io.debug(remote_pid)
  // process.send(remote_pid, "test")
}
