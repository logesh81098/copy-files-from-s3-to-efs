#############################################################################################################
#                                   Creating Lambda
#############################################################################################################

#Note: lambda requires IAM permission to get object from S3 and efsclientwrite permission to copy files to EFS, So before going with lambda creating IAM role

resource "aws_lambda_function" "project-lambda" {
  function_name = "${var.project-name} lambda"
  runtime = "python3.8"
  handler = ""

}