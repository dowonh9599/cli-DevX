#!/bin/bash

_install() {
  brew install docker
  brew install colima \
  ;
  popd
}

_start() {
  vm_type="qemu"  # Default to Qemu mode

  case "$1" in
    --vz-rosetta)
      vm_type="vz-rosetta"
      ;;
  esac

  case $vm_type in
    qemu)
      colima start --cpu 4 --memory 8 --arch aarch64 --vm-type qemu
      ;;
    vz-rosetta)
      colima start --cpu 4 --memory 8 --arch aarch64 --vm-type=vz --vz-rosetta --dns 8.8.8.8 --dns 8.8.4.4
      ;;
    *)
      echo "Invalid VM type: $vm_type"
      exit 1
      ;;
  esac
}

main() {
  local cmd=$1
  shift
  
  case $cmd in
    install)
      _install
      ;;
    start)
      _start "$@" 
      ;;
    stop)
      colima stop
      ;;
    *)
      echo "Other options not implemented"
      exit 1
      ;;
  esac
}

main "$@"