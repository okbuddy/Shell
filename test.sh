#!/bin/bash


#解压.tar.gz和.tgz文件
cd /root
ls *.tar.gz > ls.log &> /dev/null
ls *.tgz >> ls.log
for i in $(cat ls.log); do
	tar -zxvf $i &> /dev/null
done
rm -rf ls.log

#添加多个用户
read -p 'input the name prefix:' name
read -p 'input the quantity:' n
read -p 'input the passwd:' passwd

if [ -z "$name" -o -z "$n" -o -z "$passwd" ]; then
	echo 'empty input'
	exit 1
fi
n1=$(echo $n|sed 's/[0-9]//g')
if [ ! -z $n1 ]; then
	echo 'input a number '
	exit 2
fi
for (( i = 0; i < $n; i++ )); do
	/usr/sbin/useradd $name$i &> /dev/null
	echo $passwd|/usr/bin/passwd --stdin $name$i &> /dev/null
done

#判断执行哪个文件

#!/bin/bash
cd /root
scripts=$(ls|grep '\.sh'|grep -v hello.sh)
declare -A dic
id=0
numbers=""
for i in $scripts; do
	echo -e "\033[1;35m The file: $id " '==>  '"\033[0m" $i
	dic["$id"]=$i
	numbers=$numbers'|'$id
	let id=id+1
done
while true; do
	echo -e "\033[1;36m choose from $numbers \033[0m"
	read -p 'input the file id:' fid
#不要双引号
	test=$(echo $fid|sed 's/[0-9]//g')
	if [ -n "$test" ]; then
	echo "wrong fid , input a number"
	continue
	fi
	if [[ $fid =~ ^0 && "$fid" != "0" ]]; then
	echo "do not start with 0"
	continue
	fi
	if [ "$fid" -lt "0" -o "$fid" -ge "$id" ]; then
	echo 'out of range'
	continue
	fi
#执行选中的程序文件
	exe=${dic[$fid]}
	echo 'execute the file: ' "$exe"
	/usr/bin/bash ./$exe
done









