section "Internet"

echo -n "Internet: "
if ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1; then
    ok
else
    fail
fi

echo -n "DNS: "
if ping -c 1 -W 2 google.com >/dev/null 2>&1; then
    ok
else
    fail
fi
