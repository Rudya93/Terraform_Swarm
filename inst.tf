/* Setup our aws provider */
provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}
resource "aws_instance" "master" {
  ami           = "ami-5daa463a"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.swarm.name}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  connection {
    user = "ubuntu"
    key_file = "/home/ubuntu/olrudenk.pem"
  }
 # This is where we configure the instance with ansible-playbook
    provisioner "local-exec" {
 /* provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apt-transport-https ca-certificates",
      "sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D",
      "sudo sh -c 'echo \"deb https://apt.dockerproject.org/repo ubuntu-trusty main\" > /etc/apt/sources.list.d/docker.list'",
      "sudo apt-get update",
      "sudo apt-get install -y docker-engine=1.12.0-0~trusty",
      "sudo docker swarm init",
      "sudo docker swarm join-token --quiet worker > /home/ubuntu/token"
    ]
  }
  provisioner "file" {
    source = "proj"
    destination = "/home/ubuntu/"
  }*/
  tags = { 
    Name = "olrudenk_swarm-master"
  }
}

resource "aws_instance" "slave" {
  count         = 2
  ami           = "ami-5daa463a"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.swarm.name}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  connection {
    user = "ubuntu"
    key_file = "/home/ubuntu/olrudenk.pem"
  }
 /* provisioner "file" {
    source = "key.pem"
    destination = "/home/ubuntu/key.pem"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apt-transport-https ca-certificates",
      "sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D",
      "sudo sh -c 'echo \"deb https://apt.dockerproject.org/repo ubuntu-trusty main\" > /etc/apt/sources.list.d/docker.list'",
      "sudo apt-get update",
      "sudo apt-get install -y docker-engine=1.12.0-0~trusty",
      "sudo chmod 400 /home/ubuntu/test.pem",
      "sudo scp -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i test.pem ubuntu@${aws_instance.master.private_ip}:/home/ubuntu/token .",
      "sudo docker swarm join --token $(cat /home/ubuntu/token) ${aws_instance.master.private_ip}:2377"
    ]
  }*/
  tags = { 
    Name = "olrudenk_swarm-${count.index}"
  }
}
