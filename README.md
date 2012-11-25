## AllPlayers.com Bootstrap Theme

[LESS](http://lesscss.org) assets that are suitable for themeing "external" AllPlayers.com (AP) related sites. Specifically: note these are bootstrap overrides in order to build a consistent look and feel conforming to AP styles.

### Building

`make default`

See http://stackoverflow.com/questions/10451317/twitter-bootstrap-customization-best-practices

### Notes

Encrypt (in 'chunks') a private key for deployment through travisci env vars:

```sh
export i=0
cat id_rsa | grep -v "\-\-\-\-" | while read line
  do
    echo "IDRSA_PRIV_ENV$i"
    travis encrypt AllPlayers/allplayers-theme IDRSA_PRIV_ENV$i=$line | grep "secure:"
    i=$((i+1))
  done
```


### Attribution

*  https://github.com/twitter/bootstrap
*  https://github.com/thomaspark/bootswatch/
