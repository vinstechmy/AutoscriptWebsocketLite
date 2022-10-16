#!/bin/bash
shell_version="1.2.2";
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36";
UA_Dalvik="Dalvik/2.1.0 (Linux; U; Android 9; ALP-AL00 Build/HUAWEIALP-AL00)";
Disney_Auth="grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Atoken-exchange&latitude=0&longitude=0&platform=browser&subject_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJiNDAzMjU0NS0yYmE2LTRiZGMtOGFlOS04ZWI3YTY2NzBjMTIiLCJhdWQiOiJ1cm46YmFtdGVjaDpzZXJ2aWNlOnRva2VuIiwibmJmIjoxNjIyNjM3OTE2LCJpc3MiOiJ1cm46YmFtdGVjaDpzZXJ2aWNlOmRldmljZSIsImV4cCI6MjQ4NjYzNzkxNiwiaWF0IjoxNjIyNjM3OTE2LCJqdGkiOiI0ZDUzMTIxMS0zMDJmLTQyNDctOWQ0ZC1lNDQ3MTFmMzNlZjkifQ.g-QUcXNzMJ8DwC9JqZbbkYUSKkB1p4JGW77OON5IwNUcTGTNRLyVIiR8mO6HFyShovsR38HRQGVa51b15iAmXg&subject_token_type=urn%3Abamtech%3Aparams%3Aoauth%3Atoken-type%3Adevice"
Disney_Header="authorization: Bearer ZGlzbmV5JmJyb3dzZXImMS4wLjA.Cu56AgSfBTDag5NiRA81oLHkDZfu5L3CKadnefEAY84"


Font_Black="\033[30m";
Font_Red="\033[31m";
Font_Green="\033[32m";
Font_Yellow="\033[33m";
Font_Blue="\033[34m";
Font_Purple="\033[35m";
Font_SkyBlue="\033[36m";
Font_White="\033[37m";
Font_Suffix="\033[0m";


clear;
echo -e "###############################################################";
echo -e "#  ${Font_Purple}Media Stream Unlocker Test Mod By Vinstechmy${Font_Suffix}";
echo -e "#  Version : ${Font_SkyBlue}v${shell_version}${Font_Suffix}";
echo -e "#  Time    : $(date)"
echo -e "###############################################################";

export LANG="en_US.UTF-8";
export LANGUAGE="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

function InstallJQ() {
    if [ -e "/etc/redhat-release" ];then
        echo -e "${Font_Green}Installing dependencies: epel-release${Font_Suffix}";
        yum install epel-release -y -q > /dev/null;
        echo -e "${Font_Green}Installing dependencies: jq${Font_Suffix}";
        yum install jq -y -q > /dev/null;
    elif [[ $(cat /etc/os-release | grep '^ID=') =~ ubuntu ]] || [[ $(cat /etc/os-release | grep '^ID=') =~ debian ]];then
        echo -e "${Font_Green}Updating package list...${Font_Suffix}";
        apt-get update -y > /dev/null;
        echo -e "${Font_Green}Installing dependencies: jq${Font_Suffix}";
        apt-get install jq -y > /dev/null;
    else
        echo -e "${Font_Red}Please install jq manually${Font_Suffix}";
        exit;
    fi
}

function InstallCurl() {
    if [ -e "/etc/redhat-release" ];then
        echo -e "${Font_Green}Installing dependencies: curl${Font_Suffix}";
        yum install curl -y > /dev/null;
    elif [[ $(cat /etc/os-release | grep '^ID=') =~ ubuntu ]] || [[ $(cat /etc/os-release | grep '^ID=') =~ debian ]];then
        echo -e "${Font_Green}Updating package list...${Font_Suffix}";
        apt-get update -y > /dev/null;
        echo -e "${Font_Green}Installing dependencies: curl${Font_Suffix}";
        apt-get install curl -y > /dev/null;
    else
        echo -e "${Font_Red}请手动安装curl${Font_Suffix}";
        exit;
    fi
}

function PharseJSON() {
    # 使用方法: PharseJSON "要解析的原JSON文本" "要解析的键值"
    # Example: PharseJSON ""Value":"123456"" "Value" [返回结果: 123456]
    echo -n $1 | jq -r .$2;
}

function GameTest_Steam(){
    echo -n -e " Steam:\t\t\t\t\t->\c";
    local result=$(curl --user-agent "${UA_Browser}" -${1} -fsSL --max-time 10 https://store.steampowered.com/app/761830 2>&1 | grep priceCurrency | cut -d '"' -f4);
    
    if [ ! -n "$result" ]; then
        echo -n -e "\r Steam:\t\t\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n";
    else
        echo -n -e "\r Steam:\t\t\t\t\t${Font_Green}Yes(Currency: ${result})${Font_Suffix}\n";
    fi
}

function MediaUnlockTest_Netflix() {
    echo -n -e " Netflix:\t\t\t\t->\c";
    local result=$(curl -${1} --user-agent "${UA_Browser}" -sSL "https://www.netflix.com/" 2>&1);
    if [ "$result" == "Not Available" ];then
        echo -n -e "\r Netflix:\t\t\t\t${Font_Red}Unsupport${Font_Suffix}\n";
        return;
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -n -e "\r Netflix:\t\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n";
        return;
    fi
    
    local result=$(curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/81403959" 2>&1);
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -n -e "\r Netflix:\t\t\t\t${Font_Red}No${Font_Suffix}\n";
        return;
    fi
    
    local result1=$(curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/70143836" 2>&1);
    local result2=$(curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/80027042" 2>&1);
    local result3=$(curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/70140425" 2>&1);
    local result4=$(curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/70283261" 2>&1);
    local result5=$(curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/70143860" 2>&1);
    local result6=$(curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/70202589" 2>&1);
    
    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -n -e "\r Netflix:\t\t\t\t${Font_Yellow}Only Homemade${Font_Suffix}\n";
        return;
    fi
    
    local region=$(tr [:lower:] [:upper:] <<< $(curl -${1} --user-agent "${UA_Browser}" -fs --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/81403959" | cut -d '/' -f4 | cut -d '-' -f1));
    
    if [[ ! -n "$region" ]];then
        region="MY";
    fi
    echo -n -e "\r Netflix:\t\t\t\t${Font_Green}Yes(Region: ${region})${Font_Suffix}\n";
    return;
}

function MediaUnlockTest_Netflix() {
    echo -n -e " Netflix:\t\t\t\t->\c"
    local result1=$(curl $useNIC $xForward -${1} --user-agent "${UA_Browser}" -fsL --write-out %{http_code} --output /dev/null --max-time 10 "https://www.netflix.com/title/81215567" 2>&1)

    if [[ "$result1" == "404" ]]; then
        echo -n -e "\r Netflix:\t\t\t\t${Font_Yellow}Originals Only${Font_Suffix}\n"
        return
    elif [[ "$result1" == "403" ]]; then
        echo -n -e "\r Netflix:\t\t\t\t${Font_Red}No${Font_Suffix}\n"
        return
    elif [[ "$result1" == "200" ]]; then
        local region=$(curl $useNIC $xForward -${1} --user-agent "${UA_Browser}" -fs --max-time 10 --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/80018499" | cut -d '/' -f4 | cut -d '-' -f1 | tr [:lower:] [:upper:])
        if [[ ! -n "$region" ]]; then
            region="US"
        fi
        echo -n -e "\r Netflix:\t\t\t\t${Font_Green}Yes (Region: ${region})${Font_Suffix}\n"
        return
    elif [[ "$result1" == "000" ]]; then
        echo -n -e "\r Netflix:\t\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return
    fi
}

function MediaUnlockTest_DisneyPlus() {
    echo -n -e " DisneyPlus:\t\t\t\t->\c";
    local result=$(curl -${1} --user-agent "${UA_Browser}" -sSL "https://global.edge.bamgrid.com/token" 2>&1);
    
    if [[ "$result" == "curl"* ]];then
        echo -n -e "\r DisneyPlus:\t\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return;
    fi
	
	local previewcheck=$(curl -s -o /dev/null -L --max-time 10 -w '%{url_effective}\n' "https://disneyplus.com" | grep preview 2>&1);
	if [ -n "${previewcheck}" ];then
		echo -n -e "\r DisneyPlus:\t\t\t\t${Font_Red}No${Font_Suffix}\n"
		return;
	fi	
		
    
	local result=$(curl -${1} -s --user-agent "${UA_Browser}" -H "Content-Type: application/x-www-form-urlencoded" -H "${Disney_Header}" -d ''${Disney_Auth}'' -X POST  "https://global.edge.bamgrid.com/token" 2>&1)
	local access_token=$(PharseJSON "${result}" "access_token")

    if [[ "$access_token" == "null" ]]; then
		echo -n -e "\r DisneyPlus:\t\t\t\t${Font_Red}No${Font_Suffix}\n"
		return;
	fi
	
	region=$(curl -${1} -s https://www.disneyplus.com | grep 'region: ' | awk '{print $2}')
	if [ -n "$region" ]; then
		echo -n -e "\r DisneyPlus:\t\t\t\t${Font_Green}Yes(Region: ${region})${Font_Suffix}\n"
		return;
	else
		local website=$(curl -${1} --user-agent "${UA_Browser}" -fs --write-out '%{redirect_url}\n' --output /dev/null "https://www.disneyplus.com")
		if [[ "${website}" == "https://disneyplus.disney.co.jp/" ]]; then
			echo -n -e "\r DisneyPlus:\t\t\t\t${Font_Green}Yes(Region: JP)${Font_Suffix}\n"
			return;
		else
			#local region=$(echo ${website} | cut -f4 -d '/' | tr 'a-z' 'A-Z')
			echo -n -e "\r DisneyPlus:\t\t\t\t${Font_Green}Yes(Region: Unknow)${Font_Suffix}\n"
			return;
		fi
	fi
}

function MediaUnlockTest_iQiyi(){
    echo -n -e " iQiyi Global:\t\t\t\t->\c";
    local tmpresult=$(curl -${1} -s -I "https://www.iq.com/" 2>&1);
    if [[ "$tmpresult" == "curl"* ]];then
        	echo -n -e "\r iQiyi Global:\t\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        	return;
    fi
    
    local result=$(echo "${tmpresult}" | grep 'mod=' | awk '{print $2}' | cut -f2 -d'=' | cut -f1 -d';');
    if [ -n "$result" ]; then
		if [[ "$result" == "ntw" ]]; then
			echo -n -e "\r iQiyi Global:\t\t\t\t${Font_Green}Yes(Region: TW)${Font_Suffix}\n"
			return;
		else
			result=$(echo ${result} | tr 'a-z' 'A-Z') 
			echo -n -e "\r iQiyi Global:\t\t\t\t${Font_Green}Yes(Region: ${result})${Font_Suffix}\n"
			return;
		fi	
    else
		echo -n -e "\r iQiyi Global:\t\t\t\t${Font_Red}Failed${Font_Suffix}\n"
		return;
	fi	
}

function MediaUnlockTest_Viu_com() {
    echo -n -e " Viu.com:\t\t\t\t->\c";
    local tmpresult=$(curl -${1} -s -o /dev/null -L --max-time 30 -w '%{url_effective}\n' "https://www.viu.com/" 2>&1);
	if [[ "${tmpresult}" == "curl"* ]];then
        echo -n -e "\r Viu.com:\t\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return;
    fi
	
	local result=$(echo ${tmpresult} | cut -f5 -d"/")
	if [ -n "${result}" ]; then
		if [[ "${result}" == "no-service" ]]; then
			echo -n -e "\r Viu.com:\t\t\t\t${Font_Red}No${Font_Suffix}\n"
			return;
		else
			result=$(echo ${result} | tr 'a-z' 'A-Z')
			echo -n -e "\r Viu.com:\t\t\t\t${Font_Green}Yes(Region: ${result})${Font_Suffix}\n"
			return;
		fi
    else
		echo -n -e "\r Viu.com:\t\t\t\t${Font_Red}Failed${Font_Suffix}\n"
		return;
	fi
}

function MediaUnlockTest_TikTok(){
    echo -n -e " Tiktok:\t\t\t\t->\c";
    local tmpresult=$(curl --user-agent "${UA_Browser}" -${1} -s --max-time 10 "https://www.tiktok.com/" 2>&1)
	if [[ "${tmpresult}" == "curl"* ]];then
        echo -n -e "\r Tiktok:\t\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return;
    fi
    
	local result=$(echo $tmpresult | grep '"$region":"' | sed 's/.*"$region//' | cut -f3 -d'"')
    if [ -n "$result" ];then
        echo -n -e "\r Tiktok:\t\t\t\t${Font_Green}Yes(Region: ${result})${Font_Suffix}\n"
        return;
	else
		echo -n -e "\r Tiktok:\t\t\t\t${Font_Red}Failed${Font_Suffix}\n"
		return;
    fi
}

function MediaUnlockTest_YouTube() {
    echo -n -e " YouTube:\t\t\t\t->\c";
    local tmpresult=$(curl -${1} -s -H "Accept-Language: en" "https://www.youtube.com/premium")
    local region=$(curl --user-agent "${UA_Browser}" -${1} -sL "https://www.youtube.com/red" | sed 's/,/\n/g' | grep "countryCode" | cut -d '"' -f4)
	if [ -n "$region" ]; then
        sleep 0
	else
		region=US
	fi	
	
    if [[ "$tmpresult" == "curl"* ]];then
        echo -n -e "\r YouTube:\t\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return;
    fi
    
    local result=$(echo $tmpresult | grep 'Premium is not available in your country')
    if [ -n "$result" ]; then
        echo -n -e "\r YouTube:\t\t\t\t${Font_Red}No Premium${Font_Suffix}(Region: ${region})${Font_Suffix} \n"
        return;
		
    fi
    local result=$(echo $tmpresult | grep 'YouTube and YouTube Music ad-free')
    if [ -n "$result" ]; then
        echo -n -e "\r YouTube:\t\t\t\t${Font_Green}Yes(Region: ${region})${Font_Suffix}\n"
        return;
	else
		echo -n -e "\r YouTube:\t\t\t\t${Font_Red}Failed${Font_Suffix}\n"
		
    fi	
	
    
}

function MediaUnlockTest_PrimeVideo(){
    echo -n -e " Amazon Prime Video:\t\t\t->\c";
    local tmpresult=$(curl -${1} --max-time 10 --user-agent "${UA_Browser}" -s "https://www.primevideo.com" 2>&1)
    if [[ "${result}" == "curl"* ]];then
        echo -n -e "\r Amazon Prime Video:\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return;
    fi
    
	local result=$(echo $tmpresult | grep '"currentTerritory":' | sed 's/.*"currentTerritory//' | cut -f3 -d'"' | head -n 1)
    if [ -n "$result" ];then
        echo -n -e "\r Amazon Prime Video:\t\t\t${Font_Green}Yes(Region: $result)${Font_Suffix}\n"
        return;
	else
		echo -n -e "\r Amazon Prime Video:\t\t\t${Font_Red}No${Font_Suffix}\n"
		return;
    fi
}

function IPInfo() {
    local result=$(curl -fsSL http://ip-api.com/json/ 2>&1);
	
	echo -e -n " IP:\t\t\t\t\t->\c";
    local ip=$(PharseJSON "${result}" "query");
	echo -e -n "\r IP:\t\t\t\t\t${Font_Green}${ip}${Font_Suffix}\n";
	
	echo -e -n " Country:\t\t\t\t->\c";
	local country=$(PharseJSON "${result}" "country");
	echo -e -n "\r Country:\t\t\t\t${Font_Green}${country}${Font_Suffix}\n";
	
	echo -e -n " Region:\t\t\t\t->\c";
	local region=$(PharseJSON "${result}" "regionName");
	echo -e -n "\r Region:\t\t\t\t${Font_Green}${region}${Font_Suffix}\n";
	
	echo -e -n " City:\t\t\t\t\t->\c";
	local city=$(PharseJSON "${result}" "city");
	echo -e -n "\r City:\t\t\t\t\t${Font_Green}${city}${Font_Suffix}\n";
	
	echo -e -n " ISP:\t\t\t\t\t->\c";
	local isp=$(PharseJSON "${result}" "isp");
	echo -e -n "\r ISP:\t\t\t\t\t${Font_Green}${isp}${Font_Suffix}\n";
	
	echo -e -n " Org:\t\t\t\t\t->\c";
	local org=$(PharseJSON "${result}" "org");
	echo -e -n "\r Org:\t\t\t\t\t${Font_Green}${org}${Font_Suffix}\n";
}

function MediaUnlockTest() {
	IPInfo ${1};
	
    global ${1};
}

function global() {
	echo -e "\n -- Global --"
	MediaUnlockTest_Netflix ${1};
	MediaUnlockTest_DisneyPlus ${1};
	MediaUnlockTest_YouTube ${1};
	MediaUnlockTest_PrimeVideo ${1};
	MediaUnlockTest_TikTok ${1};
	MediaUnlockTest_iQiyi ${1};
	MediaUnlockTest_Viu_com ${1};
	GameTest_Steam ${1};
}

function startcheck() {
    mode=${1}
    mode=$(echo ${mode} | tr 'A-Z' 'a-z')
    if [[ "${mode}" != "" ]]; then
        case $mode in
            'global')
                IPInfo ${2};
                global ${2};
            ;;
            *)
                MediaUnlockTest ${2};
        esac
    else
        MediaUnlockTest ${2};
    fi
}

# curl 包测试
if ! curl -V > /dev/null 2>&1;then
    InstallCurl;
fi

# jq 包测试
if ! jq -V > /dev/null 2>&1;then
    InstallJQ;
fi

echo "";
echo "- IPV4 -";
check4=$(ping 1.1.1.1 -c 1 2>&1);
if [[ "$check4" != *"unreachable"* ]] && [[ "$check4" != *"Unreachable"* ]];then
    startcheck "${1}" "4";
else
    v4=""
    echo -e "${Font_SkyBlue}The current host does not support IPV4, skip...${Font_Suffix}";
fi

echo ""
echo "- IPV6 -";
check6=$(ping6 240c::6666 -c 1 2>&1);
if [[ "$check6" != *"unreachable"* ]] && [[ "$check6" != *"Unreachable"* ]];then
    v6="1"
else
    v6=""
    echo -e "${Font_SkyBlue}The current host does not support IPV6, skip...${Font_Suffix}";
fi

echo -e "\n${Font_Green}Finished Test.${Font_Suffix}\n"
