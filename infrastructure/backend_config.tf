terraform {
    backend "s3" {
        bucket         = "klbcit-a03-tf-state-2023-12"
        key            = "terraform.tfstate"
        dynamodb_table = "klbcit-a03-tf-state-lock-2023-12"
        region         = "us-west-2" 
        encrypt        = true
    }
}
