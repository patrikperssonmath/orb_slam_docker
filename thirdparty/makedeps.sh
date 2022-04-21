#!/bin/bash
build_type='Release'
: ${CMAKE:=cmake}

num_threads=6

function build_cmake_dep() {
    local depdir=$1
    shift
    local cmakeopts=("$@")

    echo "Building ${depdir}"

    builddir=${build_dir}/${depdir}
    ((rebuild)) && ${CMAKE} -E remove_directory ${builddir}
    if [[ ! -e ${builddir} ]]; then
        ${CMAKE} -E make_directory ${builddir} || exit
        ${CMAKE} -E chdir ${builddir} ${CMAKE} "${cmakeopts[@]}" $(realpath ${depdir}) || exit
    fi

    ${CMAKE} --build ${builddir} --target install -- -j${num_threads} || exit

    ${CMAKE} -E remove_directory ${builddir}
}

function build_cmake_deps() {

    build_dir="$(pwd)/build"
    install_dir="$(pwd)/install"

    ##### Pangolin
    make_opts=("-DCMAKE_BUILD_TYPE=${build_type}")
    build_cmake_dep "pangolin" ${cmake_opts[@]}

    
    ##### opencv
    cmake_opts=("-DCMAKE_BUILD_TYPE=${build_type}"
        "-OPENCV_EXTRA_MODULES_PATH=$(realpath opencv_contrib)")
    build_cmake_dep "opencv" ${cmake_opts[@]}

}

function usage() {
    echo "Usage: $0 [--threads <num_threads>] [--rebuild]"
}

function parse_args() {
    options=$(getopt -o dv --long help --long rebuild --long threads: "$@")
    [ $? -eq 0 ] || {
        usage
        exit 1
    }
    eval set -- "$options"
    while true; do
        case "$1" in
        --threads)
            shift
            num_threads=$1
            ;;
        --rebuild)
            rebuild=1
            ;;
        --help)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        esac
        shift
    done
}

parse_args $0 "$@"

pushd $(dirname $0)
build_cmake_deps
popd
