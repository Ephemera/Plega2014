#!/usr/bin/env escript

main(_) ->
  io:format("start\n"),
  PORT = 9999,
  {ok, Socket} = gen_udp:open(PORT, [binary, {active, false}]),
  loop(Socket).

loop(Socket) ->
  case gen_udp:recv(Socket, 0) of
    {ok, {Address, Port, Packet}} ->
      io:format("~w:~w >> ~w~n", [Address, Port, binary_to_atom(Packet, utf8)]),
      loop(Socket);
    {error, Reason} ->
      io:format(Reason),
      ok
  end.
