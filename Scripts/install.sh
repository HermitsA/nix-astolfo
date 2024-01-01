while true; do
    read -p "Do you have an nvidia card? " yn
    case $yn in
        [Yy]* ) export NV=yes; break;; 
        [Nn]* ) export NV=no; break;;
    esac
done
