resource "aws_key_pair" "dove-key" {
  key_name   = "dove-key"
  public_key = "public key generated using ssh-keygen"
}
