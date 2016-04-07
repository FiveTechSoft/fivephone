# /*
#  * $Id
#  */
# 
# /*
#  * FivePhone source code:
#  * builipa.sh
#  *
#  * Copyright 2010 Daniel Garcia-Gil <danielgarciagil@gmail.com>
#  * www - http://www.fivetechsoft.com
#  *
#  * This program is free software; you can redistribute it and/or modify
#  * it under the terms of the GNU General Public License as published by
#  * the Free Software Foundation; either version 2, or (at your option)
#  * any later version.
#  *
#  * This program is distributed in the hope that it will be useful,
#  * but WITHOUT ANY WARRANTY; without even the implied warranty of
#  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  * GNU General Public License for more details.
#  *
#  * You should have received a copy of the GNU General Public License
#  * along with this software; see the file COPYING.  If not, write to
#  * the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
#  * Boston, MA 02111-1307 USA (or visit the web site http://www.gnu.org/).
#  *
#  * As a special exception, this project gives permission for
#  * additional uses of the text contained in the release of Harbour.
#  *
#  * The exception is that, if you link these libraries with other
#  * files to produce an executable, this does not by itself cause the
#  * resulting executable to be covered by the GNU General Public License.
#  * Your use of that executable is in no way restricted on account of
#  * linking this library code into it.
#  *
#  * This exception does not however invalidate any other reasons why
#  * the executable file might be covered by the GNU General Public License.
#  *
#  * This exception applies only to the code released by this
#  * Project under the name FivePhone.  If you copy code from other
#  * projects or Free Software Foundation releases into this project,
#  * as the General Public License permits, the exception does
#  * not apply to the code that you add in this way.  To avoid misleading
#  * anyone as to the status of such modified files, you must delete
#  * this exception notice from them.
#  *
#  * If you write modifications of your own for FivePhone, it is your choice
#  * whether to permit this exception to apply to your modifications.
#  * If you do not wish that, delete this exception notice.
#  *
#  */
#
# ./buildipa.sh


clear

if [ $# = 0 ]; then
   echo syntax: ./buildipa.sh file dbffile
   exit
fi

echo building...
# delete previous info
rm -r -f  ./Payload
rm -f $1.ipa

# build app folder
mkdir Payload
mkdir ./Payload/$1.app
cp icon.png ./Payload/$1.app
cp $1 ./Payload/$1.app
echo '<?xml version="1.0" encoding="UTF-8"?>' > ./Payload/$1.app/Info.plist
echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >> ./Payload/$1.app/Info.plist
echo '<plist version="1.0">' >> ./Payload/$1.app/Info.plist
echo '<dict>' >> ./Payload/$1.app/Info.plist
echo '	<key>CFBundleDevelopmentRegion</key>' >> ./Payload/$1.app/Info.plist
echo '	<string>English</string>' >> ./Payload/$1.app/Info.plist
echo '	<key>CFBundleDisplayName</key>' >> ./Payload/$1.app/Info.plist
echo '	<string>'$1'</string>' >> ./Payload/$1.app/Info.plist
echo '	<key>CFBundleExecutable</key>' >> ./Payload/$1.app/Info.plist
echo '	<string>'$1'</string>' >> ./Payload/$1.app/Info.plist
echo '	<key>CFBundleIconFile</key>' >> ./Payload/$1.app/Info.plist
echo '	<string></string>' >> ./Payload/$1.app/Info.plist
echo '	<key>CFBundleIdentifier</key>' >> ./Payload/$1.app/Info.plist
echo '	<string>com.fivetech.iphone.'$1'</string>' >> ./Payload/$1.app/Info.plist
echo '	<key>CFBundleInfoDictionaryVersion</key>' >> ./Payload/$1.app/Info.plist
echo '	<string>6.0</string>' >> ./Payload/$1.app/Info.plist
echo '	<key>CFBundleName</key>' >> ./Payload/$1.app/Info.plist
echo '	<string>'$1'</string>' >> ./Payload/$1.app/Info.plist
echo '	<key>CFBundlePackageType</key>' >> ./Payload/$1.app/Info.plist
echo '	<string>APPL</string>' >> ./Payload/$1.app/Info.plist
echo '	<key>CFBundleSignature</key>' >> ./Payload/$1.app/Info.plist
echo '	<string>'$1'</string>' >> ./Payload/$1.app/Info.plist
echo '	<key>CFBundleVersion</key>' >> ./Payload/$1.app/Info.plist
echo '	<string>1.0</string>' >> ./Payload/$1.app/Info.plist
echo '	<key>LSRequiresIPhoneOS</key>' >> ./Payload/$1.app/Info.plist
echo '	<true/>' >> ./Payload/$1.app/Info.plist
echo '	<key>UIDeviceFamily</key>' >> ./Payload/$1.app/Info.plist
echo '	<array>' >> ./Payload/$1.app/Info.plist
echo '		<string>'1'</string>' >> ./Payload/$1.app/Info.plist
echo '	</array>' >> ./Payload/$1.app/Info.plist
echo '</dict>' >> ./Payload/$1.app/Info.plist
echo '</plist>' >> ./Payload/$1.app/Info.plist

if [ $# = 2 ]; then
	chmod 777 $2
	cp $2 ./Payload/$1.app
fi


#zipping file
zip -r $1.ipa Payload iTunesArtwork