#!/usr/bin/bash

DIRECTORY=$1

SESSION="document"

# if session does not exist, create it
tmux has-session -t $SESSION
if [[ $? != 0 ]]; then
    # when tmux creates a new pane or window
    # the shell is rooted in the current working directory
    if [[ -n $DIRECTORY ]]; then
        cd $DIRECTORY
    fi

    # “detach from any session you may be attached to”. This is a good safety
    # precaution, because running a tmux session from within a tmux session is not good
    # nested tmux sessions is not good practice
    tmux detach

    # Create new session 'dev' and new window titled 'editor'
    # -s means “session”.
    # -n switch means “next window”. We are creating the first window and naming it “Editor”.
    # The -d switch detaches from the session. We do this so that we can keep sending the next session commands from this script.
    tmux new-session -s $SESSION -n doc-edit -d

    # # horizontally split window of session to form another pane and assign 40% to new pane
    # tmux split-window -v -p 40 -t $SESSION

    # open editor in first pane and restore saved session (.session.vim), if available
    # "C-m" below means <enter> key
    if [ -f .session.vim ]; then
        tmux send-keys -t ${SESSION}:1.1 'nvim -S .session.vim' C-m
    else
        tmux send-keys -t ${SESSION}:1.1 'nvim' C-m
    fi
fi

# else just attach to existing sesion
tmux attach -t $SESSION
