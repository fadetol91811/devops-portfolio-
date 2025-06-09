#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🔧 Updating packages..."
sudo apt update -y
sudo apt upgrade -y

echo "📦 Installing dependencies..."
sudo apt install -y curl gnupg2 software-properties-common unzip

echo "☕ Installing Java 17 (OpenJDK)..."
sudo apt install -y openjdk-17-jdk

echo "📌 Setting JAVA_HOME and updating PATH..."
echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" | sudo tee -a /etc/environment
echo "export PATH=\$JAVA_HOME/bin:\$PATH" | sudo tee -a /etc/environment
echo "JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" | sudo tee -a ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" | sudo tee -a ~/.bashrc
source ~/.bashrc

echo "🔐 Importing Jenkins GPG key (2023 version)..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "🧾 Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "🔄 Updating packages again..."
sudo apt update -y

echo "⬇️ Installing Jenkins..."
sudo apt install -y jenkins

echo "🛠️ Configuring Jenkins environment..."
sudo sed -i "s|^JAVA_HOME=.*|JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64|" /etc/default/jenkins

echo "🔄 Reloading systemctl & restarting Jenkins..."
sudo systemctl daemon-reexec
sudo systemctl restart jenkins
sudo systemctl enable jenkins

echo "✅ Verifying Jenkins service status..."
sudo systemctl status jenkins | grep Active

echo "🧪 Checking Java version..."
java -version

echo "🟢 Jenkins + Java setup complete. Access Jenkins via: http://<your-ec2-public-ip>:8080"
echo "🔑 To get the admin password:"
echo "    sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
