#!/bin/bash
echo -e"\e[35m
░█▀▀█ ▀█▀ ░█▄─░█ 
░█▀▀▄ ░█─ ░█░█░█ 
░█▄▄█ ▄█▄ ░█──▀█ 

░█▀▀█ ░█▀▀▀ ░█▄─░█ 
░█─▄▄ ░█▀▀▀ ░█░█░█ 
░█▄▄█ ░█▄▄▄ ░█──▀█\e[Om"

echo -e"\e[31mGENERADOR DE BINES EDUBIOS\e[Om"

nción para generar contraseñas seguras
generate_password() {
    local length=$1
    local include_symbols=$2
    local characters="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local symbols="!@#$%^&*()_-+={}[]|;:,.<>?"
    if [ "$include_symbols" = true ]; then
        characters+="$symbols"
    fi
    local password=$(tr -dc "$characters" < /dev/urandom | head -c "$length")
    echo "$password"
}

# Función para generar nombres latinos
generate_latin_name() {
    local first_names=("Alejandro" "Beatriz" "Carlos" "Daniela" "Enrique" "Fernanda" "Guillermo" "Isabela" "Joaquín" "Karina" "Luis" "María")
    local last_names=("Rodríguez" "Sánchez" "Gómez" "Hernández" "Jiménez" "Martínez" "Ramírez" "Torres" "Vargas" "Vega" "Díaz" "Reyes")
    local first_name="${first_names[$((RANDOM % ${#first_names[@]})])}"
    local last_name="${last_names[$((RANDOM % ${#last_names[@]})])}"
    echo "$first_name $last_name"
}

# Solicitar la cantidad de contraseñas a generar
echo "¿Cuántas contraseñas desea generar?"
read num_passwords

# Solicitar si se desean incluir símbolos en las contraseñas
echo "¿Desea incluir símbolos en las contraseñas? (s/n)"
read include_symbols_input
include_symbols=false
if [ "$include_symbols_input" = "s" ]; then
    include_symbols=true
fi

# Crear el directorio de la tarjeta SD si no existe
mkdir -p /sdcard/PasswordGenerator

# Generar y guardar las contraseñas
for i in $(seq 1 $num_passwords); do
    latin_name=$(generate_latin_name)
    password=$(generate_password 20 $include_symbols)
    echo "$latin_name: $password" >> /sdcard/PasswordGenerator/passwords.txt
done

echo "Las contraseñas se han generado y guardado en /sdcard/PasswordGenerator/passwords.txt"