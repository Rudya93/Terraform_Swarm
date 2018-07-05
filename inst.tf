/* Setup our aws provider */
provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}
resource "aws_instance" "master" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id = "${var.subn}"
  key_name = "${var.key}"
  associate_public_ip_address = true
  private_ip = "10.244.0.10"
 

  connection {
    user = "ubuntu"
    private_key = "${file("/home/ubuntu/olrudenk.pem")}"
  }

  tags = {
    Name = "olrudenk_swarm-master"
  }
}

resource "aws_instance" "slave" {
  count         = 2
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id = "${var.subn}"
  key_name = "${var.key}"
  private_ip = "${lookup(var.ips,count.index)}"


  connection {
    user = "ubuntu"
    private_key = "${file("/home/ubuntu/olrudenk.pem")}"
  }

  tags = {
    Name = "olrudenk_swarm-${count.index}"
  }
}
resource "null_resource" "ansible" {
  provisioner "local-exec" {
  command = "sleep 120; ansible-playbook -u ubuntu --private-key '${var.pk}' -i hosts play.yml"
  }
}



