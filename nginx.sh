#!/bin/bash

set -e

# Log all output
exec > >(tee -a /var/log/nginx-deploy.log) 2>&1

echo "🌐 Updating packages..."
sudo apt-get update -y
sudo apt-get install -y nginx

echo "✅ Nginx installed. Version:"
nginx -v

# Enable and start nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Create website directory
WEB_DIR="/var/www/html"
echo "📁 Setting up website in ${WEB_DIR}"

# Backup default index.html if exists
[ -f "${WEB_DIR}/index.nginx-debian.html" ] && sudo mv "${WEB_DIR}/index.nginx-debian.html" "${WEB_DIR}/index.backup.html"

# Create new index.html
cat <<EOF | sudo tee ${WEB_DIR}/index.html > /dev/null
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to My Website</title>
</head>
<body>
    <h1>🚀 Deployed via Nginx!</h1>
    <p>This page was deployed by a Bash script.</p>
</body>
</html>
EOF

echo "✅ Website deployed at: http://$(curl -s http://checkip.amazonaws.com)"

# Adjust permissions
sudo chown -R www-data:www-data ${WEB_DIR}

# Reload nginx to apply changes
sudo systemctl reload nginx

echo "🎉 Deployment complete!"

