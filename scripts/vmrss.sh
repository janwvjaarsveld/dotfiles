p=$1
if [[ -z $p ]]; then
	echo "No pid given"
	exit 1
fi
echo "pid choosen: $p from $1"
while true; do
	sync
	cat /proc/$p/status | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} VmRSS | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} -o '[0-9]\+' | awk '{print $1/1024 " MB"}'
	sleep 1
done
