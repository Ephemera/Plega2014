#!/usr/bin/env escript

main(Buf) ->
  PORT = 9999,
  {ok, Socket} = gen_udp:open(0, [binary, {broadcast, true}]),
  gen_udp:send(Socket, {255,255,255,255}, PORT, Buf).
