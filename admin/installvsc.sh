#!/bin/bash

if [ ! -f "vscode_ext.txt" ]; then
    echo "Error: vscode_exts.txt not found"
    exit 1
fi

while read extension; do
    code --install-extension "$extension"
done < vscode_extensions.txt

echo "All extensions have been installed"