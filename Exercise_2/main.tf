terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "udacity"
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = "my-lambda-function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "greet_lambda.lambda_handler"
  runtime          = "python3.8"
  filename         = "greet_lambda.zip"
  source_code_hash = filebase64sha256("greet_lambda.zip")
  environment {
    variables = {
      greeting = "Udacity"
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}
