# godot4_test
Godot 4 experimentations

Acknowledgements:<br />
https://github.com/godotengine/godot\
https://github.com/2shady4u/godot-sqlite\
https://github.com/lipis/flag-icons

Video encodes:
```
./ffmpeg -i in.mp4 -vf format=yuv420p -movflags +faststart -an out.mp4
./ffmpeg -i in.mp4 -codec:v libtheora -qscale:v 6 -an out.ogv
```

Send UDP string:
```
echo -n "Hello, world!" > /dev/udp/127.0.0.1/54321
echo -n "Hello, world!" | nc -u -q0 127.0.0.1 54321

```

Send UDP file:
```
cat dummy.json > /dev/udp/127.0.0.1/54321
cat dummy.json | nc -u -q0 127.0.0.1 54321
```
