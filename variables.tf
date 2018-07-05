variable "access_key" {
	default = "YOUR_ACCESS_KEY"
}
variable "secret_key" {
	default = "YOUR_SECRET_KEY"
}
variable "region" {
    default = "your-region"
}
variable "ami" {
    default = "ami"
}
variable "key" {
    default = "key"
}
variable "subn" {
    default = "subn"
}
variable "ips" {
    default = {
        "0" = "10.244.0.11"
        "1" = "10.244.0.12"
        }
}
variable "pk" {
    default = "/home/ubuntu/**.pem"
}
