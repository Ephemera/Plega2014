#!/usr/bin/env python

import socket, sys
text = ' '.join(sys.argv[1:])

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
sock.sendto(bytes(text, 'utf8'), ('255.255.255.255', 9999))
sock.close()
