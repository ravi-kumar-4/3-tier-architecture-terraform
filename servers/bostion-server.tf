resource "aws_instance" "bastion" {
    
    ami                         = var.image_id
    instance_type               = var.instance_type
    key_name                    =  var.key_name
    subnet_id                   =  var.public_subnet_ids[0]
    vpc_security_group_ids      = [aws_security_group.bastion_sg.id]  
    associate_public_ip_address = true
    tags ={
        Name = "bostion_server"
    }
}
output "bastion_ip_address" {                            
    value = aws_instance.bastion.public_ip          
} 