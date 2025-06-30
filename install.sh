# Exit early if not in a git repository
if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "not in a git repository. skipping installation" >&2
    exit 0
fi

PROJECT_ROOT=$(git rev-parse --show-toplevel)
HOOK_DIR=$(git config --local core.hooksPath)

case "$HOOK_DIR" in
    ".husky/_") 
        HOOK_DIR=".husky"
        ;; # If hooks path is '.husky/_', change it to just '.husky'
    "") 
        HOOK_DIR=".git/hooks"
        ;;
esac

echo "Project root: $PROJECT_ROOT"
echo "Installing in $HOOK_DIR..." && \
mkdir -p "$HOOK_DIR"

url=$(curl -s https://api.github.com/repos/smg-real-estate/smg-git-hooks-public/releases/latest | grep "post-checkout" | tail -1 | cut -d : -f 2,3 | tr -d '" ')

curl -L "$url" > "$HOOK_DIR/post-checkout"
chmod +x "$HOOK_DIR/post-checkout"
