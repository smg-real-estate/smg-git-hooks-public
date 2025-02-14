# Get the hooks path, defaulting to '.githooks' if not set
HOOK_DIR=$(git config --local core.hooksPath || echo '.githooks') && \

# If hooks path is '.husky/_', change it to just '.husky'
if [[ "$HOOK_DIR" == ".husky/_" ]]; then
    HOOK_DIR=".husky"
fi

echo "Installing in $HOOK_DIR..." && \
mkdir -p "$HOOK_DIR"

url=$(curl -s https://api.github.com/repos/smg-real-estate/smg-git-hooks-public/releases/latest | grep "post-checkout" | tail -1 | cut -d : -f 2,3 | tr -d '" ')

curl -L "$url" > "$HOOK_DIR/post-checkout"
chmod +x "$HOOK_DIR/post-checkout"
[ "$HOOK_DIR" = ".githooks" ] && git config --local core.hooksPath .githooks || true
