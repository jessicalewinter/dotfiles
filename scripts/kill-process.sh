#!/bin/bash

kill_process() {
  ps -ef | grep Xcode | grep -v grep | awk '{print $2}' | xargs kill
}

kill_process
