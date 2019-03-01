echo "
dumb.sh
-------
a stupid script for pulling dependencies for AHK from git. 

I tried to think of Better ways for doing this, but the Lib folder
is stupid so I couldn't.

I know it's weird to do this in Bash, but no way am I going
to do this using cmd.exe, that would be gross. Use WSL or Cygwin
or sth.
"

set -ev

echo "Checking for your .dumb file."
dumb_file=$(readlink -e deps.dumb.txt)
if [ ! -f $dumb_file ]; then
    echo "You don't have it. Here you go ~~~~~"
    touch $dumb_file
    exit 0
fi

# Add newline if doesn't exist
sed -i -e '$a\' $dumb_file

lib_folder=.tmp-lib
rm -rf $lib_folder
mkdir $lib_folder
cd $lib_folder
cat $dumb_file | tr -d '\r' | while read repo; do
    git clone $repo last
    cp -fa last/. ./
    rm -rf last
    rm -rf .git
done
cd ..
echo "Goodbye Lib folder!"
rm -rf ./Lib
mv $lib_folder Lib