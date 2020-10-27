#!/usr/bin/env bash
set -e

if [ "$1" == "core" ]; then
    CV_CONTRIB_OPTION=( -DEMGU_CV_WITH_FREETYPE:BOOL=FALSE -DEMGU_CV_WITH_TESSERACT:BOOL=FALSE ) 
else
    CV_CONTRIB_OPTION=( -DOPENCV_EXTRA_MODULES_PATH=`dirname $0`/../../opencv_contrib/modules -DHB_HAVE_FREETYPE:BOOL=TRUE -DHB_BUILD_TESTS:BOOL=FALSE -DEMGU_CV_WITH_TESSERACT:BOOL=TRUE )
fi

cmake \
-GXcode \
-DCMAKE_TOOLCHAIN_FILE=`dirname $0`/cmake/Toolchains/Toolchain-iPhoneOS_Xcode.cmake \
-DCMAKE_INSTALL_PREFIX=../OpenCV_iPhoneOS \
${CV_CONTRIB_OPTION[@]} \
-DBUILD_opencv_hdf:BOOL=FALSE \
-DBUILD_SHARED_LIBS:BOOL=FALSE \
-DBUILD_PERF_TESTS:BOOL=FALSE \
-DBUILD_TESTS:BOOL=FALSE \
-DBUILD_opencv_apps:BOOL=FALSE \
-DBUILD_opencv_java_bindings_generator:BOOL=FALSE \
-DBUILD_opencv_python_bindings_generator:BOOL=FALSE \
-DCMAKE_C_FLAGS=-fembed-bitcode \
-DCMAKE_CXX_FLAGS=-fembed-bitcode \
-DIPHONEOS_DEPLOYMENT_TARGET:STRING=8.0 \
${@:2} `dirname $0`/../.. 

#-DCMAKE_C_FLAGS_RELEASE:STRING=-g0 \
#-DCMAKE_CXX_FLAGS_RELEASE:STRING=-g0 \
