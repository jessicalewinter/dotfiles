#!/bin/bash

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

dir_exists() {
  [ -d "$@" ] 2>&1
}
