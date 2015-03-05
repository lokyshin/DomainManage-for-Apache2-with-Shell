#!/bin/bash
clear
echo "";
echo "Ubuntu Apache2 域名管理"
echo "[提示] Ubuntu版本>12.10"
echo "   Written by Lokyshin"
echo ""
echo ""

function DomainManage()
{
if [ "$dm" == '增加域名' ]; then
echo ""
echo -n "请输入您希望增加的完整域名（不含conf）,如lokyshin.com，blog.lokyshin.com: "
read domainname
echo "#写入配置文件..."
echo "<Virtual Host *:80>" > /etc/apache2/sites-available/"$domainname".conf
echo "  ServerAdmin admin@$domainname" >> /etc/apache2/sites-available/"$domainname".conf
echo "  DocumentRoot /var/www/$domainname" >> /etc/apache2/sites-available/"$domainname".conf
echo "  ErrorLog \${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/"$domainname".conf
echo "  CustomLog \${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/"$domainname".conf
echo "</Virtual Host>" >> /etc/apache2/sites-available/"$domainname".conf
echo "已完成。"
a2ensite "$domainname".conf
service apache2 reload
elif [ "$dcrol" == '删除域名' ]; then
echo ""
echo -n "请输入您希望删除的完整域名，不含conf: "
read domainname
a2ensite "$domainname".conf
rm /etc/apache2/sites-available/"$domainname".conf
rm /etc/apache2/sites-enabled/"$domainname".conf
service apache2 reload
echo "已经成功删除域名。"
else
echo "您输入了错误选项"
fi
}

while ((1))
do
echo ""
echo "这里展示了您服务器上的现有域名和启用的域名。"
echo "您现有的域名为:"
ls /etc/apache2/sites-available
echo "您已启用的域名为: "
ls /etc/apache2/sites-enabled
echo "[提示] 请选择您要的操作: (1~2)"
select dm in  '增加域名' '删除域名'; do break; done
DomainManage
echo -n "是否继续操作?回车继续，输入n回车退出。"
read choice
if [ "$choice" == 'n' ]; then
echo "感谢您使用域名管理脚本。"
exit
fi
done
