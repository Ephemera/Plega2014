#!/usr/bin/env perl

### 최소 버전 선언
use v5.10;
### like import
use Socket ;

### joining STDIN
my $text = join ' ', @ARGV; 

my $port = 9999;

socket( SOCKET, PF_INET, SOCK_DGRAM, getprotobyname("udp") );
# PF_INET
### This designates the IPv4 Internet namespace and associated family of protocols.
### AF_* - stands for Address Family
### PF_* - stands for Protocol Family:
# SOCK_DGRAM
### The SOCK_DGRAM style is used for sending individually-addressed packets unreliably.  It is the diametrical opposite of SOCK_STREAM.  Each time you write data to a socket of this kind, that data becomes one packet.  Since SOCK_DGRAM sockets do not have connections, you must specify the recipient address with each packet.  The only guarantee that the system makes about your requests to transmit data is that it will try its best to deliver each packet you send. It may succeed with the sixthChapter 16: Sockets 424 packet after failing with the fourth and fifth packets; the seventh packet may arrive before the sixth, and may arrive a second time after the sixth.  The typical use for SOCK_DGRAM is in situations where it is acceptable to simply re-send a packet if no response is seen in a reasonable amount of time.
### SOCK_DGRAM is used for UDP packets, SOCK_STREAM for TCP
### UDP/SOCK_DGRAM is a datagram-based protocol. You send one datagram and get one reply and then the connection terminates
# udp

setsockopt( SOCKET, SOL_SOCKET, SO_BROADCAST, 1 );
# int SOL_SOCKET
### Use this constant as the level argument to getsockopt or setsockopt to manipulate the socket-level options described in this section.
# SO_BROADCAST
### This option controls whether datagrams may be broadcast from the socket. The value has type int; a nonzero value means “yes”.

my $dest = sockaddr_in( $port, INADDR_BROADCAST );
# INADDR_BROADCAST
### This constant is the address you use to send a broadcast message.
### The kernel picks the UDP or TCP socket to which a packet sent to the INADDR_BROADCAST address (255.255.255.255) is delivered in the following way: If there is a socket that is bound to the address assigned to the interface from which the packet was received, the packet will be delivered to this socket. If there is no such socket, the packet will be delivered to one of the sockets bound to INADDR_ANY. Obviously, the destination port of the packet and the port to which the socket was bound to need to match in both cases.

send( SOCKET, $text, 0,  $dest );
close SOCKET;

