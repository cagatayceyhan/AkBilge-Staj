#! /bin/bash

echo 
echo -------------------------------------------
echo "                  Menü                    "
echo -------------------------------------------
echo 

echo "Lütfen Bir Seçim Yapınız"

select menu in "Kullanıcı İşlemleri" "Sistem Bilgilerini Sorgulama" "Çıkış"
do

if [ "$menu" == "Kullanıcı İşlemleri" ] 
then
echo -e "[1] Kullanıcı Ekle"
echo
echo -e "[2] Kullanıcı Sil"
echo
echo -e "[3] Kullanıcıyı Bir Gruba Ekle"
echo
echo -e "[4] Kullanıcıyı Bir Gruptan Sil"
echo
echo -e "[5] Ana Menuye Geri Dön"

read menuk

if [ "$menuk" == 1 ]
then


if [ $(id -u) == 0 ]
then 
read -p "Yeni Kullanıcı Adını Giriniz: " username
read -p "Yeni bir Parola oluşturunuz: " password
egrep "^username" /etc/passwd > /dev/null



if [ $? -eq 0 ]
  then
  echo "$username Bulunmaktadır!"
exit 1
  else
    pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
    useradd -m -p $pass $username
    [ $? -eq 0 ] && echo "Yeni Kullanıcı Oluşturuldu" || "Yeni Kullanıcı Oluşturulamadı!!"
fi

else
echo "Kullanıcı Eklemek İçin Lütfen ROOT Yetkisi Alın."
exit 2
fi
 fi

 if [ "$menuk" == 2 ]
 then
  if [ $(id -u) == 0 ]
   then
    read -p "Silmek İstediğiniz Kullanıcı Adını Giriniz: " username
    userdel -r $username 
    echo "Silme İşlemi Başarılı"

    else 
        echo "Kullanıcı Silmek İçin Lütfen ROOT Yetkisi Alın."
        exit 1
fi
  fi

if [ "$menuk" == 3 ]
 then
  if [ $(id -u) == 0 ] 
  then
  read -p "Grup Kullanıcısının İsmini Giriniz: " kullanici_adi
  read -p "Oluşturulacak Grubun İsmini Giriniz: " grup_adi
  usermod -G $grup_adi $kullanici_adi
  echo "Grup Oluşturma İşlemi Başarılı."
  else 
  echo "Grup Oluşturulamadı"
  exit 1
  fi
  fi

  if [ "$menuk" == 4 ]
   then
     if [ $(id -u) == 0 ] 
     then 
     read -p "Silmek İstadiğiniz Grup Kullanıcısının İsmini Giriniz: " kallanici_adi
     read -p "Kullanıcıyı Silmek İstediğiniz Grup İsmini Giriniz: " grup_adi
     deluser $kullanici_adi $grup_adi
     echo "Silme İşlemi Gerçekleştirildi"
     else 
     echo "Silme İşlemi Başarısız!!"
     exit 1
     fi
     fi 

  if [ "$meruk" == 5 ]
  then
      echo  ""
      else
      echo "Ana Menüye Dönmek için Enter 'a basın"
fi

elif [ "$menu" == "Sistem Bilgilerini Sorgulama" ]
then
echo  -e "[1] Kullanıcı Yetkileri"
echo
echo  -e "[2] Kernel Bilgisi"
echo
echo  -e "[3] Arkada Çalışan İşlemler"
echo
echo  -e "[4] Dinlenen Portlar" 
echo
echo  -e "[5] Kullanıcının Yazma İzni Olduğu Programlar"
echo
echo  -e "[6] Ana Menüye Geri Dön "

read menus

if [ "$menus" == 1 ]
then
  read -p "Yetkisini Sorgulamak İstediğiniz Kullanıcı İsmini Giriniz: " kullanici_adi
  sudo -l -U $kullanici_adi
  else
  echo ""
fi

if [ "$menus" == 2 ]
then
echo "Tüm Kernel Bilgisi"
uname -a
else
echo ""
fi

if [ "$menus" == 3 ]
then 
echo "Arkada Çalışan İşlemler"
ps -aux
else
echo ""
fi 

if [ "$menus" == 4 ]
then
echo "Dinlenen Portlar"
netstat -tul
else
echo ""
fi

  if [ "$menus" == 5 ]
  then
    read -p " Kullanıcının Yazma İznini Sorgulamak İçin Kullanıcı Adı Giriniz : " kullanici_adi
    find / -user $kullanici_adi -perm -u=w  
  else
  echo ""
  fi

  if [ "$merus" == 6 ]
  then
      echo  ""
      else
      echo "Ana Menüye Dönmek için Enter 'a basın"
fi





else [ "$menu" == "Çıkış" ] 
    echo "Hoşça kal!"
exit 0

fi

done



