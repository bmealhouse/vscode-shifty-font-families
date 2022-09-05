#!/bin/sh

# Script adopted from powerline/fonts
# https://github.com/powerline/fonts/blob/master/install.sh

# Clone chrissimpkins/codeface
git clone https://github.com/chrissimpkins/codeface.git

# Set source and target directories
codeface_fonts_dir="$( cd "$( dirname "$0" )/codeface/fonts" && pwd )"

if test "$(uname)" = "Darwin" ; then
  # MacOS
  fonts_dir="$HOME/Library/Fonts"
else
  # Linux
  fonts_dir="$HOME/.local/share/fonts"
  mkdir -p $fonts_dir
fi

# Copy all fonts to user fonts directory
echo "Copying fonts..."
find "$codeface_fonts_dir" \( -name "*.[ot]tf" -or -name "*.pcf.gz" \) -type f -print0 | xargs -0 -n1 -I % cp "%" "$fonts_dir/"

if test "$(uname)" = "Darwin" ; then
  # Copy SF Mono for MacOS
  cp /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/*.otf "$fonts_dir/"
fi

# Reset font cache on Linux
if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$fonts_dir"
fi

echo "shifty fonts installed to $fonts_dir"
