dir=${1:-$pwd}
session_name=${2:-"${PWD##*/}"}
should_attach=${3:-true}

# we only want to list directories
name="$(ls -l $dir | grep '^d' | awk '{print $9}' | fzf)"

if [ -z "$name" ]; then
	exit 0
fi

function new_session() {
	tmux new-session -s $session_name -n $name -d
}

function cd_and_nvim() {
	tmux send-keys -t $session_name:$name 'cd ' $dir/$name ENTER 'nvim' ENTER
}

function attach_session() {
	tmux attach -t $session_name:$name
}

if [ $(tmux ls 2>&1 | grep "no server running" | wc -l) -eq 1 ]; then
	echo "Starting tmux..."
	new_session
	cd_and_nvim
	if [ "$should_attach" = true ]; then
		attach_session
	fi
elif [ $(tmux ls | grep $session_name | wc -l) -eq 1 ] && [ $(tmux list-windows -a | grep $name | wc -l) -eq 1 ]; then
	echo "Session and Window exist, attaching..."
	if [ "$should_attach" = true ]; then
		attach_session
	fi
elif [ $(tmux ls | grep $session_name | wc -l) -eq 0 ]; then
	echo "Session does not exist, creating..."
	new_session
	cd_and_nvim
	if [ "$should_attach" = true ]; then
		attach_session
	fi
else
	echo "Session exists, creating window..."
	tmux new-window -n $name -t $session_name -d
	cd_and_nvim
	if [ "$should_attach" = true ]; then
		attach_session
	fi
fi
