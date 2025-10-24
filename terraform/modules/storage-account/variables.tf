variable "resource_group_name" {
  type        = string
  description = "اسم Resource Group"
}

variable "location" {
  type        = string
  description = "الموقع (المنطقة)"
}

variable "storage_account_name" {
  type        = string
  description = "اسم حساب التخزين (أحرف صغيرة فقط)"
}

variable "container_name" {
  type        = string
  description = "اسم الحاوية داخل التخزين"
}

variable "tags" {
  type        = map(string)
  description = "الوسوم"
  default     = {}
}
