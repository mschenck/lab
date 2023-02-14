output "mgmt_ips" {
    value = aws_network_interface.mgmt[*]
}

output "proxy_ips" {
    value = aws_network_interface.proxy[*]
}