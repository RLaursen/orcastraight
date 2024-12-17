import barnacle
import gleam/io
import gleam/erlang/process
import gleam/otp/supervisor
import gleam/list
import gleam/erlang/atom

pub fn main() {
  let supervisor_subject = process.new_subject()

  let assert Ok(_) =  barnacle.epmd(///["node@192.168.43.1"] |> list.map(atom.create_from_string))
  [])
    |> barnacle.with_poll_interval(15_000)
    |> barnacle.with_name("my_barnacle")
    |> barnacle.child_spec(supervisor_subject)
    |> fn (barnacle_worker) {supervisor.add(_, barnacle_worker)}
    |> supervisor.start

  let assert Ok(barnacle_subject) = process.receive(supervisor_subject, 10_000)
  io.debug(barnacle_subject)

  let assert Ok(ret) = barnacle.refresh(barnacle_subject, 10_000)
  io.debug(ret)
}