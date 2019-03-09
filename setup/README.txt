Io Language for Linux (x86/.deb)
Binary provided by the iobin project, http://iobin.suspended-chord.info/
-->Jacob Peck

These binaries are provided with absolutely ZERO warranty.
Use at your own risk.
-----

Instructions:
1) Extract the .deb from the downloaded file.
2) Run the following command to grab the dependencies:

sudo apt-get install build-essential cmake libreadline-dev libssl-dev ncurses-dev libffi-dev zlib1g-dev libpcre3-dev libpng-dev libtiff4-dev libjpeg62-dev python-dev libpng-dev libtiff4-dev libjpeg62-dev libmysqlclient-dev libmemcached-dev libtokyocabinet-dev libsqlite3-dev libdbi0-dev libpq-dev libgmp3-dev libogg-dev libvorbis-dev libtaglib-cil-dev libtag1-dev libtheora-dev libsamplerate0-dev libloudmouth1-dev libsndfile1-dev libflac-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev libxmu-dev libxi-dev libxml2-dev libyajl-dev uuid-dev liblzo2-dev zlib1g-dev libevent-dev

3) Run the following command (modified as necessary to match the name of the .deb) to install:

sudo dpkg -i IoLanugage-xxxx-Linux-platform.deb

4) Run the following command to ensure the new libs load:

sudo ldconfig

5) Run io with the following command

io

6) Enjoy!

~20111109
