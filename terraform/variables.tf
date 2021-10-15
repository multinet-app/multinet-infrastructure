variable "MULTINET_ARANGO_PASSWORD" {
    type = string
    sensitive = true
}

variable "MULTINET_ARANGO_READONLY_PASSWORD" {
    type = string
    sensitive = true
}

variable "AWS_ACCESS_KEY_ID" {
    type = string
    sensitive = true
}

variable "AWS_SECRET_ACCESS_KEY" {
    type = string
    sensitive = true
}

variable "HEROKU_API_KEY" {
    type = string
    sensitive = true
}

variable "HEROKU_EMAIL" {
    type = string
    sensitive = true
}
