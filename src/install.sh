#!/bin/bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# @author   a-Sansara - https://git.pluie.org/meta-tech/bes-install
# @app      bes-install
# @license  GNU GPL v3
# @date     2017-07-07 02:21:51 CET
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.install ()
{
    local  app=${1}
    local  url=${2}
    local path=${3:-/usr/local/bin}
    local done=1
    echo.title "Installing $app ${Coff}in" "$path"
    if [ -z "$app" ] || [ -s "$url" ]; then
        echo.error "in bes.install : \$app '$app' & \$url '$url' are required" 1
    fi
    if [ -f "./$app" ]; then
        rm ./$app
    fi
    wget -q $url
    if [ $? -eq 0 ]; then
        chmod +x ./$app
        if [ -d $path ]; then
            sudo mv ./$app $path/$app
            local done=$?
            echo.state $done
        else
            echo.error "install directory do not exists : ${Cspe}$path"
        fi
    else 
        echo.error "can not download latest version of app $app. please check url : $url"        
    fi
    echo.rs $done
}
