# Component: dotfiles
# Purpose: alias for dotfiles add
#          intentionally to use zsh fallback file-only completion because "git add" completion is broken with git bare repository
# Reference: https://stackoverflow.com/a/33191364
#            https://unix.stackexchange.com/questions/550559/zsh-file-autocompletion-with-bare-git-repo
function da() {
  git --git-dir="$XDG_DATA_HOME/dotfiles/" --work-tree="$HOME" add $@
}

# Use grealpath on macOS, realpath otherwise
if [[ "$(uname -s)" == "Darwin" ]]; then
  _realpath() { grealpath "$@"; }
else
  _realpath() { realpath "$@"; }
fi

# Component: 1password-cli
# Purpose: push a secret file to the 1password vault
function dspush() {
  VAULT="dotfiles"
  INPUT_FILE_PATH="$1"
  FILE_PATH_RELATIVE_TO_HOME=$(_realpath --relative-to="$HOME" "$INPUT_FILE_PATH")
  FILE_PATH_ABSOLUTE=$(_realpath "$INPUT_FILE_PATH")
  TITLE="~/$FILE_PATH_RELATIVE_TO_HOME"
  FILE_NAME=$(basename ${FILE_PATH_ABSOLUTE})

  echo "Pushing $FILE_PATH_ABSOLUTE"

  if [ ! -f "$FILE_PATH_ABSOLUTE" ]; then
    echo "File "$FILE_PATH_ABSOLUTE" not found locally"
    return 1
  fi

  if op document get "$TITLE" --vault "$VAULT" > /dev/null 2>&1; then
    op document edit "$TITLE" "$FILE_PATH_ABSOLUTE" --vault "$VAULT" --title "$TITLE" --file-name "$FILE_NAME"
  else
    op document create "$FILE_PATH_ABSOLUTE" --vault "$VAULT" --title "$TITLE" --file-name "$FILE_NAME"
  fi
}

# Component: 1password-cli
# Purpose: push all secret files that already exist in the 1password vault
function dspushall() {
  VAULT="dotfiles"
  TITLES=$(op document list --vault "$VAULT" --format json | jq -r '.[].title')

  echo $TITLES | while read title ; do
    FILE_PATH_ABSOLUTE="$HOME/${title#"~/"}"
    dspush "$FILE_PATH_ABSOLUTE"
  done
}

# Component: 1password-cli
# Purpose: pull a secret file from the 1password vault
function dspull() {
  VAULT="dotfiles"
  INPUT_FILE_PATH="$1"
  mkdir -p $(dirname ${INPUT_FILE_PATH})
  touch "$INPUT_FILE_PATH"
  FILE_PATH_RELATIVE_TO_HOME=$(_realpath --relative-to="$HOME" "$INPUT_FILE_PATH")
  FILE_PATH_ABSOLUTE=$(_realpath "$INPUT_FILE_PATH")
  TITLE="~/$FILE_PATH_RELATIVE_TO_HOME"

  echo "Pulling $FILE_PATH_ABSOLUTE"

  if op document get "$TITLE" --vault "$VAULT" > /dev/null 2>&1; then
    rm "$FILE_PATH_ABSOLUTE"
    op document get "$TITLE" --vault "$VAULT" --output "$FILE_PATH_ABSOLUTE" --force
  else
    echo "Item with the title \"$TITLE\" does not exist in the 1password vault"
  fi
}

# Component: 1password-cli
# Purpose: pull all secret files from the 1password vault
function dspullall() {
  VAULT="dotfiles"
  TITLES=$(op document list --vault "$VAULT" --format json | jq -r '.[].title')

  echo $TITLES | while read title ; do
    FILE_PATH_ABSOLUTE="$HOME/${title#"~/"}"
    dspull "$FILE_PATH_ABSOLUTE"
  done
}

# Component: 1password-cli
# Purpose: compare a secret file between remote and local
function dsdiff() {
  VAULT="dotfiles"
  INPUT_FILE_PATH="$1"
  FILE_PATH_RELATIVE_TO_HOME=$(_realpath --relative-to="$HOME" "$INPUT_FILE_PATH")
  FILE_PATH_ABSOLUTE=$(_realpath "$INPUT_FILE_PATH")
  TITLE="~/$FILE_PATH_RELATIVE_TO_HOME"

  echo "Comparing the remote secret with local file $FILE_PATH_ABSOLUTE"

  if [ ! -f "$FILE_PATH_ABSOLUTE" ]; then
    echo "File "$FILE_PATH_ABSOLUTE" not found locally"
    return 1
  fi

  if op document get "$TITLE" --vault "$VAULT" > /dev/null 2>&1; then
    op document get "$TITLE" --vault "$VAULT" | delta - "$FILE_PATH_ABSOLUTE"
  else
    echo "Item with the title \"$TITLE\" does not exist in the 1password vault"
  fi
}

# Component: 1password-cli
# Purpose: compare all secret files between remote and local
function dsdiffall() {
  VAULT="dotfiles"
  TITLES=$(op document list --vault "$VAULT" --format json | jq -r '.[].title')

  echo $TITLES | while read title ; do
    FILE_PATH_ABSOLUTE="$HOME/${title#"~/"}"
    dsdiff "$FILE_PATH_ABSOLUTE"
  done
}

# Component: 1password-cli
# Purpose: delete a secret file from the 1password vault
function dsdelete() {
  VAULT="dotfiles"
  INPUT_FILE_PATH="$1"
  FILE_PATH_RELATIVE_TO_HOME=$(_realpath --relative-to="$HOME" "$INPUT_FILE_PATH")
  FILE_PATH_ABSOLUTE=$(_realpath "$INPUT_FILE_PATH")
  TITLE="~/$FILE_PATH_RELATIVE_TO_HOME"

  echo "Deleting secret $TITLE"
  op document delete "$TITLE" --vault "$VAULT"
}

# Component: 1password-cli
# Purpose: list all secret files from the 1password vault
function dslist() {
  VAULT="dotfiles"
  op document list --vault "$VAULT" | (sed -u 1q; sort -k 2)
}

# Component: 1password-cli
# Purpose: fetch all ssh public keys from the 1password vault
function fetchkeys() {
  VAULT="dotfiles"
  KEY_TITLES=$(op item list --vault "$VAULT" --categories "SSH Key" --format json | jq -r '.[].title')

  echo $KEY_TITLES | while read key_title ; do
    PUBLIC_KEY_FILE_PATH_ABSOLUTE="$HOME/.ssh/$key_title.pub"
    echo "Fetching public key $PUBLIC_KEY_FILE_PATH_ABSOLUTE"
    op read "op://$VAULT/$key_title/public key" > "$PUBLIC_KEY_FILE_PATH_ABSOLUTE"
  done
}
