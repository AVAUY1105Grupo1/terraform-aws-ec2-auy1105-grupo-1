resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = var.tls_key_bits
}

resource "aws_key_pair" "deployer_key" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.rsa_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.rsa_key.private_key_pem
  filename        = var.ssh_key_filename
  file_permission = "0400"
}

data "aws_ami" "ubuntu_24_04" {
  most_recent = true
  owners      = var.ami_owner
  filter {
    name   = "name"
    values = var.ami_name_filter
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu_24_04.id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = aws_key_pair.deployer_key.key_name

  tags = { Name = var.ec2_instance_name }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y apache2",
      "sudo systemctl enable apache2",
      "sudo systemctl start apache2",
      <<-SCRIPT
      sudo tee /var/www/html/index.html > /dev/null << 'EOF'
      <!doctype html>
      <html lang="es">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>VampireNightXX - Vaska HTML Simple Test File.</title>
        <style>
          :root{ --bg-color: #000000; --header-color: #FF00FF; --text-color: #FFFFFF; }
          html, body { height: 100%; margin: 0; padding: 0; background: var(--bg-color); color: var(--text-color); font-family: Arial, sans-serif; }
          .container{ min-height:100%; display:flex; flex-direction:column; align-items:center; justify-content:space-between; padding:40px 20px; box-sizing:border-box; }
          header h1{ font-size:36px; color:var(--header-color); text-align:center; }
          main p{ font-size:26px; color:var(--text-color); text-align:center; }
          footer{ width:100%; text-align:center; padding:20px 10px; border-top:1px solid rgba(255,255,255,0.06); }
          footer .line{ display:block; color:var(--text-color); font-size:24px; margin:6px 0; }
          footer a{ color:var(--text-color); }
        </style>
      </head>
      <body>
        <div class="container">
          <header><h1>Felicitaciones!</h1></header>
          <main><p>Si ves o lees este mensaje, significa que tu servidor web esta funcionando de forma correcta.</p></main>
          <footer>
            <span class="line">Archivo HTML de prueba creado por VampireNightXX.</span>
            <span class="line"><a href="https://github.com/vampirenightxx" target="_blank">https://github.com/vampirenightxx</a></span>
          </footer>
        </div>
      </body>
      </html>
      EOF
      SCRIPT
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_connect_user
      private_key = tls_private_key.rsa_key.private_key_pem
      host        = self.public_ip
    }
  }
}
