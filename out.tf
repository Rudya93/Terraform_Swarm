output "master.ip" {
  value = "${aws_instance.master.public_ip}"
}

output "swarm.ip" {
  value = "${aws_instance.slave.*.public_ip}"
}

