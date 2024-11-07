# TP CloudWatchEventInstance<br><br>

**Ce projet à pour but de recevoir un mail lorsque l'on démarre ou stoppe une instance EC2 AWS en Terraform**<br><br>

## Pré-requis pour lancer le projet (Debian 12)<br><br>

>Installation AWS CLI & Terraform<br>
'sudo apt update && sudo apt upgrade -y'<br>
'sudo apt install curl'<br>
'curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"'<br>
'sudo apt-get install unzip'<br>
'unzip awscliv2.zip'<br>
'sudo ./aws/install'<br>
'sudo apt install -y gnupg software-properties-common'<br>
'wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg'<br>
'echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list'<br>
'sudo apt install terraform -y'<br><br>

## Vérfier l'installation<br><br>

'terraform -v'<br>
'aws -v'<br><br>

## Configurer l'environnement<br><br>

'aws configure'
'terraform init'

## Lancer le projet

'terraform apply'

