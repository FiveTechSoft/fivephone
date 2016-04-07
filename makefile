# FivePhone makefile 
# don't use spaces before the rules. Use a TAB

CC = /Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc-4.2
CFLAGS = -arch armv6 -mthumb -isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.2.sdk
CFLAGS2 = -arch i386 -mmacosx-version-min=10.5 -D__IPHONE_OS_VERSION_MIN_REQUIRED=30200 -fobjc-abi-version=2 -mthumb -isysroot /Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator4.2.sdk
LM = /Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/libtool

.PONNY : all clean

all : ./lib/libfivephone.a

PRG_OBJS = ./obj/accel.o \
	./obj/actind.o \
	./obj/actionsheet.o \
	./obj/button.o \
	./obj/datepck.o \
	./obj/imgview.o \
 	./obj/label.o \
	./obj/movie.o \
	./obj/navbar.o  \
	./obj/nsobject.o \
	./obj/tblview.o \
	./obj/get.o \
	./obj/toolbar.o \
	./obj/picview.o \
	./obj/progres.o \
	./obj/search.o \
	./obj/segment.o \
	./obj/slider.o \
	./obj/switch.o \
	./obj/tabbar.o \
	./obj/timer.o \
	./obj/tblviewCell.o \
	./obj/valtochr.o \
	./obj/webview.o \
	./obj/view.o \
	./obj/window.o 

C_OBJS = ./objc/accels.o \
	./objc/actinds.o \
	./objc/actionsheets.o \
	./objc/buttons.o \
	./objc/cells.o \
	./objc/datepicker.o \
	./objc/fwprototypes.o \
	./objc/imgviews.o \
 	./objc/labels.o \
	./objc/mainapp.o \
	./objc/movies.o \
	./objc/msgs.o \
	./objc/navbars.o \
	./objc/nibs.o \
	./objc/objects.o \
	./objc/pagecontrols.o \
	./objc/picviews.o \
	./objc/progress.o \
	./objc/searchs.o \
	./objc/segments.o \
	./objc/sliders.o \
	./objc/switches.o \
	./objc/system.o \
	./objc/tabbars.o \
	./objc/tableview.o \
	./objc/textfield.o \
	./objc/timers.o \
	./objc/toolbars.o \
	./objc/uikit.o \
	./objc/views.o \
	./objc/webviews.o \
	./objc/windows.o

PRG_OBJS2 = ./objS/accel.o \
	./objS/actind.o \
	./objS/actionsheet.o \
	./objS/button.o \
	./objS/datepck.o \
	./objS/imgview.o \
 	./objS/label.o \
	./objS/movie.o \
	./objS/navbar.o  \
	./objS/nsobject.o \
	./objS/tblview.o \
	./objS/get.o \
	./objS/toolbar.o \
	./objS/picview.o \
	./objS/progres.o \
	./objS/search.o \
	./objS/segment.o \
	./objS/slider.o \
	./objS/switch.o \
	./objS/tabbar.o \
	./objS/timer.o \
	./objS/tblviewCell.o \
	./objS/valtochr.o \
	./objS/webview.o \
	./objS/view.o \
	./objS/window.o \
	./objS/simula.o

C_OBJS2 = ./objcS/accels.o \
	./objcS/actinds.o \
	./objcS/actionsheets.o \
	./objcS/buttons.o \
	./objcS/cells.o \
	./objcS/datepicker.o \
	./objcS/fwprototypes.o \
	./objcS/imgviews.o \
 	./objcS/labels.o \
	./objcS/mainapp.o \
	./objcS/movies.o \
	./objcS/msgs.o \
	./objcS/navbars.o \
	./objcS/nibs.o \
	./objcS/objects.o \
	./objcS/pagecontrols.o \
	./objcS/picviews.o \
	./objcS/progress.o \
	./objcS/searchs.o \
	./objcS/segments.o \
	./objcS/sliders.o \
	./objcS/switches.o \
	./objcS/system.o \
	./objcS/simulas.o \
	./objcS/tabbars.o \
	./objcS/tableview.o \
	./objcS/textfield.o \
	./objcS/timers.o \
	./objcS/toolbars.o \
	./objcS/uikit.o \
	./objcS/views.o \
	./objcS/webviews.o \
	./objcS/windows.o	

./lib/libfivephone.a : ./lib/libfiveDevice.a ./lib/libfiveSimul.a 
	lipo -create -arch i386 ./lib/libfiveSimul.a  -arch arm ./lib/libfiveDevice.a -output ./lib/libfivephone.a
	
./lib/libfiveDevice.a : ./lib/libfive.a ./lib/libfivec.a
	libtool -static -o ./lib/libfiveDevice.a ./lib/libfive.a ./lib/libfivec.a	

./lib/libfiveSimul.a : ./lib/libfiveS.a ./lib/libfivecS.a
	libtool -static -o ./lib/libfiveSimul.a ./lib/libfiveS.a ./lib/libfivecS.a	

./lib/libfive.a  : $(PRG_OBJS)
	$(LM) -static -o ./lib/libfive.a $(PRG_OBJS)
        
./lib/libfivec.a : $(C_OBJS)
	$(LM) -static -o ./lib/libfivec.a $(C_OBJS)

./lib/libfiveS.a  : $(PRG_OBJS2)
	$(LM) -static -o ./lib/libfiveS.a $(PRG_OBJS2)
        
./lib/libfivecS.a : $(C_OBJS2)
	$(LM) -static -o ./lib/libfivecS.a $(C_OBJS2)

./obj/%.c : ./source/classes/%.prg
	./../harbour/bin/harbour $< -o./$@ -n -I./../harbour/include -I./include

./obj/%.c : ./source/function/%.prg
	./../harbour/bin/harbour $< -o./$@ -n -I./../harbour/include -I./include

./objS/%.c : ./source/classes/%.prg
	./../harbour/bin/harbour $< -o./$@ -n -I./../harbour/include -I./include

./objS/%.c : ./source/function/%.prg
	./../harbour/bin/harbour $< -o./$@ -n -I./../harbour/include -I./include

./obj/%.o : ./obj/%.c
	$(CC) $(CFLAGS) -c -o $@ -I./../harbour/include $< 

./objc/%.o : ./source/function/%.c
	$(CC) $(CFLAGS) -fobjc-legacy-dispatch -I./../harbour/include -I./include -Wall -c -o $@ $<

./objc/%.o : ./source/sdkapi/%.m
	$(CC) $(CFLAGS) -fobjc-legacy-dispatch -I./../harbour/include -I./include -Wall -c -o $@ $<


./objS/%.o : ./objS/%.c
	$(CC) $(CFLAGS2) -c -o $@ -I./../harbour/include $< 

./objcS/%.o : ./source/function/%.c
	$(CC) $(CFLAGS2) -fobjc-legacy-dispatch -I./../harbour/include -I./include -Wall -c -o $@ $<

./objcS/%.o : ./source/sdkapi/%.m
	$(CC) $(CFLAGS2) -fobjc-legacy-dispatch -I./../harbour/include -I./include -Wall -c -o $@ $<
	

clean:
	rm -f ./lib/*.*
	rm -f ./objc/*.*
	rm -f ./obj/*.*
	rm -f ./source/clases/*.bak
	rm -f ./source/function/*.bak
	rm -f ./source/sdkapi/*.bak





				