# /*
#  * $Id
#  */
# 
# /*
#  * FivePhone source code:
#  * buildmac.sh
#  *
#  * Copyright 2010 Antonio Linares <alinares@fivetechsoft.com>
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
# ./build.sh
 
clear
 
if [ $# = 0 ]; then
	echo syntax: ./build.sh file [options...]
	exit
fi
 
echo compiling...
./../../harbour/bin/harbour $1 -n -I./../../harbour/include -I./../include
if [ $? = 1 ]; then
	exit
fi   
 
echo compiling C module...
/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/gcc-4.2 -arch i386 -mthumb -I./../../harbour/include -isysroot /Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator3.2.sdk $1.c -c 

echo linking...
/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/gcc-4.2 -arch i386 -mthumb -isysroot /Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator3.2.sdk $1.o \
					-o $1 -L./../lib -lfive -lfivec -L./../../harbour/lib -lhbvm -lhbrtl -lhblang -lhbrdd -lgttrm -lgtstd -lhbmacro -lrddntx -lrddcdx -lrddfpt -lhbsix -lhbcommon \
					-framework CoreFoundation \
					-framework Foundation \
					-framework UIKit \
					-framework AudioToolbox \
					-lobjc
 
#rm $1.c
#rm $1.o
 
echo done!
 
echo copying to the iPhone/iPad simulator...
copy ./$1 /...
chmod +x /...