#! /usr/bin/env bash

CONFIG_DIR="$HOME/.config/ylight"
SERVICE_DIR="$HOME/.config/systemd/user"
DEST_DIR="$HOME/.local/bin"

mkdir -p     "$CONFIG_DIR"
mkdir -p     "$SERVICE_DIR"

cp ylight    "$DEST_DIR"
cp ylightc   "$DEST_DIR"
cp ysunlight "$DEST_DIR"

cp ysunlight.service "$SERVICE_DIR"
cp -n ysunlight.conf "$CONFIG_DIR"

cp ./*.png "$CONFIG_DIR"
