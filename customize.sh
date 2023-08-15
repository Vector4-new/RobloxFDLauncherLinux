#!/usr/bin/env bash

# !!! THIS CODE IS ASS !!!

pushd $(dirname $0) > /dev/null

function TargetSelect() {
    echo "Select a target:"
    echo "1: Client"
    echo "2: Server"
    echo "Q: Quit"

    read -r option
    
    if [[ $option == "1" ]]; then
        ClientCustomize
    elif [[ $option == "2" ]]; then
        ServerCustomize
    elif [[ ${option^^} == "Q" ]]; then
        popd > /dev/null
        exit
    fi

    TargetSelect
}

function ClientCustomize() {
    echo "1: Change body colours"
    echo "2: Change appearance"
    echo "3: Change builders club level (currently $(cat webserver/www/robloxfd/htdocs/settings/client/buildersClub.txt))"
    echo "Q: Back to target select"

    read -r option
    
    if [[ $option == "1" ]]; then
        ChangeBodyColours
    elif [[ $option == "2" ]]; then
        ChangeAppearance
    elif [[ $option == "3" ]]; then
        MODE=$(cat webserver/www/robloxfd/htdocs/settings/client/buildersClub.txt)
        MODE=${MODE^^}

        case $MODE in
            "NBC") MODE="BC" ;;
            "BC") MODE="TBC" ;;
            "TBC") MODE="OBC" ;;
            "OBC") MODE="NBC" ;;
            *) echo "Unknown builders club mode '$MODE'"
               MODE="NBC" ;;
        esac

        echo "Set builders club mode to $MODE"
        echo "$MODE" > webserver/www/robloxfd/htdocs/settings/client/buildersClub.txt
    elif [[ ${option^^} == "Q" ]]; then
        return 0
    fi

    ClientCustomize
}

function ChangeBodyColours() {
    BODY_COLOURS=()
    mapfile -t BODY_COLOURS < settings/client/bodyColours.txt

    echo "1: Change head colour (currently ${BODY_COLOURS[0]})"
    echo "2: Change torso colour (currently ${BODY_COLOURS[1]})"
    echo "3: Change left arm colour (currently ${BODY_COLOURS[2]})"
    echo "4: Change right arm colour (currently ${BODY_COLOURS[3]})"
    echo "5: Change left leg colour (currently ${BODY_COLOURS[4]})"
    echo "6: Change right leg colour (currently ${BODY_COLOURS[5]})"
    echo "0: Change to default (all Pastel brown)"
    echo "Q: Back to client customization"

    read -r option
    
    case ${option^^} in
        "1") ChangeBodyColour 0 ;;
        "2") ChangeBodyColour 1 ;;
        "3") ChangeBodyColour 2 ;;
        "4") ChangeBodyColour 3 ;;
        "5") ChangeBodyColour 4 ;;
        "6") ChangeBodyColour 5 ;;
        "0") echo -ne "Pastel brown\nPastel brown\nPastel brown\nPastel brown\nPastel brown\nPastel brown" > settings/client/bodyColours.txt ;;
        "Q") return 0 ;;
    esac

    ChangeBodyColours
}

# $1 = body part index
function ChangeBodyColour() {
    case $1 in
        0) BODY_PART="head" ;;
        1) BODY_PART="torso" ;;
        2) BODY_PART="left arm" ;;
        3) BODY_PART="right arm" ;;
        4) BODY_PART="left leg" ;;
        5) BODY_PART="right leg" ;;
        *) echo "Bad body part index $1"
           return 1 ;;
    esac

    read -p "New BrickColor for $BODY_PART: " -r COLOUR
    FIXED_COLOUR=$(ValidateBrickColor "$COLOUR")

    if [[ $FIXED_COLOUR == "INVALID" ]]; then
        echo "Invalid BrickColor '$COLOUR'"
        echo "You can look up a list of BrickColors to see valid ones."
        echo "Note that old versions may not support some BrickColors."
    else
        BODY_COLOURS[$1]="$FIXED_COLOUR"
        echo -n "" > settings/client/bodyColours.txt

        for (( i = 0; i < 6; i++ )) do
            echo -n "${BODY_COLOURS[$i]}" >> settings/client/bodyColours.txt

            if [[ i -ne 5 ]]; then
                echo "" >> settings/client/bodyColours.txt
            fi
        done

        return 0
    fi
}

# $1 = brick color in
# Echoes capitalized brick color name, otherwise echoes "INVALID"
function ValidateBrickColor() {
    case ${1,,} in
        "white") echo "White" ;;
        "grey") echo "Grey" ;;
        "light yellow") echo "Light yellow" ;;
        "brick yellow") echo "Brick yellow" ;;
        "light green (mint)") echo "Light green (Mint)" ;;
        "light reddish violet") echo "Light reddish violet" ;;
        "pastel blue") echo "Pastel Blue" ;;
        "light orange brown") echo "Light orange brown" ;;
        "nougat") echo "Nougat" ;;
        "bright red") echo "Bright red" ;;
        "med. reddish violet") echo "Med. reddish violet" ;;
        "bright blue") echo "Bright blue" ;;
        "bright yellow") echo "Bright yellow" ;;
        "earth orange") echo "Earth orange" ;;
        "black") echo "Black" ;;
        "dark grey") echo "Dark grey" ;;
        "dark green") echo "Dark green" ;;
        "medium green") echo "Medium green" ;;
        "lig. yellowich orange") echo "Lig. Yellowich orange" ;;
        "bright green") echo "Bright green" ;;
        "dark orange") echo "Dark orange" ;;
        "light bluish violet") echo "Light bluish violet" ;;
        "transparent") echo "Transparent" ;;
        "tr. red") echo "Tr. Red" ;;
        "tr. lg blue") echo "Tr. Lg blue" ;;
        "tr. blue") echo "Tr. Blue" ;;
        "tr. yellow") echo "Tr. Yellow" ;;
        "light blue") echo "Light blue" ;;
        "tr. flu. reddish orange") echo "Tr. Flu. Reddish orange" ;;
        "tr. green") echo "Tr. Green" ;;
        "tr. flu. green") echo "Tr. Flu. Green" ;;
        "phosph. white") echo "Phosph. White" ;;
        "light red") echo "Light red" ;;
        "medium red") echo "Medium red" ;;
        "medium blue") echo "Medium blue" ;;
        "light grey") echo "Light grey" ;;
        "bright violet") echo "Bright violet" ;;
        "br. yellowish orange") echo "Br. yellowish orange" ;;
        "bright orange") echo "Bright orange" ;;
        "bright bluish green") echo "Bright bluish green" ;;
        "earth yellow") echo "Earth yellow" ;;
        "bright bluish violet") echo "Bright bluish violet" ;;
        "tr. brown") echo "Tr. Brown" ;;
        "medium bluish violet") echo "Medium bluish violet" ;;
        "tr. medi. reddish violet") echo "Tr. Medi. reddish violet" ;;
        "med. yellowish green") echo "Med. yellowish green" ;;
        "med. bluish green") echo "Med. bluish green" ;;
        "light bluish green") echo "Light bluish green" ;;
        "br. yellowish green") echo "Br. yellowish green" ;;
        "lig. yellowish green") echo "Lig. yellowish green" ;;
        "med. yellowish orange") echo "Med. yellowish orange" ;;
        "br. reddish orange") echo "Br. reddish orange" ;;
        "bright reddish violet") echo "Bright reddish violet" ;;
        "light orange") echo "Light orange" ;;
        "tr. bright bluish violet") echo "Tr. Bright bluish violet" ;;
        "gold") echo "Gold" ;;
        "dark nougat") echo "Dark nougat" ;;
        "silver") echo "Silver" ;;
        "neon orange") echo "Neon orange" ;;
        "neon green") echo "Neon green" ;;
        "sand blue") echo "Sand blue" ;;
        "sand violet") echo "Sand violet" ;;
        "medium orange") echo "Medium orange" ;;
        "sand yellow") echo "Sand yellow" ;;
        "earth blue") echo "Earth blue" ;;
        "earth green") echo "Earth green" ;;
        "tr. flu. blue") echo "Tr. Flu. Blue" ;;
        "sand blue metallic") echo "Sand blue metallic" ;;
        "sand violet metallic") echo "Sand violet metallic" ;;
        "sand yellow metallic") echo "Sand yellow metallic" ;;
        "dark grey metallic") echo "Dark grey metallic" ;;
        "black metallic") echo "Black metallic" ;;
        "light grey metallic") echo "Light grey metallic" ;;
        "sand green") echo "Sand green" ;;
        "sand red") echo "Sand red" ;;
        "dark red") echo "Dark red" ;;
        "tr. flu. yellow") echo "Tr. Flu. Yellow" ;;
        "tr. flu. red") echo "Tr. Flu. Red" ;;
        "gun metallic") echo "Gun metallic" ;;
        "red flip/flop") echo "Red flip/flop" ;;
        "yellow flip/flop") echo "Yellow flip/flop" ;;
        "silver flip/flop") echo "Silver flip/flop" ;;
        "curry") echo "Curry" ;;
        "fire yellow") echo "Fire Yellow" ;;
        "flame yellowish orange") echo "Flame yellowish orange" ;;
        "reddish brown") echo "Reddish brown" ;;
        "flame reddish orange") echo "Flame reddish orange" ;;
        "medium stone grey") echo "Medium stone grey" ;;
        "royal blue") echo "Royal blue" ;;
        "dark royal blue") echo "Dark Royal blue" ;;
        "bright reddish lilac") echo "Bright reddish lilac" ;;
        "dark stone grey") echo "Dark stone grey" ;;
        "lemon metalic") echo "Lemon metalic" ;;
        "light stone grey") echo "Light stone grey" ;;
        "dark curry") echo "Dark Curry" ;;
        "faded green") echo "Faded green" ;;
        "turquoise") echo "Turquoise" ;;
        "light royal blue") echo "Light Royal blue" ;;
        "medium royal blue") echo "Medium Royal blue" ;;
        "rust") echo "Rust" ;;
        "brown") echo "Brown" ;;
        "reddish lilac") echo "Reddish lilac" ;;
        "lilac") echo "Lilac" ;;
        "light lilac") echo "Light lilac" ;;
        "bright purple") echo "Bright purple" ;;
        "light purple") echo "Light purple" ;;
        "light pink") echo "Light pink" ;;
        "light brick yellow") echo "Light brick yellow" ;;
        "warm yellowish orange") echo "Warm yellowish orange" ;;
        "cool yellow") echo "Cool yellow" ;;
        "dove blue") echo "Dove blue" ;;
        "medium lilac") echo "Medium lilac" ;;
        "slime green") echo "Slime green" ;;
        "smoky grey") echo "Smoky grey" ;;
        "dark blue") echo "Dark blue" ;;
        "parsley green") echo "Parsley green" ;;
        "steel blue") echo "Steel blue" ;;
        "storm blue") echo "Storm blue" ;;
        "lapis") echo "Lapis" ;;
        "dark indigo") echo "Dark indigo" ;;
        "sea green") echo "Sea green" ;;
        "shamrock") echo "Shamrock" ;;
        "fossil") echo "Fossil" ;;
        "mulberry") echo "Mulberry" ;;
        "forest green") echo "Forest green" ;;
        "cadet blue") echo "Cadet blue" ;;
        "electric blue") echo "Electric blue" ;;
        "eggplant") echo "Eggplant" ;;
        "moss") echo "Moss" ;;
        "artichoke") echo "Artichoke" ;;
        "sage green") echo "Sage green" ;;
        "ghost grey") echo "Ghost grey" ;;
        "lilac") echo "Lilac" ;;
        "plum") echo "Plum" ;;
        "olivine") echo "Olivine" ;;
        "laurel green") echo "Laurel green" ;;
        "quill grey") echo "Quill grey" ;;
        "crimson") echo "Crimson" ;;
        "mint") echo "Mint" ;;
        "baby blue") echo "Baby blue" ;;
        "carnation pink") echo "Carnation pink" ;;
        "persimmon") echo "Persimmon" ;;
        "maroon") echo "Maroon" ;;
        "gold") echo "Gold" ;;
        "daisy orange") echo "Daisy orange" ;;
        "pearl") echo "Pearl" ;;
        "fog") echo "Fog" ;;
        "salmon") echo "Salmon" ;;
        "terra cotta") echo "Terra Cotta" ;;
        "cocoa") echo "Cocoa" ;;
        "wheat") echo "Wheat" ;;
        "buttermilk") echo "Buttermilk" ;;
        "mauve") echo "Mauve" ;;
        "sunrise") echo "Sunrise" ;;
        "tawny") echo "Tawny" ;;
        "rust") echo "Rust" ;;
        "cashmere") echo "Cashmere" ;;
        "khaki") echo "Khaki" ;;
        "lily white") echo "Lily white" ;;
        "seashell") echo "Seashell" ;;
        "burgundy") echo "Burgundy" ;;
        "cork") echo "Cork" ;;
        "burlap") echo "Burlap" ;;
        "beige") echo "Beige" ;;
        "oyster") echo "Oyster" ;;
        "pine cone") echo "Pine Cone" ;;
        "fawn brown") echo "Fawn brown" ;;
        "hurricane grey") echo "Hurricane grey" ;;
        "cloudy grey") echo "Cloudy grey" ;;
        "linen") echo "Linen" ;;
        "copper") echo "Copper" ;;
        "medium brown") echo "Medium brown" ;;
        "bronze") echo "Bronze" ;;
        "flint") echo "Flint" ;;
        "dark taupe") echo "Dark taupe" ;;
        "burnt sienna") echo "Burnt Sienna" ;;
        "institutional white") echo "Institutional white" ;;
        "mid gray") echo "Mid gray" ;;
        "really black") echo "Really black" ;;
        "really red") echo "Really red" ;;
        "deep orange") echo "Deep orange" ;;
        "alder") echo "Alder" ;;
        "dusty rose") echo "Dusty Rose" ;;
        "olive") echo "Olive" ;;
        "new yeller") echo "New Yeller" ;;
        "really blue") echo "Really blue" ;;
        "navy blue") echo "Navy blue" ;;
        "deep blue") echo "Deep blue" ;;
        "cyan") echo "Cyan" ;;
        "cga brown") echo "CGA brown" ;;
        "magenta") echo "Magenta" ;;
        "pink") echo "Pink" ;;
        "deep orange") echo "Deep orange" ;;
        "teal") echo "Teal" ;;
        "toothpaste") echo "Toothpaste" ;;
        "lime green") echo "Lime green" ;;
        "camo") echo "Camo" ;;
        "grime") echo "Grime" ;;
        "lavender") echo "Lavender" ;;
        "pastel light blue") echo "Pastel light blue" ;;
        "pastel orange") echo "Pastel orange" ;;
        "pastel violet") echo "Pastel violet" ;;
        "pastel blue-green") echo "Pastel blue-green" ;;
        "pastel green") echo "Pastel green" ;;
        "pastel yellow") echo "Pastel yellow" ;;
        "pastel brown") echo "Pastel brown" ;;
        "royal purple") echo "Royal purple" ;;
        "hot pink") echo "Hot pink" ;;
        *) echo "INVALID" ;;
    esac
}

function ChangeAppearance() {
    # no strict format, these can be in any order, so we just do it manually

    APPEARANCE=( $(grep -P "id=\d+" settings/client/appearance.txt | grep -Po "\d+") )

    echo "ID's:"

    for (( i = 0; i < ${#APPEARANCE[@]}; i++ )) do
        echo -n "$i: ${APPEARANCE[$i]}"

        if [[ $i -ne $((${#APPEARANCE[@]} - 1)) ]]; then
            echo -n ", "
        fi
    done

    echo -e "\n"

    echo "The appearance file is just a list of ID's."
    echo "This means there's no strict format and accessories can be in any order and of any type,"
    echo "which means you must manually input ID's."
    echo "Should support pretty much anything from the catalog, including body parts (from bundles) (support varies based on client)"

    echo "I[N]: Insert asset ID N"
    echo "M[N]: Modify asset index N"
    echo "R[N]: Remove asset index N"
    echo "D: Reset to default"
    echo "Q: Back to client customization"

    read -r option

    option=${option^^}

    if [[ $option == "D" ]]; then 
        APPEARANCE=( "86498048" "86500008" "86500036" "86500054" "86500064" "86500078" "144076760" "144076358" "63690008" "86500036" "86500078" "86500064" "86500054" "86500008" )
    elif [[ ${option:0:1} == "I" ]]; then
        if [ ${option:1} -gt 0 ] 2> /dev/null; then
            APPEARANCE+=(${option:1})
        else
            echo "Asset ID '${option:1}' is not an integer above 0"
        fi
    elif [[ $option == "Q" ]]; then
        return 0
    elif [[ ${option:0:1} == "M" ]]; then
        if [ ${option:1} -ge 0 ] 2> /dev/null; then
            read -p "New asset ID for index ${option:1} (leave blank to cancel): " -r ID

            if [ $ID -gt 0 ] 2> /dev/null; then
                APPEARANCE[${option:1}]=$ID
            elif [[ ! -z "$ID" ]]; then
                echo "Asset ID '$ID' is not an integer above 0"
            fi
        else
            echo "Asset index '${option:1}' is not an integer equal to or above 0"
        fi
    elif [[ ${option:0:1} == "R" ]]; then
        if [ ${option:1} -ge 0 ] 2> /dev/null; then
            APPEARANCE=( "${APPEARANCE[@]:0:${option:1}}" "${APPEARANCE[@]:$((${option:1} + 1))}" )
        else
            echo "Asset index '${option:1}' is not an integer equal to or above 0"
        fi
    fi

    echo -n "http://localhost/charscript/Custom.php?hat=0" > settings/client/appearance.txt

    for (( i = 0; i < ${#APPEARANCE[@]}; i++ )) do
        echo "" >> settings/client/appearance.txt
        echo -n "http://localhost/asset/?id=${APPEARANCE[$i]}" >> settings/client/appearance.txt
    done

    ChangeAppearance
}

# $1 = string
function CheckEmpty() {
    if [[ -z "$1" ]]; then
        echo "empty"
    else
        echo "$1"
    fi
}

function ServerCustomize() {
    echo "1: Toggle asset saving (currently $(cat settings/server/assetSaving.txt))"
    echo "2: Toggle filtering enabled (2022M, currently $(cat settings/server/filteringEnabled.txt))"
    echo "3: Toggle rig type (currently $(cat settings/server/rigType.txt))"
    echo "Q: Back to target select"

    read -r option

    if [[ $option == "1" ]]; then
        VALUE=$(cat settings/server/assetSaving.txt)

        if [[ ${VALUE,,} == "false" ]]; then
            echo -n true > settings/server/assetSaving.txt
        elif [[ ${VALUE,,} == "true" ]]; then
            echo -n false > settings/server/assetSaving.txt
        else
            echo "Asset saving has illegal boolean '$VALUE'!"
            echo "Set value to false."

            echo -n false > settings/server/assetSaving.txt
        fi
    elif [[ $option == "2" ]]; then
        VALUE=$(cat settings/server/filteringEnabled.txt)

        if [[ ${VALUE,,} == "false" ]]; then
            echo -n true > settings/server/filteringEnabled.txt
        elif [[ ${VALUE,,} == "true" ]]; then
            echo -n false > settings/server/filteringEnabled.txt
        else
            echo "Filtering state has illegal boolean '$VALUE'!"
            echo "Set value to false."

            echo -n false > settings/server/filteringEnabled.txt
        fi
    elif [[ $option == "3" ]]; then
        VALUE=$(cat settings/server/rigType.txt)

        if [[ ${VALUE,,} == "r6" ]]; then
            echo -n R15 > settings/server/rigType.txt
        elif [[ ${VALUE,,} == "r15" ]]; then
            echo -n R6 > settings/server/rigType.txt
        else
            echo "Asset saving has illegal rig type '$VALUE'!"
            echo "Set value to R6."

            echo -n r6 > settings/server/rigType.txt
        fi
    elif [[ ${option^^} == "Q" ]]; then
        return 0
    fi

    ServerCustomize
}

TargetSelect

popd > /dev/null