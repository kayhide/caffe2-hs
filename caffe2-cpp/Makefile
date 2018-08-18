all:
	@test -f build/Makefile || (mkdir -p build && cd build && cmake .. && cd ..); cd build && make

install:
	@cd build && make install
	@cd ../.libs/lib && install_name_tool -id `pwd`/libcaffe2-wrapper.dylib libcaffe2-wrapper.dylib

clean:
	@rm -rf build
