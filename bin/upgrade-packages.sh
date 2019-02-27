#!/usr/bin/env bash
# Upgrade system-level and dev2/dev3 sandbox packages


cd "$(dirname "$0")/.."

echo "==> Upgrading Homebrew Packages"
brew update
brew cleanup
brew doctor
brew upgrade
brew cleanup

echo "==> Downgrading Fish to v2.7.1; while v3.0 is broken"
# To be fixed in Fish v3.1?
# https://github.com/fish-shell/fish-shell/issues/5456
# https://github.com/pypa/pipenv/issues/3414
brew unlink fish
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/2827b020c3366ea93566a344167ba62388c16c7d/Formula/fish.rb
brew link fish


echo "==> Upgrading System Python Packages"
echo "Removing system-level pip2 and pip3 installed packages"
timestamp=$(date -u +"%Y%m%dT%H%M%SZ")
tmpfile=$(mktemp /tmp/remove-requirements-$timestamp.txt)
pip2 freeze > $tmpfile
pip2 uninstall -y -r $tmpfile
pip3 freeze > $tmpfile
pip3 uninstall -y -r $tmpfile

echo "Installing upgraded packages from shell requirements files"
sort -o sys2-requirements.txt sys2-requirements.txt
pip2 install --upgrade pip setuptools wheel
pip2 install --upgrade -r sys2-requirements.txt

sort -o sys3-requirements.txt sys3-requirements.txt
pip3 install --upgrade pip setuptools wheel
pip3 install --upgrade -r sys3-requirements.txt

rm "$tmpfile"

echo "==> Recreating dev Environments"
sort -o dev2-requirements.txt dev2-requirements.txt
pew rm dev3
pew new -d -p python2 -r dev2-requirements.txt dev2

sort -o dev3-requirements.txt dev3-requirements.txt
pew rm dev3
pew new -d -p python3 -r dev3-requirements.txt dev3
