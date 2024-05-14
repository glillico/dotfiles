LFILE="/etc/os-release"
MFILE="/System/Library/CoreServices/SystemVersion.plist"

if [[ -f ${LFILE} ]]; then
  _distro=$(awk '/^ID=/' ${LFILE} | awk -F'=' '{ print tolower($2) }')
elif [[ -f ${MFILE} ]]; then
  _distro="macos"
fi

case ${_distro} in
    *debian*)                ICON="";;
    *raspbian*)              ICON="";;
    *ubuntu*)                ICON="";;
    *fedora*)                ICON="";;
    *centos*)                ICON="";;
    *opensuse*|*tumbleweed*) ICON="";;
    *rhel*)                  ICON="";;
    *rocky*)                 ICON="";;
    *almalinux*)             ICON="";;
    *macos*)                 ICON="";;
    *)                       ICON="";;
esac

export PROMPT_DISTRO="$ICON"
