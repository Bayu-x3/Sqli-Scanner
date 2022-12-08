#!/bin/bash
red='\033[0;41m'
hijau='\033[1;42m'
biru='\033[1;34m'
biru2='\033[1;44m'
n='\033[0m'
function sqlibanner() {
echo -e "					      
#####################################
#           SQLI - SCANNER          #
#      Tools Untuk Scan Vuln SQl    #
#####################################
${biru}${n}\n"
}
function sqli_massive() {
clear
sqlibanner
echo -n "[+] List Website: "
        read mass_site
echo -n "[+] Output name ext .txt : "
        read output_mass
        echo ""
                while IFS= read -r ms
                do
                        curl -s $ms | wc -l > ms1
                        curl -s $ms\' | wc -l > ms2
                        ms1=$(cat ms1)
                        ms2=$(cat ms2)
                        if [ $ms1 -lt $ms2 ]; then
                                echo -e "${hijau}[+]${n} ${biru}$ms${n} ${hijau}[VULN]${n}"
                                echo "$ms" >> mass_$output_mass
                        elif [ $ms1 -gt $ms2 ]; then
                                echo -e "${hijau}[+]${n} ${biru}$ms${n} ${hijau}[VULN]${n}"
                                echo "$ms" >> mass_$output_mass
                        elif [ $ms1 -eq $ms2 ]; then
                                echo -e "${red}[-]${n} ${biru}$ms${n} ${red}[NOT FOUND]${n}"
                        fi
                done < $mass_site
rm ms1 ms2
jumlah_sqli=$(cat mass_$output_mass | wc -l)
echo " "
        echo "Saved on mass_$output_mass, Total $jumlah_sqli line"
}
function sqli_single() {
clear
sqlibanner
echo -n "[+] Site: "
        read site
                curl -s $site | wc -l > file1
                curl -s $site\' | wc -l > file2
                file1=$(cat file1)
                file2=$(cat file2)
                if [ $file1 -lt $file2 ]; then
                        echo -e "${hijau}[+]${n} $site ${hijau}[VULN]${n}"
                elif [ $file1 -gt $file2 ]; then
                        echo -e "${hijau}[+]${n} $site ${hijau}[VULN]${n}"
                elif [ $file1 -eq $file2 ]; then
                        echo -e "${red}[-]${n} $site ${red}[NOT FOUND]${n}"
                fi
rm file1 file2
}
function sqlimain() {
clear
sqlibanner
today=$(date)
echo -e "Today: $today\n"
echo -e "[1] Single\n[2] Mass\n"
echo -n "root@localhost~#:  "
        read sqli_play
                if [ $sqli_play -eq 1 ]; then
                        sqli_single
                elif [ $sqli_play -eq 2 ]; then
                        sqli_massive
                fi
lanjut_sqli
}
function lanjut_sqli() {
echo -n "[+] Back? y/n: "
        read back_sqli
                if [ $back_sqli = "y" ]; then
                        sqlimain
                elif [ $back_sqli = "n" ]; then
                        echo "Thanks For Using"
                fi
}
sqlimain
