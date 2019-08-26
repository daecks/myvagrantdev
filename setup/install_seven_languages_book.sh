#!/bin/bash
echo "Install seven languages book dependencies"

# Install IO
sudo apt-get install -y --force-yes build-essential cmake libreadline-dev libssl-dev ncurses-dev libffi-dev zlib1g-dev libpcre3-dev libpng-dev libtiff4-dev libjpeg62-dev python-dev libpng-dev libtiff4-dev libjpeg62-dev libmysqlclient-dev libmemcached-dev libtokyocabinet-dev libsqlite3-dev libdbi0-dev libpq-dev libgmp3-dev libogg-dev libvorbis-dev libtaglib-cil-dev libtag1-dev libtheora-dev libsamplerate0-dev libloudmouth1-dev libsndfile1-dev libflac-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev libxmu-dev libxi-dev libxml2-dev libyajl-dev uuid-dev liblzo2-dev zlib1g-dev libevent-dev
TMPFILE=`mktemp`
PWD=`pwd`
wget http://iobin.suspended-chord.info/linux/iobin-linux-x86-deb-current.zip -O $TMPFILE
unzip $TMPFILE -d $PWD
rm $TMPFILE
ls IoLanguage*.deb | xargs sudo dpkg -i
sudo ldconfig

sudo apt-get install -y --force-yes ruby
sudo apt-get install -y --force-yes swi-prolog-nox
sudo apt-get install -y --force-yes scala
sudo apt-get install -y --force-yes erlang
sudo apt-get install -y --force-yes clojure1.4
sudo apt-get install -y --force-yes haskell-platform

echo "Finished installing seven languages book dependencies"
