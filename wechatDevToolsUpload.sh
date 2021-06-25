#!/bin/bash

# wechat DevTools Upload 微信开发者工具命令行上传代码
# 在.zshrc 或者 .bashrc中添加别名 alias cli-upload="/Users/linweiye/Documents/shell-script/wechatDevToolsUpload.sh"
# git commit message 格式 version: des. 4.1.7: feature:添加xxx功能
# 在小程序目录下使用 cli-upload 或者 cli-upload "4.1.7: feature:添加xxx功能"
# cli-upload后面没有带参数，会使用git commiet message

dir=$(pwd)

if [ -z "$1" ]
then
  # get last git commit Message
  last_git_commit_message="$(git log -1 --pretty=%B)"
else
  last_git_commit_message=$1
fi

echo $last_git_commit_message


#Define multi-character delimiter
delimiter=": "
#Concatenate the delimiter with the main string
string=$last_git_commit_message$delimiter
#Split the text based on the delimiter
myarray=()
while [[ $string ]]; do
  myarray+=( "${string%%"$delimiter"*}" )
  string=${string#*"$delimiter"}
done
version=${myarray[0]}
desc=${myarray[1]}
if [[ -z $version || -z $desc ]]
then
   echo "版本号，版本备注不能为空"
   exit
fi

echo "版本号: $version"
echo "上传代码时的备注: $desc"

/Applications/wechatwebdevtools.app/Contents/MacOS/cli upload --project $dir -v $version -d $desc