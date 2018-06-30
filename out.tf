output "master.ip" {
  value = "${aws_instance.master.public_ip}"
}

output "swarm0.ip" {
  value = "${aws_instance.slave0.public_ip}"
}
output "swarm1.ip" {
  value = "${aws_instance.slave1.public_ip}"
}
