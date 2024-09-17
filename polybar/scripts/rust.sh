#!/bin/bash

get_rust_version() {
    rustc --version | awk '{print $2}'
}

update_rust() {
    rustup update
}

if [ "$1" = "--update" ]; then
    update_rust
else
    VERSION=$(get_rust_version)
    echo "$VERSION"
fi
