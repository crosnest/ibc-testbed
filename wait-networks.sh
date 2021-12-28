##
## Wait for networks to be up and running
##

. ibc-testbed/.env

i=30
while [ $i -ge 0 ]; do
    ok=0
    if lumd status --node $LUM_RPC &>/dev/null; then
        ok=$((ok + 1))
    fi
    if osmosisd status --node $OSMOSIS_RPC &>/dev/null; then
        ok=$((ok + 1))
    fi
    if kid status --node $KID_RPC &>/dev/null; then
        ok=$((ok + 1))
    fi
    if gaiad status --node $COSMOS_RPC &>/dev/null; then
        ok=$((ok + 1))
    fi

    if [ "$ok" = "4" ]; then
        exit 0
    fi

    i=$((i - 1))
    sleep 1
done

exit 1
