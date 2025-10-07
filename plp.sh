#!/usr/bin/env bash
folder="$HOME/.plp"
path=$(pwd)
script_name=$(basename "$0")
script_dir="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$folder" ]; then
    mkdir -p "$folder" 
fi

if [ "$1" = "install" ]; then
    if [ "$script_name" != "plp" ]; then
        echo -e "\nplease move $script_name to /usr/local/bin/plp\nuse 'sudo mv $script_name /usr/local/bin/plp'\nthen you can use 'plp' command everywhere\n\n"
    fi
    for plug in $(ls *.txt; ls *.sh 2>/dev/null); do
        if [ "$plug" != "$script_name" ]; then
            "$0" "$plug" 2>/dev/null
        fi
    done 
exit 0
fi

if [ -z $1 ]; then
    echo "use 'plp help' for help"
elif [ -f "$folder/$1.txt" ]; then
    cat "$folder/$1.txt"
elif [ -f "$folder/$1.sh" ]; then
    bash "$folder/$1.sh" "${@:2}"
elif [ -f "$path/$1.sh" -o -f "$path/$1.txt" -o -f "$path/$1" ]; then
    add(){
        if [ -z $2 ]; then
            mv -f "$path/$1" "$folder/$1"
        else
            mv -f "$path/$1.$2" "$folder/$1.$2"
            echo "successful! now you can use 'plp $1'"
        fi
        exit 0
    }
    if [ -f "$path/$1" ]; then
        IFS='.' read -r -a arr <<< "$1"
        if [ "${arr[1]}" != "sh" -a "${arr[1]}" != "txt" ]; then
            echo "your file must be 'txt' or 'sh'"
            exit 1
        fi
        rm $folder/${arr[0]}.* 2> /dev/null
        add $1
    fi
    echo "document or script not found, wanna add?[y,yes, any other key for no]"
    read ans
    if [ "${ans,,}" = "y" -o "${ans,,}" = "yes" ]; then
        if [ -f "$path/$1.sh" -a -f "$path/$1.txt" ]; then
            echo "both $1.txt and $1.sh exist, which should be add?[sh , any other key for txt]"
            read ans2
            if [ "$ans2" = "sh" ]; then
                add $1 sh
            else
                add $1 txt
            fi
        elif [ -f "$path/$1.sh" ]; then
            add $1 sh
        elif [ -f "$path/$1.txt" ]; then
            add $1 txt
        fi
    else
        exit 0
    fi
else
    echo "document not found"
    exit 1

fi