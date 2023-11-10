resource "aws_db_subnet_group" "database_subnet_group" {
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "database_instance" {
    db_name                = "postgress"
    engine                 = "postgres"
    instance_class         = "db.t3.micro"
    username               = var.db_user_name
    password               = var.db_password
    db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.id
    vpc_security_group_ids = [aws_security_group.database_sg.id]
    allocated_storage      = 20
    skip_final_snapshot = true
}

output "database_endpoint" {
    value = aws_db_instance.database_instance.address
}
