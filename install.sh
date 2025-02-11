HOOK_DIR=$(git config --local core.hooksPath || echo '.git/hooks') && \
echo "Installing in $HOOK_DIR..." && \
mkdir -p "$HOOK_DIR"

url=$(curl -s https://api.github.com/repos/smg-real-estate/smg-git-hooks-public/releases/latest | grep "post-checkout" | tail -1 | cut -d : -f 2,3 | tr -d '" ')

curl -L "$url" > "$HOOK_DIR/post-checkout"
chmod +x "$HOOK_DIR/post-checkout"
