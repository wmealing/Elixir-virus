# Evirus

Toy virus written in elixir for a learning experience to infect any node that the
system can connect to.




## Running

Start the infected node.

# iex --sname somenode --cookie "HELLO" -S mix
Erlang/OTP 25 [erts-13.1.3] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit]

Interactive Elixir (1.14.3) - press Ctrl+C to exit (type h() ENTER for help)

iex(somenode@Fedora-37)1> Evirus.start

12:49:45.377 [info] in spawn_process

12:49:45.382 [info] spawning...

12:49:45.382 [info] Registering name...

12:49:45.382 [info] Logging all nodes.....

12:49:45.382 [info] YOU ARE INFESTED

12:49:45.382 [info] VIRUS LOOP
#PID<0.157.0>

....

And from another node..

# iex --sname anothernode --cookie "HELLO" -S mix 

This could be any node, erlang beam, etc.

iex(anothernode@Fedora-37)1> Node.ping(:"somenode@Fedora-37")


Then this node (anothernode) is now infected.

...

12:52:01.929 [info] in spawn_process
 
12:52:01.933 [info] spawning...

12:52:01.933 [info] Registering name...

12:52:01.933 [info] Logging all nodes.....

12:52:01.933 [info] YOU ARE INFESTED

12:52:01.933 [info] VIRUS LOOP

...


While there isnt a 'payload' on this infection, it might be a good method to move laterally across different systems in the BEAM network.






