# Kitty Low A01273256
# ACIT 4640 - A03

To bring everything up, run setup.sh. This script runs the terraform configurations in /backend and /infrastructure and the ansible playbook in /service. The web DNS will be outputted and you can copy and paste it into a browser.
```bash setup.sh```

To bring everything down, run destroy.sh. This script destroys terraform.
```bash destroy.sh```