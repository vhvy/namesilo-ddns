# Namesilo DDNS

This is a simple namesilo DDNS(Dynamic Domain Name Server) script, IPv4/v6 support, I only tested it on debian 10 and macOS 14.

# xmllint

This script requires xmllint.

Debian:
```
sudo apt install libxml2-utils
```

macOS:
```
brew install libxml2
```

# How to use


- Modify the script and enter your API key, which is available at https://www.namesilo.com/account/api-manager
- Modify the script and enter your domain and host.
- Give the script run permissions, `chmod +x namesilo_ddns.sh`.
- Regular updates are enabled and performed hourly
```
crontab -e
0 * * * * /bin/bash /your.path/namesilo_ddns.sh
```